import 'package:price_api/price_api.dart';

class PriceRepository {
  PriceRepository({
    PriceApi? priceApi,
  }) : _priceApi = priceApi ?? PriceApi();

  final PriceApi _priceApi;

  Stream<SymbolModel> getSymbol() {
    return _priceApi.getSymbol;
  }

  void openSymbolConnection() {
    _priceApi.openSymbolConnection();
  }

  void closeSymbolConnection() {
    _priceApi.closeSymbolConnection();
  }

  Stream<TicksModel> getTicks() {
    return _priceApi.getTicks;
  }

  void openTicksConnection(String symbol) {
    _priceApi.openTickConnection(symbol);
  }

  void closeTicksConnection() {
    _priceApi.closeTickConnection();
  }

  void openForgetConnection(String reqId) {
    _priceApi.openForgetConnection(reqId);
  }

  void closeForgetConnection() {
    _priceApi.closeForgetConnection();
  }
}
