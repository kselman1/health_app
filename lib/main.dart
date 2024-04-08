import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:health_app/app/dependencies.dart';
import 'package:health_app/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
 Gemini.init(
    apiKey: 'AIzaSyC3x7xkh-mQ6Srxa3LjUAWkXbThLfvUz1w', enableDebugging: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
