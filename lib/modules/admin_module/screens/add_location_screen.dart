import 'package:flutter/material.dart';
import 'package:role_app/shared/widgets/footer_widget.dart';
import 'package:role_app/shared/widgets/text_field_widget.dart';

import '../../../shared/widgets/basic_app_button.dart';
import '../../../shared/widgets/navbar_widget.dart';
import '../services/location_service.dart';

class AddLocationScreen extends StatelessWidget {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: NavbarWidget(
          title: 'Add Location',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //country
              TextFieldWidget(
                  hintText: "Enter country name", controller: countryController),
              const SizedBox(height: 30),
              //state
              TextFieldWidget(
                  hintText: "Enter state name", controller: stateController),
              const SizedBox(height: 30),
              //district
              TextFieldWidget(
                  hintText: "Enter district name",
                  controller: districtController),
              const SizedBox(height: 30),
              //city
              TextFieldWidget(
                  hintText: "Enter city name", controller: cityController),
              const SizedBox(height: 40),
              //add loction button
        
              BasicAppButton(
                onpressed: () {
                  locationService.addLocation(
                    countryController.text,
                    stateController.text,
                    districtController.text,
                    cityController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/admin');
                },
                title: 'Add Location',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
