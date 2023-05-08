import 'package:flutter/material.dart';
import 'package:map_demo/pages/map_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nomadapp',
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark), // or ThemeData.dart()
        debugShowCheckedModeBanner: false,
        home: MapScreen());
  }
}
