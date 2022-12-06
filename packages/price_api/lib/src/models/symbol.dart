// To parse this JSON data, do
//
//     final symbolModel = symbolModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

SymbolModel symbolModelFromJson(String str) =>
    SymbolModel.fromJson(json.decode(str));

String symbolModelToJson(SymbolModel data) => json.encode(data.toJson());

class SymbolModel {
  SymbolModel({
    required this.activeSymbols,
  });

  final List<ActiveSymbol> activeSymbols;

  factory SymbolModel.fromJson(Map<String, dynamic> json) => SymbolModel(
        activeSymbols: List<ActiveSymbol>.from(
            json["active_symbols"].map((x) => ActiveSymbol.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active_symbols":
            List<dynamic>.from(activeSymbols.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SymbolModel &&
        listEquals(other.activeSymbols, activeSymbols);
  }

  @override
  int get hashCode => activeSymbols.hashCode;

  SymbolModel copyWith({
    List<ActiveSymbol>? activeSymbols,
  }) {
    return SymbolModel(
      activeSymbols: activeSymbols ?? this.activeSymbols,
    );
  }
}

class ActiveSymbol {
  ActiveSymbol({
    required this.allowForwardStarting,
    required this.displayName,
    required this.displayOrder,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.subgroup,
    required this.subgroupDisplayName,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });

  final int allowForwardStarting;
  final String displayName;
  final int displayOrder;
  final int exchangeIsOpen;
  final int isTradingSuspended;
  final String market;
  final String marketDisplayName;
  final double pip;
  final String subgroup;
  final String subgroupDisplayName;
  final String submarket;
  final String submarketDisplayName;
  final String symbol;
  final String symbolType;

  factory ActiveSymbol.fromJson(Map<String, dynamic> json) => ActiveSymbol(
        allowForwardStarting: json["allow_forward_starting"],
        displayName: json["display_name"],
        displayOrder: json["display_order"],
        exchangeIsOpen: json["exchange_is_open"],
        isTradingSuspended: json["is_trading_suspended"],
        market: json["market"],
        marketDisplayName: json["market_display_name"],
        pip: json["pip"].toDouble(),
        subgroup: json["subgroup"],
        subgroupDisplayName: json["subgroup_display_name"],
        submarket: json["submarket"],
        submarketDisplayName: json["submarket_display_name"],
        symbol: json["symbol"],
        symbolType: json["symbol_type"],
      );

  Map<String, dynamic> toJson() => {
        "allow_forward_starting": allowForwardStarting,
        "display_name": displayName,
        "display_order": displayOrder,
        "exchange_is_open": exchangeIsOpen,
        "is_trading_suspended": isTradingSuspended,
        "market": market,
        "market_display_name": marketDisplayName,
        "pip": pip,
        "subgroup": subgroup,
        "subgroup_display_name": subgroupDisplayName,
        "submarket": submarket,
        "submarket_display_name": submarketDisplayName,
        "symbol": symbol,
        "symbol_type": symbolType,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActiveSymbol &&
        other.allowForwardStarting == allowForwardStarting &&
        other.displayName == displayName &&
        other.displayOrder == displayOrder &&
        other.exchangeIsOpen == exchangeIsOpen &&
        other.isTradingSuspended == isTradingSuspended &&
        other.market == market &&
        other.marketDisplayName == marketDisplayName &&
        other.pip == pip &&
        other.subgroup == subgroup &&
        other.subgroupDisplayName == subgroupDisplayName &&
        other.submarket == submarket &&
        other.submarketDisplayName == submarketDisplayName &&
        other.symbol == symbol &&
        other.symbolType == symbolType;
  }

  @override
  int get hashCode {
    return allowForwardStarting.hashCode ^
        displayName.hashCode ^
        displayOrder.hashCode ^
        exchangeIsOpen.hashCode ^
        isTradingSuspended.hashCode ^
        market.hashCode ^
        marketDisplayName.hashCode ^
        pip.hashCode ^
        subgroup.hashCode ^
        subgroupDisplayName.hashCode ^
        submarket.hashCode ^
        submarketDisplayName.hashCode ^
        symbol.hashCode ^
        symbolType.hashCode;
  }

  ActiveSymbol copyWith({
    int? allowForwardStarting,
    String? displayName,
    int? displayOrder,
    int? exchangeIsOpen,
    int? isTradingSuspended,
    String? market,
    String? marketDisplayName,
    double? pip,
    String? subgroup,
    String? subgroupDisplayName,
    String? submarket,
    String? submarketDisplayName,
    String? symbol,
    String? symbolType,
  }) {
    return ActiveSymbol(
      allowForwardStarting: allowForwardStarting ?? this.allowForwardStarting,
      displayName: displayName ?? this.displayName,
      displayOrder: displayOrder ?? this.displayOrder,
      exchangeIsOpen: exchangeIsOpen ?? this.exchangeIsOpen,
      isTradingSuspended: isTradingSuspended ?? this.isTradingSuspended,
      market: market ?? this.market,
      marketDisplayName: marketDisplayName ?? this.marketDisplayName,
      pip: pip ?? this.pip,
      subgroup: subgroup ?? this.subgroup,
      subgroupDisplayName: subgroupDisplayName ?? this.subgroupDisplayName,
      submarket: submarket ?? this.submarket,
      submarketDisplayName: submarketDisplayName ?? this.submarketDisplayName,
      symbol: symbol ?? this.symbol,
      symbolType: symbolType ?? this.symbolType,
    );
  }
}
