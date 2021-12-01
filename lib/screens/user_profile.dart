import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:miaged/assets/background.dart';

class UserProfile extends StatefulWidget {

  const UserProfile({Key? key}): super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}


class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
                  Background(),
                ]
          ),
          Center(
             child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Text(
                      'Your profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    buildTextField("Login", "Votre Login", true),
                    buildPasswordField("Password", "password"),
                    buildDateField(),
                    buildTextField("Adresse", "Votre adresse", false),
                    buildPostalCode(),
                    buildTextField("Ville", "ville", false),
                  ],
                )
             )
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String header, String filledText, bool isEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              readOnly: isEnabled,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: filledText,
                fillColor: Colors.white,
              ),
            )
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildPasswordField(String header, String filledText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                labelText: filledText,
              ),
              obscureText: true,
            )
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildDateField() {
    DateTime? selectedDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        const Text(
          'Anniversaire',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: DateTimeField(
            onDateSelected: (DateTime value) {
              setState(() {
                selectedDate = value;
              });
            },
            selectedDate: selectedDate,
            decoration: const InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildPostalCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const SizedBox(height: 5.0),
       const Text(
          "Code Postal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
       Container(
         alignment: Alignment.centerLeft,
         child: TextField(
           keyboardType: TextInputType.number,
           inputFormatters: [
             FilteringTextInputFormatter.digitsOnly
           ],
           maxLength: 5,
           decoration: const InputDecoration(
             border: InputBorder.none,
             contentPadding: EdgeInsets.only(top: 14.0),
             labelText: "Votre code postal",
             fillColor: Colors.white,
           ),
         ),
       ),
       const SizedBox(height: 5.0),
      ],
    );
  }

}