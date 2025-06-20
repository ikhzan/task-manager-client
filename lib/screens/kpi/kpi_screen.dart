import 'package:flutter/material.dart';
import 'package:task_manager_client/models/kpi_model.dart';
import 'package:task_manager_client/services/kpi_service.dart';

class KpiScreen extends StatelessWidget {
  const KpiScreen({super.key});

  Future<List<Kpi>> _fetchkpis() async {
    return await KpiService().fetchkpis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kpi")),
      body: FutureBuilder<List<Kpi>>(
        future: _fetchkpis(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No kpi found."));
          }

          final kpis = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: kpis.length,
              itemBuilder: (context, index) {
                final kpi = kpis[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(kpi.name[0])),
                    title: Text(
                      kpi.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Frequency: ${kpi.frequency}"),
                        Text("Target: ${kpi.target}"),
                      ],
                    ),
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
