import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/views/product_description_screen.dart';
import 'package:leadsecommerce/src/widgets/vertical_space_widget.dart';
import '../config/base.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_widget.dart';
import 'set_profile_screen.dart';

class ProductListViewScreen extends StatelessWidget with Base {
  ProductListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(child: CustomAppbar(), preferredSize: Size.fromHeight(kToolbarHeight)),
      backgroundColor: Color.fromARGB(255, 165, 184, 241),
        body: SafeArea(
          child: Obx(
            () => productC.allProducts[productC.allProducts.indexWhere((element) => element.catName == productC.selectedCatName.value)]
                    .productList.isEmpty
                ? Center(child: Ktext(text: 'No Products Available'))
                : SizedBox(
                    height: Get.height,
                    child: ListView(
                      shrinkWrap: true,
                      children: productC
                          .allProducts[productC.allProducts.indexWhere((element) => element.catName == productC.selectedCatName.value)]
                          .productList
                          .map((x) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  elevation: 8,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 10),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SpaceHorizontal(horizontal: 10),
                                                Container(
                                                  height: 200,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(x.thumbnail))),
                                                ),
                                                SpaceHorizontal(horizontal: 20),
                                                SizedBox(
                                                  width: Get.width * .46,
                                                  child: 
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Ktext(
                                                        maxLines: 3,
                                                        bold: true,
                                                        text: x.title,
                                                        fontColor: Colors.black,
                                                        fontSize: 20,
                                                      ),
                                                      SpaceVertical(vertical: 5),
                                                      Ktext(
                                                        textOverflow: TextOverflow.ellipsis,
                                                        text: x.description,
                                                        fontColor: Colors.black,
                                                        maxLines: 2,
                                                        fontSize: 14,
                                                      ),
                                                      SpaceVertical(vertical: 5),
                                                      Row(
                                                        children: [
                                                          Ktext(
                                                            textOverflow: TextOverflow.ellipsis,
                                                            text: '\$${x.price} ',
                                                            fontColor: Colors.black,
                                                            bold: true,
                                                            fontSize: 16,
                                                          ),
                                                          Ktext(
                                                            textDecoration: TextDecoration.lineThrough,
                                                            textOverflow: TextOverflow.ellipsis,
                                                            text:
                                                                '\$${((100 / (100 - x.discountPercentage)) * x.price).toStringAsFixed(2)}',
                                                            fontColor: Colors.red,
                                                            bold: true,
                                                          ),
                                                        ],
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            productC.selectedProduct.value = x;
                                                            Get.to(() => ProductDescriptionScreen());
                                                          },
                                                          child: Ktext(
                                                            text: 'BUY NOW',
                                                            fontColor: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 2,
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                )),
                                            child: Ktext(
                                              text: '${x.discountPercentage} %',
                                              fontColor: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
          ),
        ));
  }
}
