import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/di_providers.dart';

final stockImageProvider =
    FutureProvider.family<String, StockTicker>((ref, ticker) async {
  final service = ref.watch(stockInfoServiceProvider);
  final stockDto = await service.fetchStock(
    ticker.toString().split('.').last.replaceAll('_', '.'),
  );
  return stockDto.logo;
});
