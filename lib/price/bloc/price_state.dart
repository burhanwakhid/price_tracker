part of 'price_bloc.dart';

enum TextColor { defaults, red, green }

class PriceState extends Equatable {
  const PriceState.__({
    this.symbolModel,
    this.fisset,
    this.ticksModel,
    this.currentPrice,
    this.previousPrice,
    this.selectedValue,
  });

  const PriceState.initial() : this.__();

  const PriceState.destroyfisset({
    SymbolModel? symbolModel,
    TicksModel? ticksModel,
    double? previousPrice,
    double? currentPrice,
    String? selectedValue,
  }) : this.__(
          symbolModel: symbolModel,
          ticksModel: ticksModel,
          previousPrice: previousPrice,
          currentPrice: currentPrice,
          fisset: null,
          selectedValue: selectedValue,
        );

  final SymbolModel? symbolModel;
  final SymbolModel? fisset;
  final TicksModel? ticksModel;
  final double? previousPrice;
  final double? currentPrice;
  final String? selectedValue;
  Color get textColor => _getTextColor();
  SymbolModel? get symbolFilter => getSymbolFilter();

  @override
  List<Object?> get props {
    return [
      symbolModel,
      fisset,
      ticksModel,
      previousPrice,
      currentPrice,
      selectedValue,
    ];
  }

  PriceState copyWith({
    SymbolModel? symbolModel,
    SymbolModel? fisset,
    TicksModel? ticksModel,
    double? previousPrice,
    double? currentPrice,
    String? selectedValue,
  }) {
    return PriceState.__(
      symbolModel: symbolModel ?? this.symbolModel,
      fisset: fisset ?? this.fisset,
      ticksModel: ticksModel ?? this.ticksModel,
      previousPrice: previousPrice ?? this.previousPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }

  Color _getTextColor() {
    if (previousPrice == null || previousPrice == currentPrice) {
      return Colors.grey;
    } else if (previousPrice! > currentPrice!) {
      return Colors.red;
    } else if (previousPrice! < currentPrice!) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  SymbolModel? getSymbolFilter() {
    if (symbolModel != null) {
      return symbolModel;
    } else {
      return null;
    }
  }
}
