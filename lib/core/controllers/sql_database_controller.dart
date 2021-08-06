import 'package:employ_list/core/database/constants/database_constants.dart';
import 'package:employ_list/core/database/models/employeeDBModel.dart';
import 'package:employ_list/core/utils/enums/api_call_status_enum.dart';
import 'package:employ_list/modules/employee_list_page/controller/employee_list_page_controller.dart';
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
        ${EmployeeFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${EmployeeFields.name} Text,
        ${EmployeeFields.addressId} INTEGER,
        ${EmployeeFields.companyId} INTEGER,
        ${EmployeeFields.email} Text,
        ${EmployeeFields.phone} Text,
        ${EmployeeFields.profileImage} TextL,
        ${EmployeeFields.username} Text,
        ${EmployeeFields.website} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.addressTableName} (
        ${AddressFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AddressFields.city} Text,
        ${AddressFields.geoId} INTEGER,
        ${AddressFields.street} Text,
        ${AddressFields.suite} Text,
        ${AddressFields.zipcode} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.geoTableName} (
        ${GeoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${GeoFields.lat} Text,
        ${GeoFields.lng} Text
        )
        ''');
      db.execute('''
        CREATE TABLE ${DataBaseConstants.companyTableName} (
        ${CompanyFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
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
      if (employee.address!.geo != null) {
        // first geo location data is added to geo table
        addToGeoList(employee.address!.geo!, employee);
      } else {
        // if empty the address is added
        addToAddressList(employee.address!, employee);
      }
    }

    return getEmployeeListFromDB();
  }

  addToGeoList(Geo geoData, EmployeeListDataModel employee) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        final geoId = await txn.rawInsert(
            'INSERT INTO ${DataBaseConstants.geoTableName}(${GeoFields.lat}, ${GeoFields.lng}) VALUES'
            '(?, ?)',
            [geoData.lat, geoData.lng]);
        debugPrint("Id of added geo data in geo table is :- $geoId");
        employee.address!.geoId = geoId; //db stored geo id added employee
        // details
        if (employee.address != null) {
          // to add a address data to address table
          addToAddressList(employee.address!, employee);
        } else {
          // if empty then company added
          addToCompanyList(employee.company!, employee);
        }
      });
    } catch (e) {
      debugPrint("Error occurred while inserting $e");
    }
  }

  addToAddressList(Address addressData, EmployeeListDataModel employee) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        final addressId = await txn.rawInsert(
            'INSERT INTO ${DataBaseConstants.addressTableName}'
            '(${AddressFields.city}, ${AddressFields.geoId}, '
            '${AddressFields.zipcode}, ${AddressFields.suite}, '
            '${AddressFields.street}) VALUES'
            '(?, ?, ?, ?, ?)',
            [
              addressData.city,
              addressData.geoId,
              addressData.zipcode,
              addressData.suite,
              addressData.street
            ]);
        debugPrint(
            "Id of added address data in address table is :- $addressId");
        employee.addressId = addressId; //db stored address id added employee
        // details
        if (employee.company != null) {
          // to add a company data to company table
          addToCompanyList(employee.company!, employee);
        } else {
          // if empty employee is added
          addToEmployeeList(employee);
        }
      });
    } catch (e) {
      debugPrint("Error occurred while inserting $e");
    }
  }

  addToCompanyList(Company companyData, EmployeeListDataModel employee) async {
    // to add a location to list of favorite
    final db = await database;
    try {
      await db.transaction((txn) async {
        final companyId = await txn.rawInsert(
            'INSERT INTO ${DataBaseConstants.companyTableName}'
            '(${CompanyFields.catchPhrase}, ${CompanyFields.bs},'
            '${CompanyFields.name}) VALUES'
            '(?, ?, ?)',
            [companyData.catchPhrase, companyData.bs, companyData.name]);
        debugPrint(
            "Id of added company data in company table is :- $companyId");
        employee.companyId = companyId; //db stored company id added employee
        // details
        // to add a employee data to employee table
        addToEmployeeList(employee);
      });
    } catch (e) {
      debugPrint("Error occurred while inserting $e");
    }
  }

  addToEmployeeList(EmployeeListDataModel employee) async {
    // to add a location to list of favorite
    final db = await database;
    try {
      await db.transaction((txn) async {
        final employeeId = await txn.rawInsert(
            'INSERT INTO ${DataBaseConstants.employeeTableName}'
            '(${EmployeeFields.id}, ${EmployeeFields.name},'
            '${EmployeeFields.companyId}, ${EmployeeFields.addressId},'
            '${EmployeeFields.email}, ${EmployeeFields.website},'
            '${EmployeeFields.username}, ${EmployeeFields.profileImage}, '
            '${EmployeeFields.phone}) VALUES'
            '(?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
              employee.id,
              employee.name,
              employee.companyId,
              employee.addressId,
              employee.email,
              employee.website,
              employee.username,
              employee.profileImage,
              employee.phone
            ]);
        debugPrint(
            "Id of added employee data in employee table is :-$employeeId");
      });
    } catch (e) {
      debugPrint("Error occurred while inserting $e");
    }
  }

  Future<List<EmployeeListDataModel>> getEmployeeListFromDB() async {
    debugPrint("Entered getEmployeeListFromDB function");
    // to fetch list of bookmarks
    List<EmployeeListDataModel> _employeeList = [];
    final db = await database;
    var result = await db.query(DataBaseConstants.employeeTableName);
    result.forEach((element) {
      debugPrint("employ Data :- $element");
      var employee = EmployeeListDataModel.fromJson(element);
      _employeeList.add(employee);
    });
    // after fetching list ui is changed and employee ist is saved in 2
    // arrays for business logic
    Get.find<EmployeeListController>().employeeList.addAll(_employeeList);
    Get.find<EmployeeListController>().totalList.clear();
    Get.find<EmployeeListController>().totalList.addAll(_employeeList);
    Get.find<EmployeeListController>().apiCallStatus.value =
        ApiCallStatus.success;
    return _employeeList;
  }

  Future<Address?> getAddressById(int id) async {
    final db = await database;

    try {
      var result = await db.query(DataBaseConstants.addressTableName,
          where: "id = ?", whereArgs: [id]);
      return Address.fromJson(result.first);
    } catch (e) {
      debugPrint("Error occurred while fetching address $e");
    }
  }

  Future<Company?> getCompanyById(int id) async {
    final db = await database;
    try {
      var result = await db.query(DataBaseConstants.companyTableName,
          where: "id = ?", whereArgs: [id]);
      return Company.fromJson(result.first);
    } catch (e) {
      debugPrint("Error occurred while fetching company $e");
    }
  }

  Future<Geo?> getGeoById(int id) async {
    final db = await database;
    try {
      var result = await db.query(DataBaseConstants.geoTableName,
          where: "id = ?", whereArgs: [id]);
      return Geo.fromJson(result.first);
    } catch (e) {
      debugPrint("Error occurred while fetching address $e");
    }
  }
}
