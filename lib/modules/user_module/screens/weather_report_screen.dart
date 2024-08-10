import 'package:flutter/material.dart';
import 'package:role_app/shared/widgets/footer_widget.dart';

import '../../../models/weather_model.dart';
import '../../../shared/services/auth/auth_service.dart';

class WeatherReportScreen extends StatelessWidget {
  final List<WeatherModel> weatherReports;
  final AuthService _authService = AuthService();
  WeatherReportScreen(this.weatherReports);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
          title: const Text(
            'Weather Reports',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List View'),
              Tab(text: 'Grid View'),
              Tab(text: 'Table View'),
              Tab(text: 'Card View'),
              Tab(text: 'Custom View'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListView(),
            _buildGridView(),
            _buildTableView(),
            _buildCardView(),
            _buildCustomView(),
          ],
        ),
        bottomNavigationBar: const FooterWidget(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: weatherReports.length,
      itemBuilder: (context, index) {
        final report = weatherReports[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(
              report.city,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              '${report.temperature.toStringAsFixed(1)} °C',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: weatherReports.length,
      itemBuilder: (context, index) {
        final report = weatherReports[index];

        return Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: Colors.black54.withOpacity(.2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                report.city,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${report.temperature.toStringAsFixed(1)} °C',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 150,
        headingRowHeight: 50,
        columns: const [
          DataColumn(label: Text('City')),
          DataColumn(label: Text('Temperature (°C)')),
        ],
        rows: weatherReports.map((report) {
          return DataRow(
            cells: [
              DataCell(Text(report.city)),
              DataCell(Text(report.temperature.toStringAsFixed(1))),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCardView() {
    return ListView.builder(
      itemCount: weatherReports.length,
      itemBuilder: (context, index) {
        final report = weatherReports[index];
        return Card(
          shadowColor: Colors.black,
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.city,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
               const SizedBox(height: 8.0),
                Text(
                    'Temperature: ${report.temperature.toStringAsFixed(1)} °C'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomView() {
    return ListView.builder(
      itemCount: weatherReports.length,
      itemBuilder: (context, index) {
        final report = weatherReports[index];
        return Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: Colors.black54.withOpacity(.2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(
                Icons.wb_sunny,
                color: Colors.yellow,
                size: 40.0,
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.city,
                    style: const TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${report.temperature.toStringAsFixed(1)} °C',
                    style:const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
