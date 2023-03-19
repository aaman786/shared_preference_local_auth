class UserModel {
  final String id;
  final String name;
  final String phNumber;
  final DateTime? dateOfBirth;
  final String? imagePath;
  final String password;
  final List<String> pets;
  // final Settings settings;

  UserModel({
    required this.id,
    required this.name,
    required this.phNumber,
    required this.dateOfBirth,
    required this.imagePath,
    required this.pets,
    required this.password,
    // this.settings = const Settings(),
  });

  UserModel copy({
    String? id,
    String? name,
    String? phNumber,
    DateTime? dateOfBirth,
    String? imagePath,
    String? password,
    List<String>? pets,

    // Settings settings,
  }) =>
      UserModel(
        password: password ?? this.password,
        id: id ?? this.id,
        name: name ?? this.name,
        phNumber: phNumber ?? this.phNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        imagePath: imagePath ?? this.imagePath,
        pets: pets ?? this.pets,
        // settings: settings ?? this.settings,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        phNumber: json['phNumber'],
        dateOfBirth: DateTime.tryParse(json['dateOfBirth']),
        imagePath: json['imagePath'],
        pets: List<String>.from(json['pets']),
        // settings: Settings.fromJson(json['settings']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'phNumber': phNumber,
        'dateOfBirth': dateOfBirth!.toIso8601String(),
        'imagePath': imagePath,
        'pets': pets,
        // 'settings': settings.toJson(),
      };

  @override
  String toString() =>
      'UserModel{id: $id, name: $name,dateOfbirth: $dateOfBirth,pets: $pets,imagePath: $imagePath, password: $password}';
}
