import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:miaged/assets/background.dart';
import 'package:miaged/screens/clothes_list.dart';

class UserProfile extends StatefulWidget {



  const UserProfile({Key? key}): super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();


}


class _UserProfileState extends State<UserProfile> {


  final int _selectedIndex = 2;
  DateTime birth = DateTime.now();
  String postalCode = "";
  String ville = "";
  String pass = "";
  String addressField = "";

  void _onItemTapped(int index) {
    if(index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClothesList())
      );
    }
    else if(index == 1) {
      //TODO Panier
    }
  }

  @override
  void initState() {
    initUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: const [
              Background(),
            ]
          ),
          Center(
             child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Text(
                      "Bienvenue",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    buildTextField("Login", FirebaseAuth.instance.currentUser!.email.toString(), true),
                    buildPasswordField("Password", pass),
                    buildDateField(birth),
                    buildAddressField("Adresse", false),
                    buildPostalCode(),
                    buildCityField("Ville", false),

                    ElevatedButton(
                      onPressed: () => {
                        updateUser(addressField, birth, postalCode, ville)
                      },
                      child: const Text(
                        "Modifier mes informations"
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!.updatePassword(pass);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Password Change"),
                                content: const Text(
                                    "Your password has been succesfully change"),
                                elevation: 10.0,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              )
                          );
                        },
                        child: const Text(
                        "Reinitialiser le mot de passe",
                        style: TextStyle(color: Colors.white),
                        )
                    )
                  ],
                )
             )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Acheter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void updateUser(String address, DateTime birth, String postalCode, String ville) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    user.get().then((value) => {
      value.docs.forEach((element) {
        if(element['login'] == FirebaseAuth.instance.currentUser!.email) {
          user.doc("/" + element.id).update({'address': address, 'birth': Timestamp.fromDate(birth), 'postalCode': postalCode, 'ville': ville});
        }
      })
    });
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
              onChanged: (value) {
                filledText = value;
              },
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
                labelText: pass,
              ),
              obscureText: true,
              onChanged: (value) {
                pass = value;
                print(pass);
              },
            )
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildDateField(DateTime dateField) {
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
          child: DateTimeFormField(
            onDateSelected: (value) {
              birth = value;
            },
            initialValue: birth,
            mode: DateTimeFieldPickerMode.date,
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
           onChanged: (value) {
             postalCode = value;
           },
           maxLength: 5,
           decoration: InputDecoration(
             border: InputBorder.none,
             contentPadding: const EdgeInsets.only(top: 14.0),
             labelText: postalCode,
             fillColor: Colors.white,
           ),
         ),
       ),
       const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildAddressField(String header, bool isEnabled) {
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
              onChanged: (value) {
                addressField = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: addressField,
                fillColor: Colors.white,
              ),
            )
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget buildCityField(String header, bool isEnabled) {
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
              onChanged: (value) {
                ville = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: ville,
                fillColor: Colors.white,
              ),
            )
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Future<void> initUserData() async {

      CollectionReference user = FirebaseFirestore.instance.collection('users');
      user.get().then((value) =>
      {
        value.docs.forEach((element) {
          if (element['login'] == FirebaseAuth.instance.currentUser!.email) {
            setState(() {
              addressField = element['address'];
              Timestamp ts = element['birth'];
              birth = DateTime.parse(ts.toDate().toString());
              postalCode = element['postalCode'];
              ville = element['ville'];
            });
          }
        })
      });

  }



}