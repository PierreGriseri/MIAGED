import 'package:flutter/material.dart';
import 'package:miaged/assets/background.dart';
import 'package:miaged/model/clothe.dart';



class ClothesDetail extends StatelessWidget {

  final Clothe clothe;

  const ClothesDetail({Key? key, required this.clothe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(clothe.marque + ", " + clothe.titre),
          ),
        body: Card (
          margin: const EdgeInsets.all(10),
          color: Colors.green[100],
          shadowColor: Colors.black,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon (
                    Icons.add_shopping_cart,
                    color: Colors.cyan,
                    size: 45
                ),
                title: Text(
                  clothe.titre,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: const Text('Modern Talking Album'),
              ),
              Image(
                  image: NetworkImage(clothe.image)
              )
            ],
          ),
        ),
      );
    }


  }
