import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_repository/price_repository.dart';
import 'package:price_tracker/price/price.dart';

class PricePage extends StatelessWidget {
  const PricePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriceBloc(
        priceRepository: context.read<PriceRepository>(),
      )..add(StartOpenSymbolConnection()),
      child: const PriceView(),
    );
  }
}

class PriceView extends StatelessWidget {
  const PriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _DropdownSymbol(),
            SizedBox(
              height: 12,
            ),
            _DropdownFisset(),
            SizedBox(
              height: 12,
            ),
            _PriceWidget()
          ],
        ),
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget();

  @override
  Widget build(BuildContext context) {
    final price =
        context.select((PriceBloc bloc) => bloc.state.ticksModel?.tick.quote);
    final color = context.select((PriceBloc bloc) => bloc.state.textColor);

    return price == null
        ? const SizedBox.shrink()
        : Text(
            'Price: $price',
            style: TextStyle(
              color: color,
            ),
          );
  }
}

class _DropdownFisset extends StatelessWidget {
  const _DropdownFisset();

  @override
  Widget build(BuildContext context) {
    final fisset = context.select((PriceBloc bloc) => bloc.state.fisset);
    final value = context.select((PriceBloc bloc) => bloc.state.selectedValue);

    return fisset == null
        ? const SizedBox.shrink()
        : DropdownButtonFormField(
            hint: const Text(
              'Select a Fisset',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 13,
                color: Color(0xffBDBDBD),
              ),
            ),
            elevation: 4,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 13,
                color: Color(0xffBDBDBD),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                gapPadding: 10,
              ),
            ),
            validator: (val) {
              if (val == null) {
                return 'Wajib diisi';
              }
              return null;
            },
            value: value,
            items: fisset.activeSymbols.map((e) {
              return DropdownMenuItem<String>(
                value: e.symbol,
                child: Text(e.displayName),
              );
            }).toList(),
            onChanged: (val) {
              FocusScope.of(context).requestFocus(FocusNode());

              context.read<PriceBloc>().add(
                    StartOpenTicksConnection(
                      symbol: val!,
                    ),
                  );
            },
          );
  }
}

class _DropdownSymbol extends StatelessWidget {
  const _DropdownSymbol();

  @override
  Widget build(BuildContext context) {
    final symbol = context.select((PriceBloc bloc) => bloc.state.symbolFilter);
    return symbol == null
        ? const LinearProgressIndicator()
        : DropdownButtonFormField(
            hint: const Text(
              'Select a Market',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 13,
                color: Color(0xffBDBDBD),
              ),
            ),
            elevation: 4,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 13,
                color: Color(0xffBDBDBD),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                gapPadding: 10,
              ),
            ),
            validator: (val) {
              if (val == null) {
                return 'Wajib diisi';
              }
              return null;
            },
            items: symbol.activeSymbols.map((e) {
              return DropdownMenuItem<ActiveSymbol>(
                value: e,
                child: Text(e.submarketDisplayName),
              );
            }).toList(),
            onChanged: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
              context
                  .read<PriceBloc>()
                  .add(GetFisset(submarket: val!.submarket));
            },
          );
  }
}
