import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<void> openLoading() async {
  await Future.delayed(Duration.zero,
      () => Get.dialog(circularProgressIndicator(), barrierDismissible: false));
}

Center circularProgressIndicator({double? value}) => Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          backgroundColor: Color.fromARGB(255, 195, 192, 192),
          color: Colors.amberAccent,
          value: value,
        ),
      ),
    );

void closeLoading() => Get.close(0);
