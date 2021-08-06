import 'package:employ_list/core/database/constants/database_constants.dart';
import 'package:employ_list/core/database/models/employeeDBModel.dart';
import 'package:employ_list/modules/employee_list_page/models/employee_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDatabaseController extends GetxController {
  static Database? _database;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() async {
    final db = await database;
    db.close();
    super.onClose();
  }

  Future<Database> get database async {
    // if data base exist then will return it else will fetch the database
    if (_database != null) return _database!;
    _database = await _initDB(DataBaseConstants.databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    // if the tables are not created then will create athe tables
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE ${DataBaseConstants.employeeTableName} (
        ${EmployeeFields.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${EmployeeFields.employeeId} INTEGER NOT NULL,
        ${EmployeeFields.name} Text NOT NULL,
        ${EmployeeFields.addressId} INTEGER,
        ${EmployeeFields.companyId} INTEGER,
        ${EmployeeFields.email} Text,
        ${EmployeeFields.phone} Text,
        ${EmployeeFields.profileImage} TextL,
        ${EmployeeFields.username} Text,
        ${EmployeeFields.website} Text,
        ${EmployeeFields.address} Text,
        ${EmployeeFields.company} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.addressTableName} (
        ${AddressFields.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${AddressFields.city} Text,
        ${AddressFields.geoId} INTEGER,
        ${AddressFields.street} Text,
        ${AddressFields.suite} Text,
        ${AddressFields.zipcode} Text,
        ${AddressFields.geo} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.geoTableName} (
        ${GeoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${GeoFields.lat} Text,
        ${GeoFields.lng} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.companyTableName} (
        ${CompanyFields.id} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ${CompanyFields.name} Text,
        ${CompanyFields.bs} Text,
        ${CompanyFields.catchPhrase} Text
        );
        ''');
    });
  }

  Future<List<EmployeeListDataModel>> addEmployeeListToDatabase(
      List<EmployeeListDataModel> employeeList) async {
    for (EmployeeListDataModel employee in employeeList) {
      // first geo location data is added to geo table

      try {
        employee.address!.setGeoId = await addToGeoList(employee.address!.geo!);
        try {
          employee.setAddressId = await addToAddressList(employee.address!);
          try {
            employee.setCompanyId = await addToCompanyList(employee.company!);
            try {
              addToEmployeeList(employee);
            } catch (e) {
              debugPrint("Error occurred while adding to employee table $e");
            }
          } catch (e) {
            debugPrint("Error occurred while adding to company table $e");
          }
        } catch (e) {
          debugPrint("Error occurred while adding to address table $e");
        }
      } catch (e) {
        debugPrint("Error occurred while adding to geo table $e");
      }
    }

    debugPrint("Adding employee list to db complete");

    return getEmployeeListFromDB();
  }

  Future<int> addToGeoList(Geo geoData) async {
    // to add a location to list of favorite
    final db = await database;
    final geoId =
        await db.insert(DataBaseConstants.geoTableName, geoData.toJson());
    debugPrint("Id of added geo data in geo table is :- $geoId");
    return geoId;
  }

  Future<int> addToAddressList(Address addressData) async {
    // to add a location to list of favorite
    final db = await database;
    final addressId = await db.insert(
        DataBaseConstants.addressTableName, addressData.toJson());
    debugPrint("Id of added address data in address table is :- $addressId");
    return addressId;
  }

  Future<int> addToEmployeeList(EmployeeListDataModel employee) async {
    // to add a location to list of favorite
    final db = await database;
    final employeeId =
        await db.insert(DataBaseConstants.employeeTableName, employee.toJson());
    debugPrint("Id of added employee data in employee table is :-$employeeId");
    return employeeId;
  }

  Future<int> addToCompanyList(Company companyData) async {
    // to add a location to list of favorite
    final db = await database;
    final companyId = await db.insert(
        DataBaseConstants.companyTableName, companyData.toJson());
    debugPrint("Id of added company data in company table is :- $companyId");
    return companyId;
  }

  Future<List<EmployeeListDataModel>> getEmployeeListFromDB() async {
    debugPrint("Entered getEmployeeListFromDB function");
    // to fetch list of bookmarks
    List<EmployeeListDataModel> _employeeList = [];
    final db = await database;
    var result = await db.query(DataBaseConstants.employeeTableName);
    result.forEach((element) {
      var employee = EmployeeListDataModel.fromJson(element);
      _employeeList.add(employee);
    });
    return _employeeList;
  }
}
