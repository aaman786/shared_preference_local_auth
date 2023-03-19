import 'package:auth_shared_pref/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';
import 'user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 96),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget(icon: Icons.home, text: 'Signup'),
              buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    void navigateToLoginScreen() {
      Navigator.pushNamed(context, LoginScreen.routeName);
    }

    void navigateToUserScreen() {
      Navigator.pushNamed(context, UserScreen.routeName, arguments: null);
    }

    return Column(
      children: [
        const SizedBox(height: 24),
        CustomButton(
          label: 'Login',
          onPress: navigateToLoginScreen,
        ),
        const SizedBox(height: 24),
        CustomButton(label: 'Register', onPress: navigateToUserScreen),
      ],
    );
  }
}
