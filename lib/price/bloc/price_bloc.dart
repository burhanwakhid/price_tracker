import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc({
    required PriceRepository priceRepository,
  })  : _priceRepository = priceRepository,
        super(const PriceState.initial()) {
    on<StartOpenSymbolConnection>(_startOpenSymbolConnection);
    on<GetSymbol>(_getSymbol);
    on<GetFisset>(_getFisset);
    on<StartOpenTicksConnection>(_startOpenTickConnection);
    on<GetTicks>(_getTicks);
    on<ForgetConnection>(_forgetConnection);
  }

  List<ActiveSymbol>? _symbolModel;

  StreamSubscription<SymbolModel>? _symbolSubscription;
  StreamSubscription<TicksModel>? _tickSubscription;

  final PriceRepository _priceRepository;

  @override
  Future<void> close() {
    _symbolSubscription?.cancel();
    _tickSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _getSymbol(
    GetSymbol event,
    Emitter<PriceState> emit,
  ) {
    _symbolModel = List.generate(
      event.symbolModel.activeSymbols.length,
      (index) => event.symbolModel.activeSymbols[index].copyWith(),
    );
    final ids = event.symbolModel.activeSymbols.map((e) => e.submarket).toSet();
    event.symbolModel.activeSymbols.retainWhere((x) => ids.remove(x.submarket));

    emit(state.copyWith(symbolModel: event.symbolModel));
  }

  FutureOr<void> _startOpenSymbolConnection(
    StartOpenSymbolConnection event,
    Emitter<PriceState> emit,
  ) {
    _priceRepository.openSymbolConnection();

    _symbolSubscription?.cancel();

    _symbolSubscription = _priceRepository.getSymbol().listen((event) {
      add(GetSymbol(symbolModel: event));
    });
  }

  FutureOr<void> _getFisset(
    GetFisset event,
    Emitter<PriceState> emit,
  ) {
    if (state.ticksModel != null) {
      add(ForgetConnection(state.ticksModel!.subscription?.id ?? ''));
    }

    if (state.fisset != null) {
      emit(
        PriceState.destroyfisset(
          symbolModel: state.symbolModel,
          ticksModel: state.ticksModel,
          previousPrice: state.previousPrice,
          currentPrice: state.currentPrice,
        ),
      );
    }

    final fisset = _symbolModel!
        .where((element) => element.submarket == event.submarket)
        .toList();

    emit(
      state.copyWith(
        fisset: SymbolModel(
          activeSymbols: List.generate(
            fisset.length,
            (index) => fisset[index].copyWith(),
          ),
        ),
      ),
    );
  }

  FutureOr<void> _startOpenTickConnection(
    StartOpenTicksConnection event,
    Emitter<PriceState> emit,
  ) {
    if (state.ticksModel != null) {
      add(ForgetConnection(state.ticksModel!.subscription?.id ?? ''));
    }

    emit(state.copyWith(selectedValue: event.symbol));
    _priceRepository.openTicksConnection(event.symbol);

    _symbolSubscription?.cancel();

    _tickSubscription = _priceRepository.getTicks().listen((event) {
      add(GetTicks(event));
    });
  }

  FutureOr<void> _getTicks(
    GetTicks event,
    Emitter<PriceState> emit,
  ) {
    emit(
      state.copyWith(
        ticksModel: event.ticksModel,
        previousPrice: state.previousPrice == null
            ? event.ticksModel.tick.quote
            : state.currentPrice,
        currentPrice: event.ticksModel.tick.quote,
      ),
    );
  }

  FutureOr<void> _forgetConnection(
    ForgetConnection event,
    Emitter<PriceState> emit,
  ) {
    _priceRepository.openForgetConnection(event.reqId);
  }
}
