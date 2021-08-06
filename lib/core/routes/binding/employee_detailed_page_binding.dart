import 'package:employ_list/modules/employee_details_view/controller/employee_detailed_view_controller.dart';
import 'package:get/get.dart';

class EmployeeDetailedViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDetailedViewController());
  }
}