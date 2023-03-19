import 'package:auth_shared_pref/routes.dart';
import 'package:auth_shared_pref/screens/home_screen.dart';
import 'package:auth_shared_pref/service/user_pref.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 136, 117, 168),
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 249, 249, 249)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
