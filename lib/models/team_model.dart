class Team {
  final String id;

  final String name;
  final List<String> members;
  final List<String> tasks;

  Team({
    required this.id,
    required this.name,
    required this.members,
    required this.tasks,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      members: List<String>.from(json['members'] ?? []),
      tasks: List<String>.from(json['tasks'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'members': members, 'tasks': tasks};
  }
}
