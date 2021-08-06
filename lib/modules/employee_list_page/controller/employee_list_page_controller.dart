import 'package:employ_list/core/constants/utils/enums/api_call_status_enum.dart';
import 'package:employ_list/core/controllers/sql_database_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:employ_list/modules/employee_list_page/repositories/employee_list_fetch_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmployeeListController extends GetxController {
  // final _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;

  RxList employeeList = [].obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.loading.obs;

  GetEmployeeListRepository _getEmployeeListRepository =
      GetEmployeeListRepository();

  @override
  void onReady() {
    // fetching employee list from db
    fetchEmployeeList();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchEmployeeList() async {
    debugPrint("Entered fetchEmployeeList function");
    try {
      var list =
          await Get.find<SQLDatabaseController>().getEmployeeListFromDB();
      debugPrint("Employee list count from db :- ${list.length}");
      if (list.length == 0) {
        var list = await getEmployeeList(_getEmployeeListRepository);
        var fromDBList = await Get.find<SQLDatabaseController>()
            .addEmployeeListToDatabase(list);
        debugPrint("Employee list count added db :- ${fromDBList.length}");
      }
    } catch (e) {
      debugPrint("Error occurred while while fetching data from db :- $e");
      var list = await getEmployeeList(_getEmployeeListRepository);
      var fromDBList = await Get.find<SQLDatabaseController>()
          .addEmployeeListToDatabase(list);
      debugPrint("Employee list count added db :- ${fromDBList.length}");
    }
  }

  // employee list is fetched from api
  Future<List<EmployeeListDataModel>> getEmployeeList(
      GetEmployeeListRepository getEmployeeListRepository) async {
    var list = await getEmployeeListRepository.fetchEmployeeList();
    apiCallStatus.value = ApiCallStatus.success;

    return list;
  }
}
