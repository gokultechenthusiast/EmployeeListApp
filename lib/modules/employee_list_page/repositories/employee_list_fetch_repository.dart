import 'dart:convert';

import 'package:employ_list/core/constants/utils/constants/constants.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetEmployeeListRepository {
  Future<List<EmployeeListDataModel>> fetchEmployeeList() async {
    var fullUrl = Uri.parse(Constants.baseUrl + Constants.locationApiPath);
    final response = await http.get(fullUrl);
    Iterable l = json.decode(response.body);
    debugPrint("locaton Array:- ${l.toString()}");
    List<EmployeeListDataModel> employeeList = List<EmployeeListDataModel>.from(
        l.map((model) => EmployeeListDataModel.fromJson(model)));

    return employeeList;
  }
}
