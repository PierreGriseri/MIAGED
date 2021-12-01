
class Users {
  final String login;
  final String password;

  Users({
    required this.login,
    required this.password,
});

  Map<String, dynamic> toJson() => {
    'login': login,
    'password': password,
  };


}