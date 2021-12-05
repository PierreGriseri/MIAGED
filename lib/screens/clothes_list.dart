import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/model/clothe.dart';
import 'package:miaged/screens/clothes_detail.dart';
import 'package:miaged/screens/user_profile.dart';


class ClothesList extends StatefulWidget {

  const ClothesList({Key? key}): super(key: key);

  @override
  _ClothesListState createState() => _ClothesListState();
}


class _ClothesListState extends State<ClothesList> {

  final int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if(index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ClothesList())
      );
    }
    else if(index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClothesList())
      );
    }
    else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile())
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des articles")
      ),
      body: Card (
        margin: const EdgeInsets.all(10),
        color: Colors.green[100],
        shadowColor: Colors.blueGrey,
        elevation: 10,
        child: buildListView(context),
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


  void goToDetail(Map<String, dynamic> data) {
    Clothe _myObj = Clothe(titre: data['titre'], image: data['image'], marque: data['marque'], size: data['size'], price: data['price']);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ClothesDetail(clothe: _myObj)));
  }


  Widget getImage(String data)  {
    String url = data;
    NetworkImage image = NetworkImage(url);
    return Image(image: image);
  }



  Widget buildListView(context) {
    final Stream<QuerySnapshot> _objectStream = FirebaseFirestore.instance.collection('object').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _objectStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                ListTile(
                  leading: const Icon (
                      Icons.info_outline,
                      color: Colors.cyan,
                      size: 45
                  ),
                  title: Text(
                    data['titre'],
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(data['price'].toString()),
                  onTap: () {
                    goToDetail(data);
                  },
                ),
                getImage(data['image']),
              ]
            );
          }).toList(),
        );
      },
    );
  }
}
