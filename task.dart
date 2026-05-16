// task.dart — The data model for a single task
// A Dart class is a blueprint. Every task object created from this class
// will have exactly these properties.

class Task {
  String title;
  String description;
  String category;   // e.g. School, Personal, Health
  String priority;   // Low, Medium, High
  DateTime dueDate;
  bool isCompleted;

  // Constructor — called when you write Task(title: ..., description: ...)
  Task({
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false, // Defaults to false — new tasks start as pending
  });
}
