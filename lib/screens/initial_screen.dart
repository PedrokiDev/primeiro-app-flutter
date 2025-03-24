import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import '../components/task.dart';
import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  List<Task> tarefas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('Inicializando a tela');
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    print('Carregando tarefas...');
    setState(() {
      isLoading = true;
    });
    final lista = await TaskDao().findAll();
    print('Tarefas carregadas: $lista');
    setState(() {
      tarefas = lista;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo a tela com ${tarefas.length} tarefas');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await _loadTasks();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        title: Text('Tarefas'),
        backgroundColor: Color(0xFF2f80ed),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 100),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : tarefas.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nenhuma tarefa adicionada!',
                        style: TextStyle(fontSize: 22, color: Colors.grey),
                      )
                    ],
                  ))
                : ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      print('Renderizando tarefa: ${tarefas[index].name}');
                      return Task(
                        tarefas[index].name,
                        tarefas[index].image,
                        tarefas[index].difficulty,
                        onDelete: _loadTasks,
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('Abrindo FormScreen');
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          );
          print('Retornou do FormScreen, recarregando tarefas');
          await _loadTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
