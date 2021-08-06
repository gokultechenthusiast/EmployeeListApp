import 'package:employ_list/core/controllers/sql_database_controller.dart';
import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EmployeeListController>();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
          color: Colors.grey),
      child: new TextField(
        controller: controller.searchController,
        onChanged: (value) {
          debugPrint("Text changed to $value");
          if (controller.totalList.length == 0) {
            var text = value;
            Get.find<SQLDatabaseController>()
                .getEmployeeListFromDB()
                .then((value) {
              controller.totalList.clear();
              controller.totalList.addAll(value);
              controller.searchText.value = text;
            });
          } else {
            controller.searchText.value = value;
          }
        },
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Search"),
        textAlign: TextAlign.center,
      ),
    );
  }
}
