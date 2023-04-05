import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/services/hive_service.dart';
import 'src/views/loading_screen.dart';

void main() async {WidgetsFlutterBinding.ensureInitialized();
  await Get.put(HiveService()).onInitForApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}
