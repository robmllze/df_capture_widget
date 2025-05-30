//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by dev-cetera.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:math' as math;
import 'dart:ui' as ui show Image;

import 'package:flutter/cupertino.dart' show BuildContext;
import 'package:flutter/material.dart' show LayoutBuilder;
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/widgets.dart' show CustomPaint, StatelessWidget, Widget, SizedBox;

import 'widget_to_image.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<CustomPaint?> widgetToImagePaint(
  BuildContext context, {
  double quality = 1.0,
}) async {
  final image = await widgetToImage(context, quality: quality);
  if (image != null) {
    final result = CustomPaint(
      painter: ImagePainter(image),
      size: Size(image.width.toDouble(), image.height.toDouble()),
    );
    return result;
  }
  return null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final Size? expectedSize;

  const ImagePainter(this.image, {this.expectedSize});

  @override
  void paint(Canvas canvas, Size size) {
    if (expectedSize != null &&
        expectedSize != Size.zero &&
        !expectedSize!.isEmpty &&
        size != Size.zero &&
        !size.isEmpty) {
      final targetSize = expectedSize!;
      final scaleX = size.width / targetSize.width;
      final scaleY = size.height / targetSize.height;
      final scale = math.min(scaleX, scaleY);
      final scaledWidth = targetSize.width * scale;
      final scaledHeight = targetSize.height * scale;
      final dx = (size.width - scaledWidth) / 2;
      final dy = (size.height - scaledHeight) / 2;
      canvas.save();
      canvas.translate(dx, dy);
      canvas.scale(scale, scale);
      canvas.drawImage(image, Offset.zero, Paint());
      canvas.restore();
    } else {
      canvas.drawImage(image, Offset.zero, Paint());
    }
  }

  @override
  bool shouldRepaint(covariant ImagePainter oldDelegate) =>
      oldDelegate.image != image || oldDelegate.expectedSize != expectedSize;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ImageWidget extends StatelessWidget {
  final ui.Image? image;

  const ImageWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return SizedBox.fromSize(
          size: size,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CustomPaint(
              size: size,
              painter: ImagePainter(
                image!,
              ),
            ),
          ),
        );
      },
    );
  }
}
