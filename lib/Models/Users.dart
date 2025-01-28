class Users {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;

  const Users(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.username,
      required this.password});

  const Users.empty(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phone = '',
      this.username = '',
      this.password = ''});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      firstName: json['FIRST_NAME'],
      lastName: json['LAST_NAME'],
      email: json['EMAIL'],
      phone: json['PHONE'],
      username: json['USERNAME'],
      password: json['PASSWORD']);

  Map<String, dynamic> toJson() => {
        "FIRST_NAME": firstName,
        "LAST_NAME": lastName,
        "EMAIL": email,
        "PHONE": phone,
        "USERNAME": username,
        "PASSWORD": password,
      };
}
