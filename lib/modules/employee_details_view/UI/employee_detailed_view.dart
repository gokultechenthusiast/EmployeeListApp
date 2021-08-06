import 'package:cached_network_image/cached_network_image.dart';
import 'package:employ_list/modules/employee_details_view/controller/employee_detailed_view_controller.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// details of an employee is shown in this page
class EmployeeDetailedView extends StatelessWidget {
  const EmployeeDetailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var employeeDetails = Get.arguments as EmployeeListDataModel;
    final controller = Get.find<EmployeeDetailedViewController>();

    if (employeeDetails.addressId != null)
      controller.getAddressById(employeeDetails.addressId!);
    if (employeeDetails.companyId != null)
      controller.getCompanyById(employeeDetails.companyId!);
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:
                    CachedNetworkImage(imageUrl: employeeDetails.profileImage!),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                employeeDetails.name ?? "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email:- ${employeeDetails.email ?? ""}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Phone:- ${employeeDetails.phone ?? "N/A"}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (employeeDetails.addressId == null)
                Text(
                  "Address:- N/A",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (employeeDetails.addressId != null)
                Obx(() {
                  return Text(
                    "Address:- ${controller.address.value}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                }),
              SizedBox(
                height: 10,
              ),
              if (employeeDetails.companyId == null)
                Text(
                  "Company:- N/A",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (employeeDetails.companyId != null)
                Obx(() {
                  return Text(
                    "Company:- ${controller.company.value}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                }),
            ],
          ),
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
