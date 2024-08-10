import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import '../../../models/location_model.dart';


class ExcelService {
  Future<List<LocationModel>> parseExcelFile(PlatformFile file) async {
     if (file.path == null) {
      throw Exception('No file selected. Please choose an Excel file.');
    }

    try {
      var bytes = File(file.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      
      if (excel.tables.isEmpty) {
        throw Exception('The Excel file is empty or invalid.');
      }

      List<LocationModel> locations = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows.skip(1)) { 
          var country = row[0]?.value?.toString() ?? '';
          var state = row[1]?.value?.toString() ?? '';
          var district = row[2]?.value?.toString() ?? '';
          var city = row[3]?.value?.toString() ?? '';

           if (country.isNotEmpty && state.isNotEmpty && district.isNotEmpty && city.isNotEmpty) {
            locations.add(LocationModel(
              country: country,
              state: state,
              district: district,
              city: city,
            ));
          }
        }
      }
      return locations;
    } catch (e) {
      throw Exception('Error parsing Excel file: $e');
    }
  }
}

