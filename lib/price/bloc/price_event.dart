part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class GetSymbol extends PriceEvent {
  const GetSymbol({
    required this.symbolModel,
  });

  final SymbolModel symbolModel;

  @override
  List<Object> get props => [symbolModel];
}

class StartOpenSymbolConnection extends PriceEvent {}

class GetFisset extends PriceEvent {
  const GetFisset({
    required this.submarket,
  });

  final String submarket;

  @override
  List<Object> get props => [submarket];
}

class StartOpenTicksConnection extends PriceEvent {
  const StartOpenTicksConnection({
    required this.symbol,
  });

  final String symbol;

  @override
  List<Object> get props => [symbol];
}

class GetTicks extends PriceEvent {
  const GetTicks(this.ticksModel);

  final TicksModel ticksModel;

  @override
  List<Object> get props => [ticksModel];
}

class ForgetConnection extends PriceEvent {
  const ForgetConnection(this.reqId);

  final String reqId;
  @override
  List<Object> get props => [reqId];
}
