class UserModel {
  final String id;
  final String name;
  final String email;
  final double weight;
  final int age;
  final String img;
  final String gender;

  UserModel({
      required this.weight,
      required this.gender,
      required this.age,
      required this.id,
      required this.name,
      required this.email,
      required this.img});

  factory UserModel.fromSnapshot(json) {
    return UserModel(
        id: json.id,
        name: json['name'],
        email: json['email'],
        weight: json['weight'] ?? 0.0,
        age: json['age'] ?? 0,
        img: json['img'] ?? '',
        gender: json['gender'] ?? '');
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'weight': weight,
      'age': age,
      'gender' : gender
    };
  }
}
