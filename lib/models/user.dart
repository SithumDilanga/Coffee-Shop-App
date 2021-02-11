class UserData {
  final String name;
  final String email;
  final String password;

  UserData({this.name, this.email, this.password})
  : assert(name != null),
    assert(email != null);


}