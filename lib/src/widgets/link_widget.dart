import 'package:flutter/widgets.dart';

import '../core/parts/link_theme.dart';
import '../models/link.dart';
import '../models/node_resolver.dart';
import '../rendering/linking/link_renderer.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({
    required this.link,
    required this.renderer,
    required this.nodeResolver,
    required this.defaultLinkTheme,
    super.key,
  });

  final Link link;
  final LinkRenderer renderer;
  final NodeResolver nodeResolver;
  final LinkTheme defaultLinkTheme;

  @override
  Widget build(BuildContext context) {
    if (link is Listenable) {
      return Positioned.fill(
        child: RepaintBoundary(
          child: ListenableBuilder(
            listenable: link as Listenable,
            builder: (context, child) => CustomPaint(
              painter: _PaintedLinkDelegate(
                link: link,
                onPaint: (canvas) => renderer.paint(
                  canvas,
                  link,
                  nodeResolver,
                  defaultLinkTheme,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Positioned.fill(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _PaintedLinkDelegate(
            link: link,
            onPaint: (canvas) =>
                renderer.paint(canvas, link, nodeResolver, defaultLinkTheme),
          ),
        ),
      ),
    );
  }
}

class _PaintedLinkDelegate<T extends Link> extends CustomPainter {
  const _PaintedLinkDelegate({required this.link, required this.onPaint});

  final T link;
  final void Function(Canvas canvas) onPaint;

  @override
  void paint(Canvas canvas, Size size) {
    onPaint(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // TODO: link can be updatable
  }
}
