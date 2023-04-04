import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:leadsecommerce/src/widgets/k_log.dart';

import '../models/product_model.dart';
import '../services/api_services.dart';
import '../views/dash_board.dart';

class ProductController extends GetxController with ApiServices {
  final isLoading = RxBool(true);
  final allCategories = RxList<String>([]);
  final allProducts = RxList<ProductsCatModel>([]);
  @override
  void onReady() {
    // TODO: implement onInit
    super.onInit();
    getAllCategories();
  }

  getAllCategories() async {
    try {
      final res = await getDynamic(
        path: 'https://dummyjson.com/products/categories',
      );
      if (res.statusCode == 200) {
        //  print(res.data);
        final allCat = res.data;
        allCategories.clear();
        for (var element in allCat) {
          allCategories.add(element);
        }
        print(allCategories.length);

        allProducts.clear();
        //   await recall();
        Get.to(() => DashboardScreen());
        log(allProducts.length.toString());
      }

      //  offAll(ProjectDashboardv1());
    } catch (e) {
      print(e);
    }
  }

  Future getAllProducts({required String cat}) async {
    List<ProductModel> products = [];
    try {
      isLoading.value = true;

      final res = await getDynamic(
        path: 'https://dummyjson.com/products/category/$cat',
      );
      kLog('https://dummyjson.com/products/category/$cat');

      if (res.statusCode == 200) {
        //  print(res.data);
        products = res.data['products']
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProductModel>() as List<ProductModel>;
        kLog(products.first.category);
        kLog(products.first.images.length);
      }

      return products;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }
}
