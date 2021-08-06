import 'package:employ_list/core/controllers/internet_connectivity_controller.dart';
import 'package:employ_list/core/controllers/sql_database_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InternetConnectivityController(), fenix: true);
    Get.put(SQLDatabaseController());
  }
}
