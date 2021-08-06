import 'package:cached_network_image/cached_network_image.dart';
import 'package:employ_list/core/routes/routes.dart';
import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EmployeeListController>();
    return Flexible(
      child: ListView.builder(
        // the list of employees
        itemCount: controller.employeeList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Get.toNamed(RouteNamesConstants.detailsPageRoute,
                arguments: controller.employeeList[index]);
          },
          child: Card(
            elevation: 10,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: (controller.employeeList[index]
                                as EmployeeListDataModel)
                            .profileImage !=
                        null
                    ? CachedNetworkImageProvider((controller.employeeList[index]
                            as EmployeeListDataModel)
                        .profileImage!)
                    : AssetImage("assets/images/userDefaultImage.png")
                        as ImageProvider,
              ),
              title: Text(
                (controller.employeeList[index] as EmployeeListDataModel).name!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  (controller.employeeList[index] as EmployeeListDataModel)
                      .email!),
            ),
          ),
        ),
      ),
    );
  }
}
