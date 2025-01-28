import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class Difficulty extends StatelessWidget {
  const Difficulty({
    super.key,
    required this.difficultyLevel,
  });

  final Task difficultyLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color:
                (difficultyLevel.level >= 1) ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (difficultyLevel.level >= 2) ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (difficultyLevel.level >= 3) ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (difficultyLevel.level >= 4) ? Colors.blue : Colors.blue[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (difficultyLevel.level >= 5) ? Colors.blue : Colors.blue[100]),
      ],
    );
  }
}
