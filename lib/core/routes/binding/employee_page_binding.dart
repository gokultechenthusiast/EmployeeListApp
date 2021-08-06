import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
import 'package:get/get.dart';

class EmployeePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EmployeeListController());
  }
}
