final String tableNotes = 'Task';

class TaskFields {
  static final List<String> values = [
    /// Add all fields
    id, isCompleted, title, description
  ];

  static final String id = '_id';
  static final String isCompleted = 'isCompleted';
  static final String title = 'title';
  static final String description = 'description';
}

class Task {
  final int? id;
  late bool isCompleted;
  final String title;
  final String description;

   Task({
    this.id,
    required this.isCompleted,
    required this.title,
    required this.description,
  });

  Task copy({
    int? id,
    bool? isCompleted,
    String? title,
    String? description,
  }) =>
      Task(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json[TaskFields.id] as int?,
        isCompleted: json[TaskFields.isCompleted] == 1,
        title: json[TaskFields.title] as String,
        description: json[TaskFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        TaskFields.id: id,
        TaskFields.title: title,
        TaskFields.isCompleted: isCompleted ? 1 : 0,
        TaskFields.description: description,
      };
}
