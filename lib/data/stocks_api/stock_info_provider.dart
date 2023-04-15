import 'package:time_machine/data/stocks_api/stock_dto.dart';

/// Interface for fetching stock information.
abstract class StockInfoProvider {
  Future<StockDto> fetchStock(String ticker);
}
