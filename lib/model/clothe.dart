class Clothe {
  final String titre;
  final String image;
  final String marque;
  final String size;
  final int price;


  Clothe({
    required this.titre,
    required this.image,
    required this.marque,
    required this.size,
    required this.price,

  });

  Map<String, dynamic> toJson() => {
    'titre': titre,
    'image': image,
    'marque': marque,
    'size': size,
    'price': price,
  };

  @override
  String toString() {
    return "Objet : " + titre + ", marque : " + marque;
  }


}