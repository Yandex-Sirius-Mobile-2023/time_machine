import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/data/services/stock_service.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';

import '../../data/models/stock.dart';

class PortfolioWidget extends ConsumerWidget {
  final Portfolio portfolio;
  const PortfolioWidget({Key? key, required this.portfolio,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(activePortfolioProvider(portfolio)) ;

    return Center(
      child: Column(
        children: [
          Text('Portfolio: ${state.portfolio.balance}'),
        ],
      ),
    );
  }
}
