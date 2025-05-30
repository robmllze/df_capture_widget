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

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'df_widget_capture.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BuildContext? context1;
  BuildContext? context2;
  ui.Image? image2;
  ui.Picture? picture1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Column(
          children: [
            FilledButton(
              onPressed: () async {
                setState(() {
                  picture1 = widgetToPicture(context1);
                });
                widgetToImage(context2).then((e) {
                  setState(() {
                    image2 = e;
                  });
                });
              },
              child: const Text('CAPTURE'),
            ),
            const Text('WIDGET #1:'),
            Builder(
              builder: (context) {
                // We need the context.
                context1 = context;
                // Widget to capture must be wrapped in a RepaintBoundary.
                return RepaintBoundary(
                  child: Container(
                    color: Colors.red,
                    child: const Text('Capture this fist widget as a picture!'),
                  ),
                );
              },
            ),
            const Text('WIDGET #2:'),
            Builder(
              builder: (context) {
                // We need the context.
                context2 = context;
                // Widget to capture must be wrapped in a RepaintBoundary.
                return RepaintBoundary(
                  child: Container(
                    color: Colors.yellow,
                    child: const Text('Capture this second widget as an image!'),
                  ),
                );
              },
            ),
            // const Text('PICTURE OF #1:'),
            // if (picture1 != null)
            //   Expanded(
            //     child: FittedBox(
            //       fit: BoxFit.contain,
            //       child: PictureWidget(
            //         picture: picture1,
            //         expectedSize: View.of(context).physicalSize,
            //       ),
            //     ),
            //   )
            // else
            //   const Text('...'),
            const Text('IMAGE OF #2:'),
            if (image2 != null)
              Container(
                height: 20.0,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageWidget(
                    image: image2,
                  ),
                ),
              )
            else
              const Text('...'),
          ],
        ),
      ),
    );
  }
}
