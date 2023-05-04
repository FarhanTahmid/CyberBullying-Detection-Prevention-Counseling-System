import 'dart:ffi';

class User {
  //private final variables

  String _user_id;
  String _organization_name;
  String _full_name;
  String _user_picture;
  String _birth_date;
  String _contact_no;
  String _email_address;
  String _home_address;
  String _gender;
  Bool _is_proctor;

  //Constructor
  User(
      this._user_id,
      this._organization_name,
      this._full_name,
      this._user_picture,
      this._birth_date,
      this._contact_no,
      this._email_address,
      this._home_address,
      this._gender,
      this._is_proctor);

  //getter methods

  String get user_id => _user_id;
  String get organization_name => _organization_name;
  String get full_name => _full_name;
  String get user_picture => _user_picture;
  String get birth_date => _birth_date;
  String get contact_no => _contact_no;
  String get email_address => _email_address;
  String get home_address => _home_address;
  String get gender => _gender;
  Bool get is_proctor => _is_proctor;

  //Setter Methods
  set user_id(String user_id) {
    _user_id = user_id;
  }

  set organization_name(String organization_name) {
    _organization_name = organization_name;
  }

  set full_name(String full_name){
    _full_name = full_name;
  }

  set user_picture(String user_picture){
    _user_picture = user_picture;

  }
  
  set birth_date(String birt_date){
    _birth_date = birt_date;
  }

  set contact_no(String contact_no){
    _contact_no = contact_no;
  }

  set email_address(String email_address){
    _email_address = email_address;
  }

  set home_address(String home_address){
    _home_address = home_address;
  }

  set gender(String gender){
    _gender = gender;
  }

  set is_proctor(Bool proctor){
    _is_proctor = proctor;
  }

}
