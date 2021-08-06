/// id : 1
/// name : "Leanne Graham"
/// username : "Bret"
/// email : "Sincere@april.biz"
/// profile_image : "https://randomuser.me/api/portraits/men/1.jpg"
/// address : {"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}}
/// phone : null
/// website : "hildegard.org"
/// company : {"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}

class EmployeeListDataModel {
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  String? _profileImage;
  Address? _address;
  int? _addressId;
  dynamic _phone;
  String? _website;
  int? _companyId;
  Company? _company;

  int? get id => _id;
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get profileImage => _profileImage;
  int? get addressId => _addressId;
  Address? get address => _address;
  dynamic get phone => _phone;
  String? get website => _website;
  int? get companyId => _companyId;
  Company? get company => _company;

  set setAddressId(int val) => _addressId = val;
  set setCompanyId(int val) => _companyId = val;

  EmployeeListDataModel(
      {int? id,
      String? name,
      String? username,
      String? email,
      String? profileImage,
      Address? address,
      dynamic? phone,
      String? website,
      Company? company}) {
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _profileImage = profileImage;
    _address = address;
    _phone = phone;
    _website = website;
    _company = company;
  }

  EmployeeListDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _phone = json['phone'];
    _website = json['website'];
    _company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['profile_image'] = _profileImage;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['phone'] = _phone;
    map['website'] = _website;
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    return map;
  }
}

/// name : "Romaguera-Crona"
/// catchPhrase : "Multi-layered client-server neural-net"
/// bs : "harness real-time e-markets"

class Company {
  String? _name;
  String? _catchPhrase;
  String? _bs;

  String? get name => _name;
  String? get catchPhrase => _catchPhrase;
  String? get bs => _bs;

  Company({String? name, String? catchPhrase, String? bs}) {
    _name = name;
    _catchPhrase = catchPhrase;
    _bs = bs;
  }

  Company.fromJson(dynamic json) {
    _name = json['name'];
    _catchPhrase = json['catchPhrase'];
    _bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['catchPhrase'] = _catchPhrase;
    map['bs'] = _bs;
    return map;
  }
}

/// street : "Kulas Light"
/// suite : "Apt. 556"
/// city : "Gwenborough"
/// zipcode : "92998-3874"
/// geo : {"lat":"-37.3159","lng":"81.1496"}

class Address {
  dynamic _street;
  String? _suite;
  String? _city;
  String? _zipcode;
  int? _geoId;
  Geo? _geo;

  dynamic get street => _street;
  String? get suite => _suite;
  String? get city => _city;
  String? get zipcode => _zipcode;
  int? get geoId => _geoId;
  Geo? get geo => _geo;

  set setGeoId(int val) => _geoId = val;

  Address(
      {dynamic street,
      String? suite,
      String? city,
      String? zipcode,
      Geo? geo}) {
    _street = street;
    _suite = suite;
    _city = city;
    _zipcode = zipcode;
    _geo = geo;
  }

  Address.fromJson(dynamic json) {
    _street = json['street'];
    _suite = json['suite'];
    _city = json['city'];
    _zipcode = json['zipcode'];
    _geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['street'] = _street;
    map['suite'] = _suite;
    map['city'] = _city;
    map['zipcode'] = _zipcode;
    if (_geo != null) {
      map['geo'] = _geo?.toJson();
    }
    return map;
  }
}

/// lat : "-37.3159"
/// lng : "81.1496"

class Geo {
  String? _lat;
  String? _lng;

  String? get lat => _lat;
  String? get lng => _lng;

  Geo({String? lat, String? lng}) {
    _lat = lat;
    _lng = lng;
  }

  Geo.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}
