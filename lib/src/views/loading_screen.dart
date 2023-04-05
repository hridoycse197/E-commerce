import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadsecommerce/src/widgets/k_log.dart';

import '../config/base.dart';
import 'dash_board.dart';

class LoadingScreen extends StatelessWidget with Base {
  LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       
        backgroundColor:  Color(0xff242730),
        body:  SafeArea(
          child: Center(
            child: Text(
              'Loading.....',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
