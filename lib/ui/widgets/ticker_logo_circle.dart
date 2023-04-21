import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:shimmer/shimmer.dart';
import 'package:time_machine/core/provider/image_provider.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

Logger logger = Logger("TickerLogoCircle");

/// Widget that display logo stock in circle.
class TickerLogoCircle extends ConsumerWidget {
  final StockTicker ticker;
  const TickerLogoCircle({super.key, required this.ticker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageService = ref.watch(stockImageProvider(ticker));

    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: imageService.when(
          data: (imageurl) => SvgPicture.network(
            imageurl,
            placeholderBuilder: (_) => const _TickerShimmer(),
          ),
          error: (err, stack) {
            logger.warning("Слишком много обращений к API");
            const _TickerShimmer();
          },
          loading: () => const _TickerShimmer(),
        ),
      ),
    );
  }
}

class _TickerShimmer extends StatelessWidget {
  const _TickerShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: UIColors.cyanDark,
      highlightColor: UIColors.cyanBright,
      child: Container(color: Colors.black),
    );
  }
}
