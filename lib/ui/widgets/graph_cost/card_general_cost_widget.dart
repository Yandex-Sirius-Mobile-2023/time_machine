// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'card_graph_cost_widget.dart';

class CardGeneralCostWidget extends StatelessWidget {
  final String costStocks;
  final String costCache;
  final List<List> data;
  final double delta;

  const CardGeneralCostWidget({
    Key? key,
    required this.costStocks,
    required this.costCache,
    required this.data,
    required this.delta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradient = LinearGradient(
      colors: [
        Color.fromRGBO(0, 130, 140, 1),
        Color.fromRGBO(0, 190, 180, 1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    const double defaultPadding = 15;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2 * defaultPadding),
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: gradient,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: defaultPadding, sigmaY: defaultPadding),
            child: Container(
              height: 50,
              color: Colors.white.withOpacity(0),
            ),
          ),
        ),
        CardGraphCostWidget(
            data: data,
            costStocks: costStocks,
            costCache: costCache,
            delta: delta),
      ],
    );
  }
}
