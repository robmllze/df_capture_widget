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
import 'dart:ui' as ui show Picture;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart'
    show BuildContext, CustomPaint, StatelessWidget, Widget, SizedBox;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class PicturePainter extends CustomPainter {
  final ui.Picture picture;
  final Size? expectedSize;

  const PicturePainter(this.picture, {this.expectedSize});

  @override
  void paint(Canvas canvas, Size size) {
    if (expectedSize != null &&
        expectedSize != Size.zero &&
        !expectedSize!.isEmpty &&
        size != Size.zero &&
        !size.isEmpty) {
      final scaleX = size.width / expectedSize!.width;
      final scaleY = size.height / expectedSize!.height;
      final scale = math.min(scaleX, scaleY);
      final scaledWidth = expectedSize!.width * scale;
      final scaledHeight = expectedSize!.height * scale;
      final dx = (size.width - scaledWidth) / 2;
      final dy = (size.height - scaledHeight) / 2;
      canvas.save();
      canvas.translate(dx, dy);
      canvas.scale(scale, scale);
      canvas.drawPicture(picture);
      canvas.restore();
    } else {
      canvas.drawPicture(picture);
    }
  }

  @override
  bool shouldRepaint(covariant PicturePainter oldDelegate) =>
      oldDelegate.picture != picture || oldDelegate.expectedSize != expectedSize;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class PictureWidget extends StatelessWidget {
//   final ui.Picture? picture;
//   final Size? expectedSize;

//   const PictureWidget({
//     super.key,
//     required this.picture,
//     this.expectedSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (picture == null) return const SizedBox.shrink();
//     return CustomPaint(
//       size: expectedSize ?? Size.infinite,
//       painter: PicturePainter(
//         picture!,
//         expectedSize: expectedSize,
//       ),
//     );
//   }
// }

class PictureWidget extends StatelessWidget {
  final ui.Picture? picture;
  final Size? size; // The original size of the picture when captured

  const PictureWidget({super.key, required this.picture, this.size});

  @override
  Widget build(BuildContext context) {
    if (picture == null) return const SizedBox.shrink();
    return CustomPaint(
      size: size ??
          Size.infinite, // Allow PicturePainter to determine size based on picture content if size is null
      painter: PicturePainter(picture!, expectedSize: size),
    );
  }
}
