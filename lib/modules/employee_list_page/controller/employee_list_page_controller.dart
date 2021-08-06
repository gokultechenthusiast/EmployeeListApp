import 'package:employ_list/core/controllers/internet_connectivity_controller.dart';
import 'package:employ_list/core/controllers/sql_database_controller.dart';
import 'package:employ_list/core/utils/enums/api_call_status_enum.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:employ_list/modules/employee_list_page/repositories/employee_list_fetch_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmployeeListController extends GetxController {
  RxList employeeList = [].obs; // list is populated with this array
  List<EmployeeListDataModel> totalList = []; // total employee list
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.loading.obs;

  GetEmployeeListRepository _getEmployeeListRepository =
      GetEmployeeListRepository();

  var searchController = new TextEditingController(); // for search in home page

  // when ever searched this becomes true
  var isSearch = false.obs;
  var searchText = "".obs; // list is filtered based on this text

  @override
  void onReady() {
    // fetching employee list from db
    fetchEmployeeList();
    debounce(searchText, (value) {
      // this is used because when there is no change in text for 1 second
      // only filtering is done.
      if (value.toString().isNotEmpty) {
        // filtering based on the query that search string
        // exist in either name or email of each employee
        isSearch.value = true;
        debugPrint("Total list array length before search ${totalList.length}");
        employeeList.clear();
        totalList.forEach((element) {
          debugPrint("email = ${element.email}");
          debugPrint("name = ${element.name}");
          if (element.name!.toLowerCase().contains(value.toString()) ||
              element.email!.toLowerCase().contains(value.toString())) {
            employeeList.add(element);
          }
        });
      } else {
        // when search string is empty show old list
        isSearch.value = false;
        employeeList.clear();
        employeeList.addAll(totalList);
      }
    }, time: Duration(seconds: 1));
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchEmployeeList() async {
    // here checked if db has list if not api is
    // called
    debugPrint("Entered fetchEmployeeList function");
    try {
      var list =
          await Get.find<SQLDatabaseController>().getEmployeeListFromDB();
      debugPrint("Employee list count from db :- ${list.length}");
      if (list.length == 0) {
        // when list is empty api is called.
        var apiList = await getEmployeeList(_getEmployeeListRepository);
        // data from api is added to the db
        employeeList.addAll(apiList);
        print("Total array count after api call :- ${totalList.length}");
        Get.find<SQLDatabaseController>().addEmployeeListToDatabase(apiList);
      }
    } catch (e) {
      debugPrint("Error occurred while while fetching data from db :- $e");
      Get.find<InternetConnectivityController>()
          .isInternet()
          .then((value) async {
        if (value) {
          var apiList = await getEmployeeList(_getEmployeeListRepository);
          employeeList.addAll(apiList);
          print("Total array count after api call :- ${totalList.length}");
          Get.find<SQLDatabaseController>().addEmployeeListToDatabase(apiList);
        } else {
          apiCallStatus.value = ApiCallStatus.error;
        }
      });
    }
  }

  // employee list is fetched from api
  Future<List<EmployeeListDataModel>> getEmployeeList(
      GetEmployeeListRepository getEmployeeListRepository) async {
    var list = await getEmployeeListRepository.fetchEmployeeList();
    return list;
  }
}
