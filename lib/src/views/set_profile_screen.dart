import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/config/base.dart';
import 'package:leadsecommerce/src/views/dash_board.dart';
import 'package:leadsecommerce/src/widgets/custom_text_widget.dart';
import 'package:leadsecommerce/src/widgets/vertical_space_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class SetProfileScreen extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Ktext(text: 'Set Profile'),
      ),
      body: SafeArea(
          child: Center(
        child: Obx(
          () => Column(
            children: [
              SpaceVertical(vertical: 50),
              Stack(
                children: [
                  productC.image.value != null
                      ? Container(
                          height: 100,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(fit: BoxFit.cover, image: MemoryImage(productC.image.value!))),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Icon(
                            Icons.image,
                            size: 50,
                          ),
                        ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: GestureDetector(
                        onTap: () async {
                          final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                          if (pickedImage!.path.isNotEmpty) {
                            productC.image.value = await pickedImage.readAsBytes();
                          }
                        },
                        child: const Icon(Icons.camera)),
                  ),
                ],
              ),
              SizedBox(
                  width: 150,
                  height: 20,
                  child: TextFormField(
                    initialValue: productC.userName.value,
                    onChanged: productC.textEditingText,
                    controller: productC.text.value,
                  )),
              SpaceVertical(vertical: 50),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          (productC.image.value != null && productC.textEditingText.value != '') ? Colors.green : Colors.grey)),
                  onPressed: (productC.image.value != null && productC.textEditingText.value != '')
                      ? () async {
                          await productC.userBox.put('loggedIn', User(name: productC.textEditingText.value, images: productC.image.value));
                          productC.userName.value = productC.userBox.get('loggedIn')!.name!;
                          Get.to(() => DashboardScreen());
                        }
                      : () {},
                  child: Ktext(text: 'Save'))
            ],
          ),
        ),
      )),
    );
  }
}
