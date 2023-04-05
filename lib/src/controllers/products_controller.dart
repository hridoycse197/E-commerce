import 'dart:developer';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:leadsecommerce/src/models/user.dart';
import 'package:leadsecommerce/src/views/set_profile_screen.dart';
import 'package:leadsecommerce/src/widgets/k_log.dart';

import '../models/product_model.dart';
import '../services/api_services.dart';
import '../views/dash_board.dart';

class ProductController extends GetxController with ApiServices {
  final isLoading = RxBool(true);
  final allCategories = RxList<String>([]);
  final selectedCatName = Rx<String>('');  final textEditingText = Rx<String>('');
  late Box<User> userBox;
  final allProducts = RxList<ProductsCatModel>([]);
  final selectedProductList = RxList<ProductModel>([]);
  final image = Rx<Uint8List?>(null);
  final userName = Rx<String>(''); final text =Rx< TextEditingController?>(null);
  @override
  void onReady() {
    userBox = Hive.box<User>('user');
    super.onInit();
    if (allProducts.isEmpty) {
      getAllCategories();
    }
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
        await recall();
      }

      //  offAll(ProjectDashboardv1());
    } catch (e) {
      print(e);
    }
  }

  recall() async {
    for (var element in allCategories) {
      await getAllProducts(cat: element);
    }
    kLog('${allCategories.length} + ${allProducts.length}');
    isLoading.value = false;
    if (userBox.containsKey('loggedIn')) {
      image.value = userBox.get('loggedIn')!.images;
      userName.value = userBox.get('loggedIn')!.name!;
      Get.to(() => DashboardScreen());
    } else {
      Get.to(() => SetProfileScreen());
    }
  }

  getAllProducts({required String cat}) async {
    try {
      final res = await getDynamic(
        path: 'https://dummyjson.com/products/category/$cat',
      );
      kLog('https://dummyjson.com/products/category/$cat');

      if (res.statusCode == 200) {
        final productList = res.data['products']
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProductModel>() as List<ProductModel>;

        if (allProducts.isNotEmpty) {
          if (allProducts.any((element) => element.catName == cat)) {
          } else {
            allProducts.add(ProductsCatModel(catName: cat, productList: productList));
          }
        } else {
          allProducts.add(ProductsCatModel(catName: cat, productList: productList));
        }
        kLog(allProducts.length);
      }
    } catch (e) {
      print(e);
    }
  }
}
