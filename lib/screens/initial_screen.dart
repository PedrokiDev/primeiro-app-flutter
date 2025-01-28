import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        backgroundColor: Color(0xFF2f80ed),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: ListView(
          children: [
            Task(
                'Aprender Flutter',
                'assets/images/flutter.png',
                3),
            Task(
                'Andar de bicicleta',
                'assets/images/bicicleta.webp',
                2),
            Task(
                'Meditar',
                'assets/images/meditar.jpg',
                5),
            Task(
                'Aprender japonês com o aplicativo duolingo',
                'assets/images/japones.jpg',
                4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: Icon(Icons.remove_red_eye),
      ),
    );
  }
}
