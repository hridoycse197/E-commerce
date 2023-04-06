import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/views/dash_board.dart';

import '../config/base.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/vertical_space_widget.dart';

class CartDetailsScreen extends StatefulWidget {
  CartDetailsScreen({super.key});

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> with Base {
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
                : Obx(
                    () => SizedBox(
                      height: Get.height,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: productC.cartProducts.length,
                                itemBuilder: (context, index) {
                                  final x = productC.cartProducts[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Card(
                                      elevation: 8,
                                      child: Column(
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
                                                      image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(x!.thumbnail))),
                                                ),
                                                SpaceHorizontal(horizontal: 20),
                                                SizedBox(
                                                  width: Get.width * .46,
                                                  child: Column(
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
                                                        text: '${x.brand} ',
                                                        fontColor: Colors.black,
                                                        bold: true,
                                                        fontSize: 16,
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (productC
                                                                          .cartProducts[productC.cartProducts
                                                                              .indexWhere((element) => element!.id == x.id)]!
                                                                          .quantity >
                                                                      1) {
                                                                    productC
                                                                        .cartProducts[productC.cartProducts
                                                                            .indexWhere((element) => element!.id == x.id)]!
                                                                        .quantity--;
                                                                  }
                                                                  productC.totalPrice();
                                                                });
                                                              },
                                                              child: const Icon(Icons.remove)),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            height: 20,
                                                            width: 20,
                                                            child: Ktext(text: x.quantity.toString()),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  productC
                                                                      .cartProducts[productC.cartProducts
                                                                          .indexWhere((element) => element!.id == x.id)]!
                                                                      .quantity++;

                                                                  productC.totalPrice();
                                                                });
                                                              },
                                                              child: const Icon(Icons.add)),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Ktext(
                                                            text: '\$${x.price}',
                                                            bold: true,
                                                            fontColor: Colors.red,
                                                          ),
                                                          Ktext(
                                                            text: '\$${x.price * x.quantity}',
                                                            bold: true,
                                                            fontColor: Colors.green,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            color: Colors.white,
                            width: Get.width,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Ktext(
                                  text: 'Total: ${productC.total}',
                                  bold: true,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                content: SizedBox(
                                                  height: 100,
                                                  child: Column(
                                                    children: [
                                                      const Icon(Icons.check),
                                                      Ktext(text: 'Order Placed Successfully'),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            productC.cartProducts.clear();
                                                            productC.total.value = '';
                                                            Get.offAll(() => DashboardScreen());
                                                          },
                                                          child: Ktext(text: 'OK'))
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Ktext(text: 'Place Order'))
                              ],
                            ),
                          ),
                          SpaceVertical(vertical: 10)
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
