import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/widgets/custom_text_widget.dart';
import 'package:leadsecommerce/src/widgets/k_log.dart';

import '../config/base.dart';
import 'dash_board.dart';

class LoadingScreen extends StatelessWidget with Base {
  LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/giphy.gif',
                  height: 50,
                  width: 50,
                ),
                Ktext(text: 'Loading.....', fontColor: Colors.white),
              ],
            ),
          ),
        ));
  }
}
