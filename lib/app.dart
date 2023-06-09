import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/ui/pages/final/final_page.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';
import 'package:time_machine/ui/pages/stock_choose/stock_choose_page.dart';
import 'package:time_machine/ui/pages/trading/trading_page.dart';
import 'package:time_machine/ui/pages/auth/auth_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:time_machine/di_providers.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var needSignIn = ref.read(emailSignProvider).user == null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(languageProvider),
      routes: {
        AppRoutes.loginURL: (_) => const AuthPage(),
        AppRoutes.chooseStockURL: (_) => const StockChoosePage(),
        AppRoutes.tradingUrl: (_) => const TradingPage(),
        AppRoutes.profileUrl: (_) => const ProfilePage(),
        AppRoutes.finish: (context) => const FinalPage(),
      },
      initialRoute: needSignIn ? AppRoutes.loginURL : AppRoutes.profileUrl,
      theme: ref.watch(themeProvider),
    );
  }
}

abstract class AppRoutes {
  static const String loginURL = "/login";
  static const String chooseStockURL = "/choose_stock";
  static const String tradingUrl = "/trading";
  static const String profileUrl = "/profile";
  static const String finish = "/finish";
}
