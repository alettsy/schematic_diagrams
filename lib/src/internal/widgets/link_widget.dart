import 'package:flutter/widgets.dart';
import 'package:schematic_diagrams/src/core/parts/link_theme.dart';
import 'package:schematic_diagrams/src/internal/models/node_resolver.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_renderer.dart';

/// Widget representation of a link.
class LinkWidget extends StatelessWidget {
  /// Create a [LinkWidget] that will use [renderer] to draw the [link], between
  /// the nodes obtained from [nodeResolver].
  /// 
  /// The [defaultLinkTheme] will be applied if the link has no theme override.
  const LinkWidget({
    required this.link,
    required this.renderer,
    required this.nodeResolver,
    required this.defaultLinkTheme,
    super.key,
  });

  /// The model representation of the link.
  final Link link;

  /// How the link should be rendered to the diagram.
  final LinkRenderer renderer;

  /// Node resolver to allow links to reference nodes based on the provided,
  /// necessary IDs.
  final NodeResolver nodeResolver;

  /// The default theme for the link.
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
