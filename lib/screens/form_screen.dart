import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

import '../components/task.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultValidator(String? value) {
    if (value == null || value.isEmpty) return true;
    int? difficulty = int.tryParse(value);
    if (difficulty == null || difficulty < 1 || difficulty > 5) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: AppBar(
                title: Text('Nova tarefa'),
                backgroundColor: Color(0xFF2f80ed),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
                elevation: 0,
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'Insira um nome para a tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Tarefa',
                          hintText: 'Escreva o nome da tarefa',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          validator: (value) {
                            if (difficultValidator(value)) {
                              return 'Insira uma dificuldade entre 1 e 5';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: difficultyController,
                          decoration: InputDecoration(
                            labelText: 'Dificuldade',
                            hintText: 'Dê uma nota de 1~5 para a dificuldade',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ]),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'Digite uma URL para a imagem';
                          } else {
                            return null;
                          }
                        },
                        controller: imageController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          labelText: 'Imagem',
                          hintText: 'Insira uma URL válida',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 100,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.blue),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageController.text,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/noPhoto.png');
                            },
                          ),
                        )),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await TaskDao().save(Task(
                                nameController.text,
                                imageController.text,
                                int.parse(difficultyController.text)));
                            ScaffoldMessenger.of(widget.taskContext)
                                .showSnackBar(
                              const SnackBar(
                                content: Text('Criando uma nova tarefa'),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Adicionar')),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
