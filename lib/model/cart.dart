import 'package:miaged/model/clothe.dart';
import 'package:miaged/model/users.dart';

class Cart {
  final List<Clothe> list;
  final Users owner;
  final int price = 0;

  Cart({
    required this.list,
    required this.owner,
  });

  Map<String, dynamic> toJson() => {
    'list': list,
    'user': owner,
  };


}