import 'dart:async';
import 'dart:convert';

import 'package:price_api/price_api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceApi {
  final _symbolSocket = WebSocketChannel.connect(
    Uri.parse(
      'wss://green.binaryws.com/websockets/v3?app_id=31063&l=EN&brand=deriv',
    ),
  );
  final _ticksSocket = WebSocketChannel.connect(
    Uri.parse(
      'wss://green.binaryws.com/websockets/v3?app_id=31063&l=EN&brand=deriv',
    ),
  );
  final _forgetSocket = WebSocketChannel.connect(
    Uri.parse(
      'wss://green.binaryws.com/websockets/v3?app_id=31063&l=EN&brand=deriv',
    ),
  );

  Stream<SymbolModel> get getSymbol => _symbolSocket.stream
      .map<SymbolModel>((event) => SymbolModel.fromJson(jsonDecode(event)));

  Stream<TicksModel> get getTicks => _ticksSocket.stream
      .map<TicksModel>((event) => TicksModel.fromJson(jsonDecode(event)));

  void openSymbolConnection() {
    final data = jsonEncode({
      "active_symbols": "brief",
      "product_type": "basic",
    });
    _symbolSocket.sink.add(data);
  }

  void closeSymbolConnection() {
    _symbolSocket.sink.close();
  }

  void openTickConnection(String symbol) {
    final data = jsonEncode({
      "ticks": symbol,
      "subscribe": 1,
    });
    _ticksSocket.sink.add(data);
  }

  void closeTickConnection() {
    _ticksSocket.sink.close();
  }

  void openForgetConnection(String reqId) {
    final data = jsonEncode({
      "forget": reqId,
    });
    _forgetSocket.sink.add(data);
  }

  void closeForgetConnection() {
    _forgetSocket.sink.close();
  }
}
