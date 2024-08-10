import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:role_app/shared/widgets/basic_app_button.dart';
import '../../../shared/widgets/footer_widget.dart';
import '../../../shared/widgets/navbar_widget.dart';
import '../services/excel_service.dart';
import '../services/weather_service.dart';

class UploadExcelScreen extends StatelessWidget {
  final ExcelService excelService = ExcelService();
  final WeatherService weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: NavbarWidget(
          title: 'User Dashboard',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: BasicAppButton(
            onpressed: () async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['xlsx']);
                if (result == null) {
                  throw Exception('No file selected.');
                }
          
                PlatformFile file = result.files.first;
                var locations = await excelService.parseExcelFile(file);
                var weatherReports =
                    await weatherService.fetchWeatherReports(locations);
                Navigator.pushNamed(context, '/weatherReport',
                    arguments: weatherReports);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            title: 'Upload Excel',
          ),
        ),
      ),
      bottomNavigationBar:const FooterWidget(),
    );
  }
}
