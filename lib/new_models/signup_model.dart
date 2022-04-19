class SignUpBody {
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String uid;

  SignUpBody(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone,
      required this.uid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    return data;
  }
}
