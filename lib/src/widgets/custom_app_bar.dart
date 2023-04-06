import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/views/cart_details_screen.dart';

import '../config/base.dart';
import '../views/set_profile_screen.dart';
import 'custom_text_widget.dart';

class CustomAppbar extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        GestureDetector(
          onTap: () {
            if (productC.cartProducts.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue,
                  content: Ktext(
                    text: 'No Item In Cart',
                    bold: true,
                    fontColor: Colors.white,
                  )));
            } else {
              productC.totalPrice();
              Get.to(() => CartDetailsScreen());
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SizedBox(
              width: 24,
              child: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Obx(
                    () => Visibility(
                      visible: productC.cartProducts.isNotEmpty,
                      child: Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          alignment: Alignment.center,
                          child: Ktext(bold: true, fontColor: Colors.white, text: productC.cartProducts.length.toString()),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0, left: 10),
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
      backgroundColor: Color.fromARGB(255, 197, 195, 195),
      title: Ktext(text: productC.userName.value, fontColor: Colors.white),
    );
  }
}
