class UserModel {
  String? uuid;
  String? firstname;
  String? middlename;
  String? lastname;
  String? sex;
  String? address;
  String? dateOfBirth;
  String? placeOfBirth;
  String? phone;
  String? email;
  String? username;
  String? userType;
  String? userImage;
  int? statusId;
  int? studentId;
  int? olsisRefSac;
  int? olsisRefTable;
  int? olsisRefId;

  UserModel(
      {this.uuid,
      this.firstname,
      this.middlename,
      this.lastname,
      this.sex,
      this.address,
      this.dateOfBirth,
      this.placeOfBirth,
      this.phone,
      this.email,
      this.username,
      this.userType,
      this.userImage,
      this.statusId,
      this.studentId,
      this.olsisRefSac,
      this.olsisRefTable,
      this.olsisRefId});
}
