import 'package:flutter/material.dart';
import 'package:task_manager_client/models/team_model.dart';
import 'package:task_manager_client/services/team_service.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  Future<List<Team>> _fetchTeamsByMember() async {
    return await TeamService().fetchTeamsByMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teams")),
      body: FutureBuilder<List<Team>>(
        future: _fetchTeamsByMember(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No teams found."));
          }

          final teams = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(team.name[0])),
                    title: Text(team.name),
                    subtitle: Text("Members: ${team.members.length}"),
                    trailing: Icon(Icons.group),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
