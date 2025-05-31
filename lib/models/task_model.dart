class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  // Add a factory to convert from JSON map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'] ?? false,
    );
  }

  // Convert to JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
  };
}
