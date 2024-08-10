import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../modules/admin_module/screens/add_location_screen.dart';
import '../modules/admin_module/screens/admin_dashboard_screen.dart';
import '../modules/user_module/screens/upload_excel_screen.dart';
import '../modules/user_module/screens/user_dashboard_screen.dart';
import '../modules/user_module/screens/weather_report_screen.dart';
import '../shared/screens/sign_in_screen.dart';
import '../shared/screens/sign_up_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/admin':
        return MaterialPageRoute(builder: (_) => AdminDashboardScreen());
      case '/addLocation':
        return MaterialPageRoute(builder: (_) => AddLocationScreen());
      case '/user':
        return MaterialPageRoute(builder: (_) => UserDashboardScreen());
      case '/uploadExcel':
        return MaterialPageRoute(builder: (_) => UploadExcelScreen());
      case '/weatherReport':
        final weatherReports = settings.arguments as List<WeatherModel>;
        return MaterialPageRoute(
            builder: (_) => WeatherReportScreen(weatherReports));
      default:
        return MaterialPageRoute(builder: (_) => SignInScreen());
    }
  }
}
