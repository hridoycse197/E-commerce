
import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class Base {
  
  final productC = Get.put(ProductController());
}