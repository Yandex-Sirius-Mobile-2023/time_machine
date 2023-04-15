import 'package:logging/logging.dart';
import 'package:time_machine/data/stocks_api/api_errors.dart';
import 'package:time_machine/data/stocks_api/stock_info_provider.dart';
import 'package:time_machine/data/stocks_api/stock_dto.dart';
import 'package:dio/dio.dart';

class FinhubApi implements StockInfoProvider {
  final Logger logger = Logger("FinhubApi");
  final String apiKey;
  final Dio dio;

  FinhubApi(this.apiKey, Dio dio)
      : dio = dio
          ..options = BaseOptions(
            baseUrl: "https://finnhub.io/api/v1/stock/profile2",
          );

  @override
  Future<StockDto> fetchStock(String ticker) async {
    ticker = ticker.toUpperCase();
    // Empty json is returned if the ticker is invalid.
    Map<String, dynamic> json = {};
    try {
      var response = await dio.get(requestGetProfile(ticker));
      json = response.data;
    } on DioError catch (e) {
      logger.warning(e);
      throw const StockApiErrors.server();
    } catch (e, stackTrace) {
      // Unknown error
      logger.severe("Unsuccesful api request", e, stackTrace);
      rethrow;
    }

    // If the json is empty, the ticker is invalid.
    if (json.isEmpty) throw const StockApiErrors.invalidTicker();
    return StockDto.fromJson(json);
  }

  /// Returns a GET-request for information about the ticker.
  String requestGetProfile(String ticker) => "?symbol=$ticker&token=$apiKey";
}
