import 'package:flutter/material.dart';
import '../../config.dart';

class NetImage extends StatelessWidget {
  const NetImage(this.url, {super.key, this.fit = BoxFit.cover, this.width, this.height});
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;

  Widget _placeholder({bool loading = false}) => Container(
        width: width,
        height: height,
        color: AppColors.surface,
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.movie_outlined, color: AppColors.textMuted),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (url == null) return _placeholder();
    return Image.network(
      url!,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : _placeholder(loading: true),
      errorBuilder: (context, error, stack) => _placeholder(),
    );
  }
}
