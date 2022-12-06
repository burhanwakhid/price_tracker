// To parse this JSON data, do
//
//     final ticksModel = ticksModelFromJson(jsonString);

import 'dart:convert';

TicksModel ticksModelFromJson(String str) =>
    TicksModel.fromJson(json.decode(str));

String ticksModelToJson(TicksModel data) => json.encode(data.toJson());

class TicksModel {
  TicksModel({
    required this.echoReq,
    required this.msgType,
    required this.subscription,
    required this.tick,
  });

  final EchoReq echoReq;
  final String msgType;
  final Subscription? subscription;
  final Tick tick;

  factory TicksModel.fromJson(Map<String, dynamic> json) => TicksModel(
        echoReq: EchoReq.fromJson(json["echo_req"]),
        msgType: json["msg_type"],
        subscription: Subscription.fromJson(json["subscription"]),
        tick: Tick.fromJson(json["tick"]),
      );

  Map<String, dynamic> toJson() => {
        "echo_req": echoReq.toJson(),
        "msg_type": msgType,
        "subscription": subscription?.toJson(),
        "tick": tick.toJson(),
      };
}

class EchoReq {
  EchoReq({
    required this.subscribe,
    required this.ticks,
  });

  final int subscribe;
  final String ticks;

  factory EchoReq.fromJson(Map<String, dynamic> json) => EchoReq(
        subscribe: json["subscribe"],
        ticks: json["ticks"],
      );

  Map<String, dynamic> toJson() => {
        "subscribe": subscribe,
        "ticks": ticks,
      };
}

class Subscription {
  Subscription({
    required this.id,
  });

  final String id;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Tick {
  Tick({
    required this.ask,
    required this.bid,
    required this.epoch,
    required this.id,
    required this.pipSize,
    required this.quote,
    required this.symbol,
  });

  final double ask;
  final double bid;
  final int epoch;
  final String id;
  final int pipSize;
  final double quote;
  final String symbol;

  factory Tick.fromJson(Map<String, dynamic> json) => Tick(
        ask: json["ask"].toDouble(),
        bid: json["bid"].toDouble(),
        epoch: json["epoch"],
        id: json["id"],
        pipSize: json["pip_size"],
        quote: json["quote"].toDouble(),
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "ask": ask,
        "bid": bid,
        "epoch": epoch,
        "id": id,
        "pip_size": pipSize,
        "quote": quote,
        "symbol": symbol,
      };
}
