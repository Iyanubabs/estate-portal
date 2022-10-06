class UserModel {
  String? name, ocId, uid, email;
  UserModel({this.uid, this.name, this.ocId, this.email});
  Map<String, dynamic> toJson() {
    return {'name': name, 'uid': uid, 'cId': ocId, 'email': email};
  }

  UserModel.fromFirebase(Map data)
      : name = data['name'],
        ocId = data['ocId'],
        uid = data['uid'],
        email = data['email'];
}
