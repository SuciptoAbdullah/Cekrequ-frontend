class UserModel{
  String name;
  String email;

  UserModel({required this.name, required this.email});

  String getName() => name;
  String getEmail() => email;

  void setName(String newName) => name = newName;
  void setEmail(String newEmail) => email = newEmail;
}