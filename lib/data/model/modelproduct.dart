import 'package:get/get_rx/get_rx.dart';

class ModelProduct{
  final int? id;
  final String? name;
  final String? image;
   var quantity=1.obs;
  final double salePrice;

  ModelProduct({this.id, this.name, this.image,required this.salePrice, required quantity});

  ModelProduct.fromMap(Map<String,dynamic>res, this.id, this.name, this.image, this.salePrice,this.quantity);
  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'name':name,
      'image':image,
      'quantity':quantity.value,
      'salePrice':salePrice
    };
  }


  double get totalPrice => salePrice * quantity.value;
}


