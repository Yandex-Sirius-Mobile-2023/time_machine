import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';

class StockChooser extends StateNotifier<Map<StockTicker, bool>> {
  final Map tickersState;

  StockChooser(List<StockTicker> ticker)
      // For each element of ticker create false value in map.
      : tickersState = ticker.fold(
          {},
          (previousValue, element) => previousValue..[element] = false,
        ),
        super({}) {
    state = Map.unmodifiable(tickersState);
  }

  /// Select/Unselect ticker.
  void updateTicker(StockTicker ticker) {
    tickersState[ticker] = !tickersState[ticker]!;
    // Notify listeners
    state = Map.unmodifiable(tickersState);
  }

  // List of choosen tickers.
  List<StockTicker> get choosen => state.keys.where((key) => state[key]!).toList();
}
