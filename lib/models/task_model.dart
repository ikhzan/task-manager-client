class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String? user;
  final String? team;
  final String? deadline;
  final int? timelineWeeks;
  final List<String>? tags;
  final String priority;
  final int? revisions;
  final String? completedAt;
  final int? completionTime;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.user,
    this.team,
    this.deadline,
    this.timelineWeeks,
    this.tags,
    required this.priority,
    this.revisions,
    this.completedAt,
    this.completionTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] ?? "", // Handle null description
      completed: json['completed'] as bool,
      user: json['user']?.toString(),
      team: json['team']?.toString(),
      deadline: json['deadline']?.toString(),
      timelineWeeks: json['timelineWeeks'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((tag) => tag.toString()).toList() ?? [],
      priority: json['priority'] ?? "medium", // Default value
      revisions: json['revisions'] as int?,
      completedAt: json['completedAt']?.toString(),
      completionTime: json['completionTime'] as int?,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'title': title
    };
  }
}