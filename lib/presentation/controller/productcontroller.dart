import 'dart:convert';
import 'package:flutter_task/data/model/ProductsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task/data/utils/api.dart';
import 'package:get/get.dart';

import '../../data/model/modelproduct.dart';
import '../../data/storage/db_handler.dart';


class ProductController extends GetxController{
  late final DatabaseHelper dbHelper;
  @override
  void onInit() {
    super.onInit();
    _inProgress;
    dbHelper = DatabaseHelper();
    loadItemsFromDb();
    allProductsData();
  }

  ProductsModel productsModel =ProductsModel();
  var searchText = ''.obs;
  List<Datum>productList =List<Datum>.empty().obs;
  List<ModelProduct> cartList=List<ModelProduct>.empty().obs;
  bool _inProgress = false;
  int quantity =1;
  double price=0.0;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  int get cartCount => cartList.length;

  double get totalPrice => cartList.fold(0, (sum, item) => sum + item.totalPrice);


  Future<void> loadItemsFromDb() async {
    final items = await dbHelper.getItems();
    cartList.assignAll(items);
  }




  Future<ProductsModel> allProductsData() async{
    _inProgress = true;
    update();
      var url = ApiService.allProductsUrl;
      var header ={
        'Content-Type': 'application/json'
      };
   final http.Response response = await http.get(Uri.parse(url),
      headers: header,
    );

    var decodedResponse = jsonDecode(response.body.toString());
    _inProgress = false;
    if(response.statusCode == 200){
      productsModel = ProductsModel.fromJson(decodedResponse);
      productList.addAll(productsModel.data!.mainProducts!.data);
      update();
    }else{

      _inProgress = false;
      _errorMessage = 'failed! Try again';
      update();
    }

    return productsModel;
  }

  addToCart(int id,ModelProduct items) async{
    var existingItem = cartList.firstWhereOrNull((item) => item.id == id);
    if(existingItem != null){
      existingItem.quantity++;
      await dbHelper.updateItem(existingItem);
    }else{
      cartList.add(items);
      await dbHelper.insertItem(items);
    }
    update();
  }
  deleteToCart(int id) async{
    cartList.removeAt(id);
    await dbHelper.deleteItem(id);
    update();
  }
  increment(int id) async{
      ModelProduct item = cartList.firstWhere((item) => item.id == id );
      item.quantity += 1;
      await dbHelper.updateItem(item);
    update();
  }
  decrement(int id) async{
    update();
    ModelProduct item = cartList.firstWhere((item) => item.id == id );
    if (item.quantity > 1) {
      item.quantity--;
      await dbHelper.updateItem(item);
    }

  }

  List<Datum> get filteredItems {
    if (searchText.isEmpty) {
      return productList;
    } else {
      return productList
          .where((item) =>
          item.name!.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }
  }

  void setSearchText(String text) {
    searchText.value = text;
    update();
  }
}





