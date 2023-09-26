import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'dart:math';

class FxZoomingImage extends StatefulWidget {
  final ImageProvider imageProvider;
  final double? minScale;

  final double? defScale;

  final double? maxScale;

  const FxZoomingImage(
      {Key? key,
      required this.imageProvider,
      this.defScale,
      this.minScale,
      this.maxScale})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FxZoomingImageState();
  }
}

class _FxZoomingImageState extends State<FxZoomingImage> {
  late PhotoViewControllerBase _controller;
  late PhotoViewScaleStateController _scaleStateController;
  double min = pi * -2;
  double max = pi * 2;

  @override
  void initState() {
    _controller = PhotoViewController(initialScale: widget.defScale ?? 1.0)
      ..outputStateStream.listen(_onController);

    _scaleStateController = PhotoViewScaleStateController()
      ..outputScaleStateStream.listen(_onScaleState);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: PhotoView(
              imageProvider: widget.imageProvider,
              controller: _controller,
              scaleStateController: _scaleStateController,
              enableRotation: true,
              initialScale: widget.defScale ?? 1.0,
              minScale: widget.minScale ?? 0.03,
              maxScale: widget.maxScale ?? 10.0,
            ),
          ),
          Positioned(
            bottom: 0,
            height: 290,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: StreamBuilder(
                stream: _controller.outputStateStream,
                initialData: _controller.value,
                builder: _streamBuild,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _streamBuild(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError || !snapshot.hasData) {
      return Container();
    }
    final PhotoViewControllerValue value = snapshot.data;
    return Column(
      children: <Widget>[
        Text(
          "Rotation ${value.rotation}",
          style: const TextStyle(color: Colors.white),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.orange,
            thumbColor: Colors.orange,
          ),
          child: Slider(
            value: value.rotation.clamp(min, max),
            min: min,
            max: max,
            onChanged: (double newRotation) {
              _controller.rotation = newRotation;
            },
          ),
        ),
        Text(
          "Scale ${value.scale}",
          style: const TextStyle(color: Colors.white),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.orange,
            thumbColor: Colors.orange,
          ),
          child: Slider(
            value: value.scale!.clamp(
              widget.minScale ?? 0.03,
              widget.maxScale ?? 10.0,
            ),
            min: widget.minScale ?? 0.03,
            max: widget.maxScale ?? 10.0,
            onChanged: (double newScale) {
              _controller.scale = newScale;
            },
          ),
        ),
        Text(
          "Position ${value.position.dx}",
          style: const TextStyle(color: Colors.white),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.orange,
            thumbColor: Colors.orange,
          ),
          child: Slider(
            value: value.position.dx,
            min: -1000.0,
            max: 1000.0,
            onChanged: (double newPosition) {
              _controller.position =
                  Offset(newPosition, _controller.position.dy);
            },
          ),
        ),
        Text(
          "ScaleState ${_scaleStateController.scaleState}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _onController(PhotoViewControllerValue value) {
    setState(() {});
  }

  void _onScaleState(PhotoViewScaleState scaleState) {
    if (kDebugMode) {
      print(scaleState);
    }
  }
}
