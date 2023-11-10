import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/controller/home_controller.dart';
import 'package:sale_app/view/home_screen/home_screen.dart';
import 'package:sale_app/view/login_screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: HomeScreen(),
      ),
    );
  }
}
