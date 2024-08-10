import 'package:flutter/material.dart';
import 'package:role_app/shared/widgets/footer_widget.dart';

import '../../../models/location_model.dart';
import '../../../shared/widgets/navbar_widget.dart';
import '../services/location_service.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: NavbarWidget(
          title: 'Admin Dashboard',
        ),
      ),
      body: StreamBuilder<List<LocationModel>>(
        stream: LocationService().getLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No locations added yet');
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final location = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 133, 153, 187),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 133, 153, 187),
                        offset: Offset(0, 25),
                        blurRadius: 10,
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${location.city}, ${location.state}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${location.district}, ${location.country}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addLocation');
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
