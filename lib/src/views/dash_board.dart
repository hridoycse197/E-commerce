import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/models/product_model.dart';
import 'package:leadsecommerce/src/widgets/vertical_space_widget.dart';
import '../config/base.dart';
import '../widgets/custom_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatelessWidget with Base {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.abc),
            ),
          ),
          backgroundColor: const Color(0xff242730),
          title: Ktext(text: 'Hridoy', fontColor: Colors.white),
        ),
        backgroundColor: const Color(0xff242730),
        body: SafeArea(
          child: Obx(
            () => productC.allCategories.isEmpty
                ? Center(child: Ktext(text: 'No Categories Available'))
                : GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    children: productC.allCategories
                        .map(
                          (x) => FutureBuilder(
                              future: productC.getAllProducts(cat: x),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Card(
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
                                  );
                                } else {
                                  List<ProductModel> y = snapshot.data;
                                  return Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(y.first.images.first),
                                            ),
                                          )),
                                        )),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Ktext(
                                              text: x,
                                              fontColor: Colors.black,
                                            ),
                                            Ktext(
                                              text: y.length.toString(),
                                              fontColor: Colors.black,
                                            )
                                          ],
                                        ),
                                        SpaceVertical(vertical: 10)
                                      ],
                                    ),
                                  );
                                }
                              }),
                        )
                        .toList(),
                  ),
          ),
        ));
  }
}
