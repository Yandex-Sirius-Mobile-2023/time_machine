import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:time_machine/core/provider/image_provider.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/uikit/ui_colors.dart';

/// Widget that display logo stock in circle.
class TickerLogoCircle extends ConsumerWidget {
  final StockTicker ticker;
  const TickerLogoCircle({super.key, required this.ticker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageService = ref.watch(stockImageProvider(ticker));

    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: imageService.when(
          data: (imageurl) => SvgPicture.network(imageurl),
          error: (err, stack) => Text('Error: $err'),
          loading: () => Shimmer.fromColors(
            baseColor: UIColors.cyanDark,
            highlightColor: UIColors.cyanBright,
            child: Container(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
