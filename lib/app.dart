import 'package:flutter/material.dart';
import 'package:time_machine/ui/samples/central_button_example_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/ui/pages/stock_choose/stock_choose_page.dart';
import 'package:time_machine/ui/pages/trading/trading_page.dart';
import 'package:time_machine/uikit/ui_text_theme.dart';
import 'package:time_machine/uikit/ui_theme.dart';
import 'package:time_machine/ui/pages/auth/auth_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var needSignIn =
        ProviderScope.containerOf(context).read(emailSignProvider).user == null;
    return MaterialApp(
      routes: {
        AppRoutes.loginURL: (_) => const AuthPage(),
        AppRoutes.chooseStockURL: (_) => const StockChoosePage(),
        AppRoutes.tradingUrl: (_) => const TradingPage()
      },
      initialRoute: needSignIn ? AppRoutes.loginURL : AppRoutes.chooseStockURL,
      theme: ThemeData(
        colorScheme: lightScheme,
      ),
      home: const Scaffold(
        body: Center(
          child: CentralButtonExampleWidget(),
        ),
      ),
    );
  }
}

abstract class AppRoutes {
  static const String loginURL = "/login";
  static const String chooseStockURL = "/choose_stock";
  static const String tradingUrl = "/trading";
}
