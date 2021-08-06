import 'package:employ_list/core/constants/utils/enums/api_call_status_enum.dart';
import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EmployeeListController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: Obx(() {
        switch (controller.apiCallStatus.value) {
          case ApiCallStatus.loading:
            return Center(
              child: CircularProgressIndicator(
                key: Key("EmployeeCircularProgressBar"),
              ),
            );
          case ApiCallStatus.error:
            return Center(
              child: Text("Something went wrong!"),
            );
          default:
            return controller.employeeList.length != 0
                ? ListView.builder(
                    // the list of favorite locations
                    itemCount: controller.employeeList.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 10,
                      child: ListTile(
                        title: Text(
                          (controller.employeeList[index]
                                  as EmployeeListDataModel)
                              .name!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text((controller.employeeList[index]
                                as EmployeeListDataModel)
                            .email!),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No favorite places added!",
                      key: Key("NoFavouritePlaceText"),
                    ),
                  );
        }
      }),
    );
  }
}
