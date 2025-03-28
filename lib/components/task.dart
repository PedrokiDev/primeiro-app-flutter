import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/difficulty.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

class Task extends StatefulWidget {
  final String name;
  final int difficulty;
  final String image;
  final VoidCallback? onDelete;

  Task(this.name, this.image, this.difficulty, {this.onDelete});

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xFF2f80ed)),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[200],
                        ),
                        width: 72,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: assetOrNetwork()
                                ? Image.asset(widget.image, fit: BoxFit.cover)
                                : Image.network(
                                    widget.image,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Erro ao carregar imagem: $error');
                                      return Icon(Icons.error,
                                          color: Colors
                                              .red); // Mostra um ícone de erro
                                    },
                                  ))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                            )),
                        Difficulty(difficultyLevel: widget),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onLongPress: () async {
                              print('onLongPress disparado');
                              bool? confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmação'),
                                      content: Text(
                                          'Tem certeza de que deseja deletar a tarefa "${widget.name}"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Deletar'),
                                        ),
                                      ],
                                    );
                                  });
                              if (confirmDelete == true) {
                                await TaskDao().delete(widget.name);
                                widget.onDelete?.call();
                              }
                            },
                            onPressed: () {
                              setState(() {
                                widget.nivel++;
                              });
                              if (kDebugMode) {
                                print(widget.nivel);
                              }
                            },
                            child: Icon(Icons.arrow_drop_up)),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.black,
                        value: (widget.difficulty > 0)
                            ? (widget.nivel / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nível ${widget.nivel}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
