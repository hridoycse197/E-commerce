import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/controllers/products_controller.dart';
import 'package:leadsecommerce/src/models/product_model.dart';
import 'package:leadsecommerce/src/widgets/vertical_space_widget.dart';

import '../config/base.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_widget.dart';
import 'dash_board.dart';
class ProductDescriptionScreen extends StatelessWidget with Base {
  ProductDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: CustomAppbar()),
      backgroundColor: const Color.fromARGB(255, 232, 230, 230),
      body: SafeArea(
          child: Column(
        children: [
          SpaceVertical(vertical: 10),
          Container(
            color: Colors.white,
            height: Get.height * .45,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: productC.selectedProduct.value!.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(fit: BoxFit.cover, image: NetworkImage(productC.selectedProduct.value!.images[index]))),
                      width: Get.width,
                    ),
                  );
                }),
          ),
          SpaceVertical(vertical: 10),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.withOpacity(.3),
                  ),
                  width: Get.width - 5,
                  child: Card(
                    elevation: 20,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                Ktext(
                                  bold: true,
                                  text: productC.selectedProduct.value!.title,
                                  fontColor: Colors.black,
                                  fontSize: 25,
                                ),
                                SpaceHorizontal(horizontal: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Ktext(
                                      maxLines: 3,
                                      text: '(${productC.selectedProduct.value!.rating} / 5)',
                                      fontColor: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SpaceVertical(vertical: 5),
                          Ktext(
                            textOverflow: TextOverflow.visible,
                            text: productC.selectedProduct.value!.description,
                            fontColor: Colors.black,
                            fontSize: 16,
                          ),
                          SpaceVertical(vertical: 5),
                          Row(
                            children: [
                              Ktext(
                                textOverflow: TextOverflow.ellipsis,
                                text: '\$${productC.selectedProduct.value!.price} ',
                                fontColor: Colors.black,
                                bold: true,
                                fontSize: 24,
                              ),
                              Ktext(
                                textDecoration: TextDecoration.lineThrough,
                                textOverflow: TextOverflow.ellipsis,
                                text:
                                    '\$${((100 / (100 - productC.selectedProduct.value!.discountPercentage)) * productC.selectedProduct.value!.price).toStringAsFixed(2)}',
                                fontColor: Colors.red,
                                bold: true,
                              ),
                            ],
                          ),
                          SpaceVertical(vertical: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
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
                                  child: Ktext(
                                    text: 'BUY NOW',
                                    fontColor: Colors.white,
                                  )),
                              ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                                  onPressed: () {
                                    if (productC.cartProducts.isEmpty) {
                                      final x = productC.selectedProduct.value;
                                      productC.cartProducts.add(CartProductModel(
                                        id: x!.id,
                                        quantity: 1,
                                        title: x.title,
                                        brand: x.brand,
                                        price: x.price,
                                        thumbnail: x.thumbnail,
                                      ));
                                    } else {
                                      if (productC.cartProducts.any((element) => element!.id == productC.selectedProduct.value!.id)) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Colors.blue,
                                            content: Ktext(
                                              text: 'Product Already Added',
                                              bold: true,
                                              fontColor: Colors.white,
                                            )));
                                      } else {
                                        final x = productC.selectedProduct.value;
                                        productC.cartProducts.add(CartProductModel(
                                          id: x!.id,
                                          quantity: 1,
                                          title: x.title,
                                          brand: x.brand,
                                          price: x.price,
                                          thumbnail: x.thumbnail,
                                        ));
                                      }
                                    }
                                  },
                                  child: Ktext(
                                    text: 'Add to Cart',
                                    fontColor: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
          SpaceVertical(vertical: 10),
        ],
      )),
    );
  }
}
