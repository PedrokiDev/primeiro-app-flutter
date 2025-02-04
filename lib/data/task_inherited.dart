import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/flutter.png', 3),
    Task('Andar de bicicleta', 'assets/images/bicicleta.webp', 2),
    Task('Meditar', 'assets/images/meditar.jpg', 5),
    Task('Aprender japonês com o aplicativo duolingo','assets/images/japones.jpg', 4)
  ];

  void newTask(String name, String photo, int difficult){
    taskList.add(Task(name, photo, difficult));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
