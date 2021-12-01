import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/assets/background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/screens/user_profile.dart';


class ClothesList extends StatefulWidget {

  const ClothesList({Key? key}): super(key: key);

  @override
  _ClothesListState createState() => _ClothesListState();
}


class _ClothesListState extends State<ClothesList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  const Background(),
                  Container(
                    child: buildListView(context),
                  ),
                ]
              )
            )
        )
    );
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
            return ListTile(
              title: Text(data['titre']),
              subtitle: Text(data['marque']),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile()));
              },
            );
          }).toList(),
        );
      },
    );
  }
}

//FOR EACH POUR AFFICHAGE
/*FirebaseFirestore.instance
    .collection('users')
.get()
    .then((QuerySnapshot querySnapshot) {
querySnapshot.docs.forEach((doc) {
print(doc["first_name"]);
});
});*/