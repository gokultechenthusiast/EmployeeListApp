import 'package:employ_list/core/controllers/sql_database_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmployeeDetailedViewController extends GetxController {
  var address = "".obs; // address of employee is here
  var company = "".obs; // company of employee is here

  getAddressById(int id) async {
    debugPrint("Address Id :- $id");
    var addressData =
        await Get.find<SQLDatabaseController>().getAddressById(id);
    if (addressData != null) {
      var suite = addressData.suite != null ? "${addressData.suite}," : "";
      var street = addressData.street != null ? " ${addressData.street}," : "";
      var city = addressData.city != null ? " ${addressData.city}," : "";
      var zipcode =
          addressData.zipcode != null ? " ${addressData.zipcode}." : "";

      address.value = suite + street + city + zipcode;
    }
  }

  getCompanyById(int id) async {
    debugPrint("Company Id :- $id");
    var companyData =
        await Get.find<SQLDatabaseController>().getCompanyById(id);
    company.value = companyData!.name ?? "N/A";
  }
}
