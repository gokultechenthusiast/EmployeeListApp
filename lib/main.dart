import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/binding/initial_binding.dart';
import 'core/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Employee listing app",
      initialBinding: InitialBinding(),
      initialRoute: RouteNamesConstants.homePageRoute,
      getPages: Routes.routes,
    );
  }
}
