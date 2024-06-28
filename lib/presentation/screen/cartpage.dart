import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../controller/productcontroller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductController _productController = Get.find<ProductController>();
  @override
  void initState() {
    super.initState();
    _productController.inProgress;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cart Products'),
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
                child: IconButton(onPressed: (){},
                    icon: const Icon(Icons.shopping_cart)),
              ),
            ),
          ]
      ),
      body: Stack(
        children: [
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: GetBuilder<ProductController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller. inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.cartList.length,
                              itemBuilder: (context,index){
                                final cartProduct =controller.cartList[index];
                                return SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 150,
                                  child: Card(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        _itemImage(cartProduct.image.toString()),
                                        const SizedBox(height: 5,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(cartProduct.name.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey),),
                                            const SizedBox(height: 5,),
                                            Text('\$ ${cartProduct.salePrice.toString()}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [

                                                IconButton(onPressed: (){controller.increment(cartProduct.id!);}, icon: const Icon(Icons.arrow_back_ios)),
                                                 Text(cartProduct.quantity.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                IconButton(onPressed: (){controller.decrement(cartProduct.id!);}, icon: const Icon(Icons.arrow_forward_ios))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: IconButton(onPressed: (){
                                            controller.deleteToCart(index);
                                          }, icon: const Icon(Icons.delete)),
                                        ),


                                      ],
                                    ),
                                  ),
                                );


                              }),
                        );

                      }
                  ),
                ),
            
            
            
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadiusDirectional.circular(10)

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Total Amount:',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(width: 10,),
            Obx(() => Text('\$${_productController.totalPrice.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))
            ],
          ),

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
