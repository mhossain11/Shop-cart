import 'package:flutter_task/presentation/controller/productcontroller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ProductController());
  }
}
