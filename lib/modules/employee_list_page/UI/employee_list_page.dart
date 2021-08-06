import 'package:cached_network_image/cached_network_image.dart';
import 'package:employ_list/core/routes/routes.dart';
import 'package:employ_list/core/utils/enums/api_call_status_enum.dart';
import 'package:employ_list/modules/employee_list_page/UI/widgets/employee_listview.dart';
import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/search_textfield.dart';

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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // search container is shown when there is
                  // data or a search has performed.
                  if (controller.employeeList.length != 0 ||
                      controller.isSearch.value == true)
                    SearchTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  // list view only shown when the array is not empty
                  controller.employeeList.length != 0
                      ? EmployeeListView()
                      : Center(
                          child: Text(
                            "No employee list available",
                            key: Key("NoFavouritePlaceText"),
                          ),
                        ),
                ],
              ),
            );
        }
      }),
    );
  }
}
