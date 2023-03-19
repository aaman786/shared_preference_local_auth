import 'dart:io';

import 'package:auth_shared_pref/screens/login_screen.dart';
import 'package:auth_shared_pref/service/user_pref.dart';
import 'package:auth_shared_pref/utils/hide_keyboard.dart';
import 'package:auth_shared_pref/utils/pick_img.dart';
import 'package:auth_shared_pref/widgets/build_title_with%20_child.dart';
import 'package:auth_shared_pref/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../widgets/birthday_widget.dart';
import '../widgets/pets_btn_widgets.dart';
import '../widgets/title_widget.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = "/user";
  final UserModel? user;

  const UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final formKey = GlobalKey<FormState>();
  UserModel? user;
  // String name = '';
  DateTime? birthday;
  List<String> pets = [];

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // final id = const Uuid().v4();
    // print("ID : $id");

    // user = widget.idUser == ''
    //     ? UserModel(
    //         password: '',
    //         id: phCtrl.text,
    //         name: '',
    //         phNumber: '',
    //         dateOfBirth: null,
    //         imagePath: '',
    //         pets: pets)
    //     : UserPreference.getUser(widget.idUser);

    user = widget.user == null
        ? UserModel(
            password: '',
            id: phCtrl.text,
            name: '',
            phNumber: '',
            dateOfBirth: null,
            imagePath: '',
            pets: pets)
        : UserModel(
            id: widget.user!.id,
            name: widget.user!.name,
            phNumber: widget.user!.phNumber,
            dateOfBirth: widget.user!.dateOfBirth,
            imagePath: widget.user!.imagePath,
            pets: widget.user!.pets,
            password: '');
  }

  File? imgSelected;
  String? imagePath;
  bool? imgSelectedFlag;

  Future<void> selectImage() async {
    final res = await pickImage();
    if (res != null) {
      imagePath = res.files.first.path!;
      setState(() {
        imgSelected = File(res.files.first.path!);
        imgSelectedFlag = true;
      });
      print("The path of the image: $imagePath");
    }
  }

  File? camImg;

  Future<void> pickImgFromCam() async {
    final res = await pickImageFromCam();
    if (res != null) {
      imagePath = res.path;
      setState(() {
        imgSelected = File(res.path);
        imgSelectedFlag = true;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      nameCtrl.text = user!.name;
      phCtrl.text = user!.name;
      imgSelected = File(user!.imagePath!);
      birthday = user!.dateOfBirth;
      pets = user!.pets;
    }

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              TitleWidget(
                  icon: Icons.save_alt,
                  text: widget.user == null
                      ? 'Enter your Details'
                      : 'Edit your Details'),
              const SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    children: [
                      buildImage(),
                      imgSelectedFlag == null
                          ? const SizedBox()
                          : imgSelectedFlag!
                              ? const SizedBox()
                              : Text(
                                  "Please choose Photo.",
                                  style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontWeight: FontWeight.w400),
                                )
                    ],
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0)
                          .copyWith(bottom: 8.0),
                      child: Column(
                        children: [
                          buildName(),
                          const SizedBox(height: 12),
                          buildBirthday()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              buildPhone(),
              const SizedBox(height: 12),
              buildPassword(),
              const SizedBox(height: 12),
              buildPets(),
              const SizedBox(height: 22),
              widget.user != null ? const SizedBox() : buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Stack buildImage() {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.all(2),
        height: 150.0,
        width: 120.0,
        decoration: BoxDecoration(
          image: imgSelected != null
              ? DecorationImage(
                  image: FileImage(imgSelected!),
                  fit: BoxFit.fitHeight,
                )
              : const DecorationImage(
                  image: AssetImage('assets/149071.png'),
                  fit: BoxFit.fitHeight,
                ),
          shape: BoxShape.rectangle,
        ),
      ),
      widget.user != null
          ? Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 45, 51, 81),
                ),
                child: IconButton(
                  splashRadius: 28,
                  color: Colors.amber,
                  icon: const Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    imagePickerOption();
                  },
                ),
              ))
          : const SizedBox()
    ]);
  }

  PersistentBottomSheetController<dynamic> imagePickerOption() {
    final background = Theme.of(context).unselectedWidgetColor;

    ElevatedButton customButton(
        {required VoidCallback onPress,
        required String label,
        required IconData icon}) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: background),
        onPressed: onPress,
        icon: Icon(icon),
        label: Text(label),
      );
    }

    return scaffoldKey.currentState!.showBottomSheet((context) {
      return SingleChildScrollView(
          child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: const Color(0xFF8875A8).withOpacity(0.9),
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                customButton(
                    onPress: () {
                      pickImageFromCam();
                      Navigator.pop(context);
                    },
                    label: 'CAMERA',
                    icon: Icons.camera),
                customButton(
                    onPress: () {
                      selectImage();
                      Navigator.pop(context);
                    },
                    label: 'GALLERY',
                    icon: Icons.image),
                const SizedBox(
                  height: 10,
                ),
                customButton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    label: 'CANCEL',
                    icon: Icons.close),
              ],
            ),
          ),
        ),
      ));
    });
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

  Widget buildName() => BuildTitleWithChild(
        title: 'Name',
        child: TextFormField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              hintText: "Enter name",
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Enter your Name";
              } else if (val.length < 3) {
                return "Name should be greater than 3";
              } else if (val.contains(RegExp(r'[0-9]'))) {
                return "Name can't have any of numbers";
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

  Widget buildBirthday() => BuildTitleWithChild(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: user!.dateOfBirth,
          onChangedBirthday: (birthday) =>
              setState(() => user = user!.copy(dateOfBirth: birthday)),
        ),
      );

  Widget buildPets() => BuildTitleWithChild(
        title: 'Pets',
        child: PetsButtonWidget(
          pets: user!.pets,
          onSelectedPet: (pet) {
            pets = user!.pets.contains(pet)
                ? (List.of(user!.pets)..remove(pet))
                : (List.of(user!.pets)..add(pet));

            setState(() => user = user!.copy(pets: pets));
          },
        ),
      );

  Widget buildButton() => CustomButton(
      label: 'Save',
      onPress: () async {
        KeyboardUtil.hideKeyboard(context);

        if (imgSelectedFlag == true && formKey.currentState!.validate()) {
          user = user!.copy(
              id: phCtrl.text,
              name: nameCtrl.text,
              phNumber: phCtrl.text,
              password: passCtrl.text,
              dateOfBirth: birthday,
              imagePath: imagePath,
              pets: pets);
          UserPreference.setUser(context, user!);
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
        } else {
          formKey.currentState!.validate();
          setState(() => imgSelectedFlag = false);
        }

        // UserPreference.preferences.clear();
        // print(UserPreference.preferences.getKeys());

        // print("THe storage ${UserPreference.getUser("7974969426")!.password}");

        // final UserModel gotUser =
        //     UserPreference.getUser("43c8dd5d-7221-4c97-a807-34007f8946fc");
        // print("the userdata ${gotUser.name}");
      });
}
