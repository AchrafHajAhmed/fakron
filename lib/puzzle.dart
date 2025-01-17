import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PuzzleWidget extends StatefulWidget {
  final String imagePath;
  final int gridSize;

  const PuzzleWidget({
    Key? key,
    required this.imagePath,
    this.gridSize = 3,
  }) : super(key: key);

  @override
  _PuzzleWidgetState createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  List<ui.Image?> pieces = [];
  List<int> positions = [];
  bool isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadImageAndSplit();
  }

  Future<void> _loadImageAndSplit() async {
    final image = await _loadImage(widget.imagePath);
    final pieceSize = image.width ~/ widget.gridSize;


    for (int row = 0; row < widget.gridSize; row++) {
      for (int col = 0; col < widget.gridSize; col++) {
        pieces.add(await _cropImage(
          image,
          Rect.fromLTWH(
            col * pieceSize.toDouble(),
            row * pieceSize.toDouble(),
            pieceSize.toDouble(),
            pieceSize.toDouble(),
          ),
        ));
      }
    }

    setState(() {
      positions = List.generate(pieces.length, (index) => index);
      positions.shuffle();
      isImageLoaded = true;
    });
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final data = await DefaultAssetBundle.of(context).load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<ui.Image> _cropImage(ui.Image image, Rect rect) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint();
    canvas.drawImageRect(image, rect, Rect.fromLTWH(0, 0, rect.width, rect.height), paint);

    return await recorder.endRecording().toImage(
      rect.width.toInt(),
      rect.height.toInt(),
    );
  }

  void _swapPieces(int index1, int index2) {
    setState(() {
      final temp = positions[index1];
      positions[index1] = positions[index2];
      positions[index2] = temp;
    });

    if (_checkVictory()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Félicitations !'),
          content: Text('Vous avez terminé le puzzle.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _checkVictory() {
    for (int i = 0; i < positions.length; i++) {
      if (positions[i] != i) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!isImageLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.gridSize,
      ),
      itemCount: pieces.length,
      itemBuilder: (context, index) {
        final pieceIndex = positions[index];
        return GestureDetector(
          onTap: () {

            final emptyIndex = positions.indexOf(pieces.length - 1);
            if ((index - emptyIndex).abs() == 1 || (index - emptyIndex).abs() == widget.gridSize) {
              _swapPieces(index, emptyIndex);
            }
          },
          child: pieces[pieceIndex] == null
              ? Container(color: Colors.white)
              : CustomPaint(
            size: Size(100, 100),
            painter: ImagePainter(pieces[pieceIndex]!),
          ),
        );
      },
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


