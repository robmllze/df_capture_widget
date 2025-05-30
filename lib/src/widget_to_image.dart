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

import 'dart:async' show Completer;
import 'dart:ui' as ui show Image;

import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:flutter/widgets.dart' hide Image;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<ui.Image?> widgetToImage(
  BuildContext? context, {
  double quality = 1.0,
}) async {
  if (context == null) {
    return null;
  }
  final pixelRatio = View.of(context).devicePixelRatio * quality;
  final imageCompleter = Completer<ui.Image?>();
  await WidgetsBinding.instance.endOfFrame;
  if (!context.mounted) {
    return null;
  }
  ui.Image? image;
  final renderObject = context.findRenderObject();
  final boundary = renderObject is RenderRepaintBoundary ? renderObject : null;
  if (boundary != null) {
    image = await boundary.toImage(pixelRatio: pixelRatio);
  }
  imageCompleter.complete(image);
  return image;
}
