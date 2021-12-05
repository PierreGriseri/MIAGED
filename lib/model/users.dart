
class Users {
  final String login;
  final String birthdayDate;
  final String address;
  final String postalCode;
  final String ville;

  Users({
    required this.login,
    required this.birthdayDate,
    required this.address,
    required this.postalCode,
    required this.ville,
});

  Map<String, dynamic> toJson() => {
    'login': login,
    'birthdayDate': birthdayDate,
    'address': address,
    'postalCode': postalCode,
    'ville': ville,
  };


}