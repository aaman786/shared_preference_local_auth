import 'package:auth_shared_pref/screens/user_screen.dart';
import 'package:auth_shared_pref/service/user_pref.dart';
import 'package:auth_shared_pref/utils/hide_keyboard.dart';
import 'package:auth_shared_pref/utils/snack_bar.dart';
import 'package:auth_shared_pref/widgets/build_title_with%20_child.dart';
import 'package:auth_shared_pref/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/title_widget.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 96),
                    child: Column(
                      children: const [
                        Center(
                            child:
                                TitleWidget(icon: Icons.login, text: 'Login')),
                        LoginForm(),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 24,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back, size: 32),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController phCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phCtrl.dispose();
    passCtrl.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool? showInfoFlagPh;
  bool showInfoFlagPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 48),
          showInfoFlagPh != null
              ? showInfoFlagPh!
                  ? infoText('Entered number not found! Create a new account.')
                  : const SizedBox()
              : const SizedBox(),
          showInfoFlagPassword
              ? infoText('Password is incorrect...')
              : const SizedBox(),
          buildPhone(),
          const SizedBox(height: 15),
          buildPassword(),
          const SizedBox(height: 25),
          CustomButton(
              label: "Login",
              onPress: () {
                KeyboardUtil.hideKeyboard(context);

                if (formKey.currentState!.validate()) {
                  final user = UserPreference.getUser(phCtrl.text);
                  if (user == null) {
                    setState(() => showInfoFlagPh = true);
                  } else {
                    setState(() => showInfoFlagPh = false);
                    if (passCtrl.text == user.password) {
                      showSnackBar(context, "Password matched");
                      Navigator.pushNamedAndRemoveUntil(
                          context, UserScreen.routeName, (route) => false,
                          arguments: user);
                    } else {
                      setState(() => showInfoFlagPassword = true);
                    }
                  }
                }
              })
        ],
      ),
    );
  }

  Padding infoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: ' i : ',
            style: TextStyle(
              color: const Color.fromARGB(255, 254, 16, 16),
              height: 1.0,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
                color: Colors.redAccent,
                height: 1.2,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                backgroundColor: Colors.grey.shade300),
          ),
        ]),
      ),
    );
  }

  Widget buildPassword() => BuildTitleWithChild(
        title: 'Password',
        child: TextFormField(
            controller: passCtrl,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: "Enter Password",
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Enter your Password.";
              } else if (val.length < 3) {
                return "Must contain letters more than three.";
              }
              return null;
            }),
      );

  Widget buildPhone() => BuildTitleWithChild(
        title: 'Phone',
        child: TextFormField(
            controller: phCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Enter Phone Number",
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Enter your phone number";
              } else if (val.length < 10) {
                return "Invalid number...";
              } else if (val.contains(RegExp(r'[A-Z]')) ||
                  val.contains(RegExp(r'[a-z]'))) {
                return "Phone number can't have any of letter.";
              }
              return null;
            }),
      );
}
