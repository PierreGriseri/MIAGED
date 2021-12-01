import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClothesList extends StatefulWidget {

  const ClothesList({Key? key}): super(key: key);

  @override
  _ClothesListState createState() => _ClothesListState();
}


class _ClothesListState extends State<ClothesList> {

  @override
  Widget build(BuildContext context) {
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
            return Text(
              data['titre'] + ", " + data['marque']
              //title: Text(data['titre']),
              //subtitle: Text(data['marque']),
            );
          }).toList(),
        );
      },
    );
  }

}