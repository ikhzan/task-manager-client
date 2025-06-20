import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/widgets/basic_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> _loadProfileData() async {
    final username = await LocalStorage.getData(Constants.username);
    final fullName = await LocalStorage.getData(Constants.fullName);
    final taskCount = await LocalStorage.getData(
      Constants.taskCount,
    ); // optional: parseInt
    final teamCount = await LocalStorage.getData(Constants.teamCount);
    return {
      'username': username ?? '',
      'fullName': fullName ?? '',
      'taskCount': taskCount ?? '0',
      'teamCount': teamCount ?? '0',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text("Profile")),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              child: Card(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _loadProfileData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
              
                    final data = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [

                        ],),
                        Text("Full Name: ${data['fullName']}"),
                        Text("Username: ${data['username']}"),
                        Text("Tasks: ${data['taskCount']}"),
                        Text("Teams: ${data['teamCount']}"),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
