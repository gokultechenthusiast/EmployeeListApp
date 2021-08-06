import 'package:employ_list/core/routes/binding/employee_page_binding.dart';
import 'package:get/get.dart';

import 'page_exports.dart';

part 'route_name_constants.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RouteNamesConstants.homePageRoute,
      page: () => EmployeeListPage(),
      binding: EmployeePageBinding(),
    ),
  ];
}
