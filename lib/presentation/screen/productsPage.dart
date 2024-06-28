import 'package:flutter/material.dart';
import 'package:flutter_task/presentation/controller/productcontroller.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../../data/model/modelproduct.dart';
import 'cartpage.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
 final TextEditingController searchController = TextEditingController();
 final ProductController _productController = Get.find<ProductController>();

 @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: badges.Badge(
              showBadge: true,
              ignorePointer: false,
              badgeContent:  Obx(() => Text(_productController.cartCount.toString(),style: const TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),),
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                padding: const EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(4),
                badgeColor: Colors.blue,


                elevation: 0,
              ),
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>const CartPage() ));
              },
                  icon: const Icon(Icons.shopping_cart)),
            ),
          ),
        ]
      ),
      body: Column(
        children: [
          searchWidget(),
          const SizedBox(height: 5,),
          Expanded(
            child: GetBuilder<ProductController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller. inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: Container(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: controller.filteredItems.length,
                          itemBuilder: (context,index){
                            final product =controller.filteredItems[index];

                             return Stack(
                                 children:[
                                   Card(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         _itemImage(product.image.toString()),
                                         const SizedBox(height: 5,),
                                         Row(
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.only(left: 5.0),
                                               child: Text(product.name.toString(),
                                                 overflow: TextOverflow.ellipsis,
                                                 maxLines: 1,
                                                 textAlign: TextAlign.start,
                                                 style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey),),
                                             ),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.only(left: 8.0),
                                               child: Text('\$ ${product.lowestUnit!.salePrice.toString()}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   Positioned(
                                       left:150,
                                       child: IconButton(onPressed: (){
                                         ModelProduct model = ModelProduct(id: product.id,image:product.image.toString(),name:product.name.toString(),salePrice: double.parse(product.lowestUnit!.salePrice.toString()), quantity: 1);
                                         _productController.addToCart(product.id!,model);
                                       }, icon: const Icon(Icons.shopping_bag_outlined)))  //cardClick == true? const Icon(Icons.shopping_bag):
                                 ]
                             );

                          }),
                    ),
                  );
                }
            ),
          ),


        ],
      ),
    );
  }
  Widget searchWidget(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: searchController,
        onChanged: (value){
          _productController.setSearchText(value);
        },
        decoration: InputDecoration(
          fillColor:  Colors.white,
          filled: true,
          label: const Text('Search'),
          suffixIcon:searchController.text.isEmpty?
          null:IconButton(
              onPressed: (){
                setState(() {
                  searchController.clear();
                });
              }, icon: searchController.text.isNotEmpty?const Icon(Icons.close,color: Colors.grey,):const SizedBox(),
          ),
          border: const OutlineInputBorder(),
        ),

      ),
    );
  }
 Widget _itemImage(String image){
   return ClipRRect(
     borderRadius: BorderRadius.circular(15.0),
     child: Image.network(image,width: 150,height: 130,),

   );
 }

}
