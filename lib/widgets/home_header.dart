
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String teamName;

  const HomeHeader({super.key, required this.userName, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, $userName", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Team: $teamName", style: TextStyle(color: Colors.grey)),
          ],
        ),
        Row(
          children: [
            Icon(Icons.notifications, size: 28),
            SizedBox(width: 10),
            Icon(Icons.exit_to_app, size: 28),
          ],
        ),
      ],
    );
  }

}