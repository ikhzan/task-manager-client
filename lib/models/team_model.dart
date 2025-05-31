
class Team{
   final String name;

   Team({
    required this.name
   });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name']
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'name': name
    };
  }

}