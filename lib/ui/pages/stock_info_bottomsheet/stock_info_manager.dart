import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service.dart';
import 'package:time_machine/injection.dart';
import 'package:time_machine/ui/pages/stock_info_bottomsheet/stock_info_state.dart';

class StockInfoManager extends StateNotifier<StockInfoState> {
  final UserStockRepository _userStockRepository;
  final StockService _stockService;

  StockInfoManager(
    this._stockService,
    this._userStockRepository,
  ) : super(const StockInfoState.loading());

  void incrementStock() {
    final newCount = state.maybeMap<int>(
      content: (state) => state.boughtStockCount + 1,
      orElse: () => throw Exception('Unexpected state'),
    );
    setStockCount(newCount);
  }

  void decrementStock() {
    final newCount = state.maybeMap<int>(
      content: (state) => state.boughtStockCount - 1,
      orElse: () => throw Exception('Unexpected state'),
    );
    setStockCount(newCount);
  }

  void setStockCount(int newCount) {
    state.maybeWhen(
      content: (stock, _) async {
        state = const StockInfoState.loading();
        await _userStockRepository.setStockCount(stock.ticker, newCount);
        state = StockInfoState.content(
          stock: stock,
          boughtStockCount: newCount,
        );
      },
      orElse: () => throw Exception('Unexpected state'),
    );
  }

  void loadStocks(StockTicker ticker) async {
    state = const StockInfoState.loading();

    final awaited = await Future.wait([
      _stockService.getStock(ticker),
      _userStockRepository.getStockCount(ticker),
    ]);

    state = StockInfoState.content(
      stock: awaited[0] as Stock,
      boughtStockCount: awaited[1] as int,
    );
  }
}

final stockInfoProvider =
    StateNotifierProvider<StockInfoManager, StockInfoState>(
  (ref) => StockInfoManager(
    ref.watch(stockServiceProvider),
    ref.watch(userStockRepositoryProvider),
  ),
);

//TODO убрать
//TODO заглушка с примерным интерфейсом репозитория акций пользователя
abstract class UserStockRepository {
  Future<void> setStockCount(StockTicker ticker, int count);
  Future<int> getStockCount(StockTicker ticker);
}

//TODO реализовать
final userStockRepositoryProvider =
    Provider<UserStockRepository>((ref) => throw Exception('unimplemented'));
