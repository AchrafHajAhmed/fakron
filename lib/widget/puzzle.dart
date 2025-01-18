import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  final String question;
  final List<String> puzzlePieces;
  final Function(String) onPuzzleSolved;

  const Puzzle({
    Key? key,
    required this.question,
    required this.puzzlePieces,
    required this.onPuzzleSolved,
  }) : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  List<List<int>> grid = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0],
  ];

  @override
  void initState() {
    super.initState();
    _shuffleGrid();
  }

  void _shuffleGrid() {
    setState(() {
      grid = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 0],
      ];
      grid.shuffle();
      for (var row in grid) {
        row.shuffle();
      }
    });
  }

  void _moveTile(int row, int col) {
    if ((row > 0 && grid[row - 1][col] == 0) ||
        (row < 2 && grid[row + 1][col] == 0) ||
        (col > 0 && grid[row][col - 1] == 0) ||
        (col < 2 && grid[row][col + 1] == 0)) {
      setState(() {
        int temp = grid[row][col];
        grid[row][col] = 0;
        if (row > 0 && grid[row - 1][col] == 0) {
          grid[row - 1][col] = temp;
        } else if (row < 2 && grid[row + 1][col] == 0) {
          grid[row + 1][col] = temp;
        } else if (col > 0 && grid[row][col - 1] == 0) {
          grid[row][col - 1] = temp;
        } else if (col < 2 && grid[row][col + 1] == 0) {
          grid[row][col + 1] = temp;
        }
      });

      if (_isPuzzleSolved()) {
        widget.onPuzzleSolved('Puzzle résolu!');
      }
    }
  }

  bool _isPuzzleSolved() {
    int counter = 1;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] != counter % 9) {
          return false;
        }
        counter++;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final col = index % 3;
              final tileValue = grid[row][col];

              if (tileValue == 0) {
                return Container();
              }

              return GestureDetector(
                onTap: () => _moveTile(row, col),
                child: Image.asset(
                  widget.puzzlePieces[tileValue - 1],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}