class User{
  String name;
  String email;

  User({required this.name, required this.email});

  String getName() => name;
  String getEmail() => email;

  void setName(String newName) => name = newName;
  void setEmail(String newEmail) => email = newEmail;

  factory User.froomJson(Map<String, dynamic> json){
    return User(
      name: json['user_name'],
      email: json['user_email']
    );
  }

  @override
  String toString(){
    return "{name: $name, email: $email}";
  }

}