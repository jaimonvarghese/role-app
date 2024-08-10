import 'package:flutter/widgets.dart';

class MainTitle extends StatelessWidget {
  final String title;
  
  const MainTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
      title,
      style:const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }
}
