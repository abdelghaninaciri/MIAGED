import 'package:cloud_firestore/cloud_firestore.dart';

class Products
{
  String? marque;
  String? taille;
  String? titre;
  String? image;

  Products({
    this.marque,
    this.taille,
    this.titre,
    this.image,

  });
  Products.fromJson(Map<String, dynamic> json)
  {
    marque = json['marque'];
    taille = json['taille'];
    titre = json['titre'];
    image = json['image'];

  }

  Map<String,dynamic> toJson()
  {
    Map<String, dynamic> data = Map<String , dynamic>();
    data['marque'] = marque;
    data['taille'] = taille;
    data['titre'] = titre;
    data['image'] = image;

    return data;
  }

}