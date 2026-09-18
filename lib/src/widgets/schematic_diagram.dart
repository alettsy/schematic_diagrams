import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';

/// The main schematic diagram widget.
///
/// This requires the [SchematicDiagramModel] to be provided.
class SchematicDiagram extends StatefulWidget {
  /// Default implementation.
  const SchematicDiagram({required this.model, super.key});

  /// The model representation of the diagram, used to determine
  /// everything about the diagram widget.
  final SchematicDiagramModel model;

  @override
  State<SchematicDiagram> createState() => _SchematicDiagramState();
}

class _SchematicDiagramState extends State<SchematicDiagram> {
  final _matrix = _SchematicDiagramTransformationNotifier();
  var _baseScale = 1.0;
  ScaleStartDetails? _scaleStart;

  void _handleScrollToScale(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;

    if (!widget.model.canZoom) return;

    final currentScale = _matrix.scale;
    var newX = _matrix.tx;
    var newY = _matrix.ty;

    final location = event.localPosition;
    final canZoomIn = currentScale != widget.model.maxZoom;
    final canZoomOut = currentScale != widget.model.minZoom;

    final isZoomingIn = event.scrollDelta.dy < 0;

    if ((isZoomingIn && !canZoomIn) || (!isZoomingIn && !canZoomOut)) {
      return;
    }

    var newScale = isZoomingIn
        ? currentScale + widget.model.scrollZoomStep
        : currentScale - widget.model.scrollZoomStep;

    newScale = newScale.clamp(widget.model.minZoom, widget.model.maxZoom);

    final ratio = (newScale / currentScale) - 1.0;

    newX -= (location.dx - newX) * ratio;
    newY -= (location.dy - newY) * ratio;

    _matrix.update(scale: newScale, tx: newX, ty: newY);
  }

  void _handleGestureStart(ScaleStartDetails details) {
    _scaleStart = details;
    _baseScale = _matrix.scale;
  }

  void _handleGestureUpdate(ScaleUpdateDetails details) {
    if (_scaleStart == null) return;

    final previousScale = _matrix.scale;
    final focalPoint = details.localFocalPoint;

    var newScale = _matrix.scale;
    var newX = _matrix.tx;
    var newY = _matrix.ty;

    if (widget.model.canPan) {
      newX += details.focalPointDelta.dx;
      newY += details.focalPointDelta.dy;
    }

    if (widget.model.canZoom) {
      newScale = (_baseScale * details.scale).clamp(
        widget.model.minZoom,
        widget.model.maxZoom,
      );

      newX -= (focalPoint.dx - newX) * (newScale / previousScale - 1);

      newY -= (focalPoint.dy - newY) * (newScale / previousScale - 1);
    }

    _matrix.update(scale: newScale, tx: newX, ty: newY);
  }

  void _handleGestureEnd(ScaleEndDetails details) {
    _scaleStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _handleScrollToScale,
      child: GestureDetector(
        onScaleStart: _handleGestureStart,
        onScaleUpdate: _handleGestureUpdate,
        onScaleEnd: _handleGestureEnd,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: widget.model.schematicTheme.backgroundColor,
            borderRadius: widget.model.schematicTheme.borderRadius,
            border: Border.all(
              color: widget.model.schematicTheme.borderColor,
              width: widget.model.schematicTheme.borderWidth,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: OverflowBox(
            alignment: AlignmentGeometry.topLeft,
            minWidth: 0,
            minHeight: 0,
            maxWidth: widget.model.canvasWidth,
            maxHeight: widget.model.canvasHeight,
            child: ValueListenableBuilder<Matrix4>(
              valueListenable: _matrix,
              builder: (context, matrix, child) => Transform(
                transform: matrix,
                child: RepaintBoundary(child: child),
              ),
              child: Stack(
                children: [
                  ...widget.model.links.map(
                    (l) => widget.model.linkManager.renderer.build(
                      l,
                      widget.model,
                      widget.model.defaultLinkTheme,
                    ),
                  ),
                  ...widget.model.nodes.map(
                    (n) => n.renderer.build(
                      n,
                      widget.model.defaultNodeTheme,
                      widget.model.defaultTextBlockTheme,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SchematicDiagramTransformationNotifier extends ValueNotifier<Matrix4> {
  _SchematicDiagramTransformationNotifier() : super(Matrix4.identity());

  double _scale = 1;
  double _tx = 0;
  double _ty = 0;

  double get scale => _scale;
  double get tx => _tx;
  double get ty => _ty;

  void update({required double scale, required double tx, required double ty}) {
    _scale = scale;
    _tx = tx;
    _ty = ty;

    value = Matrix4.identity()
      ..translateByDouble(_tx, _ty, 0, 1)
      ..scaleByDouble(_scale, _scale, 1, 1);
  }
}
