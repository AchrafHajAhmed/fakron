import 'package:flutter/material.dart';

class Crossword extends StatefulWidget {
  final String question;
  final List<List<String>> crosswordGrid;
  final Function(String) onCrosswordSolved;

  const Crossword({
    Key? key,
    required this.question,
    required this.crosswordGrid,
    required this.onCrosswordSolved,
  }) : super(key: key);

  @override
  _CrosswordState createState() => _CrosswordState();
}

class _CrosswordState extends State<Crossword> {
  List<List<String>> grid = [];
  List<List<bool>> selectedCells = [];

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = widget.crosswordGrid;
    selectedCells = List.generate(
      grid.length,
          (i) => List.generate(grid[i].length, (j) => false),
    );
  }

  void _toggleCellSelection(int row, int col) {
    setState(() {
      selectedCells[row][col] = !selectedCells[row][col];
    });
  }

  void _checkSolution() {

    widget.onCrosswordSolved('تم حل الكلمات المتقاطعة! 🎉');
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
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: grid.isNotEmpty ? grid[0].length : 1,
            childAspectRatio: 1,
          ),
          itemCount: grid.length * (grid.isNotEmpty ? grid[0].length : 0),
          itemBuilder: (context, index) {
            final row = index ~/ (grid.isNotEmpty ? grid[0].length : 1);
            final col = index % (grid.isNotEmpty ? grid[0].length : 1);
            return GestureDetector(
              onTap: () => _toggleCellSelection(row, col),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: selectedCells[row][col] ? Colors.blue : Colors.white,
                ),
                child: Center(
                  child: Text(
                    grid[row][col],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _checkSolution,
          child: const Text('تحقق من الحل'),
        ),
      ],
    );
  }
}