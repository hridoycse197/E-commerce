import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/models/product_model.dart';
import 'package:leadsecommerce/src/views/set_profile_screen.dart';
import 'package:leadsecommerce/src/widgets/k_log.dart';
import 'package:leadsecommerce/src/widgets/vertical_space_widget.dart';
import '../config/base.dart';
import '../widgets/custom_text_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'product_list_view_screen.dart';

class DashboardScreen extends StatelessWidget with Base {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: GestureDetector(
                  onTap: () {
                    productC.image.value = productC.userBox.get('loggedIn')!.images;
                    productC.userName.value = productC.userBox.get('loggedIn')!.name!;
                    Get.to(() => SetProfileScreen());
                  },
                  child: const Icon(Icons.edit)),
            ),
          ],
          elevation: 5,
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: MemoryImage(productC.image.value!)),
                ),
              )),
          backgroundColor: Color.fromARGB(255, 165, 184, 241),
          title: Ktext(text: productC.userName.value, fontColor: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 165, 184, 241),
        body: SafeArea(
          child: Obx(
            () => productC.allCategories.isEmpty
                ? Center(child: Ktext(text: 'No Categories Available'))
                : GridView(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    children: productC.allCategories
                        .map((x) => productC.isLoading.value
                            ? Card(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: Shimmer.fromColors(
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.yellow,
                                            child: const Icon(
                                              Icons.photo,
                                              size: 90,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Ktext(
                                            text: x,
                                            fontColor: Colors.black,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  productC.selectedCatName.value = x;
                                  kLog(productC
                                      .allProducts[productC.allProducts
                                          .indexWhere((element) => element.catName == productC.selectedCatName.value)]
                                      .productList
                                      .length);
                                  Get.to(() => ProductListViewScreen());
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(productC
                                                      .allProducts[productC.allProducts.indexWhere((element) => element.catName == x)]
                                                      .productList
                                                      .first
                                                      .thumbnail),
                                                ),
                                              )))),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Ktext(
                                            text: x,
                                            fontColor: Colors.black,
                                          ),
                                          Ktext(
                                            text: productC
                                                .allProducts[productC.allProducts.indexWhere((element) => element.catName == x)]
                                                .productList
                                                .length
                                                .toString(),
                                            fontColor: Colors.black,
                                          )
                                        ],
                                      ),
                                      SpaceVertical(vertical: 10)
                                    ],
                                  ),
                                ),
                              ))
                        .toList(),
                  ),
          ),
        ));
  }
}
