import 'package:time_machine/data/stocks_api/stock_dto.dart';

abstract class StockInfoProvider {
  Future<StockDto> fetchStock(String ticker);
}
