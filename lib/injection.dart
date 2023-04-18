import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/services/stock_service.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';

final stockServiceProvider = Provider<StockService>(
  (ref) => StockServiceImpl(),
);
