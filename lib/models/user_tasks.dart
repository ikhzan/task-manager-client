class UserTask {
  final String id;
  final String title;
  final bool completed;

  UserTask({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'completed': completed,
  };
}