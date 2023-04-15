import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/stock_choose/stock_chooser.dart';
import 'package:time_machine/data/models/stock.dart';

final stockChooseProvider =
    StateNotifierProvider<StockChooser, Map<StockTicker, bool>>(
        (ref) => StockChooser(StockTicker.values));
