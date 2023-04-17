import 'package:logging/logging.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';
import 'package:time_machine/data/stocks_api/stock_dto.dart';
import 'package:time_machine/data/stocks_api/stock_info_provider.dart';

Logger logger = Logger("StockApiRepository");

class StockApiRepository implements StockInfoProvider {
  final FinhubApi api;
  Map<String, String> tickersLogoUrl = {};

  StockApiRepository(this.api);

  @override
  Future<StockDto> fetchStock(String ticker) async {
    if (tickersLogoUrl.containsKey(ticker)) {
      return StockDto(
        ticker: ticker,
        logo: tickersLogoUrl[ticker]!,
      );
    } else {
      var res = await api.fetchStock(ticker);
      tickersLogoUrl[ticker] = res.logo;
      return res;
    }
  }
}
