class UserModel {
  String id;
  String name;
  String type;
  String user;
  String password;

  UserModel({this.id, this.name, this.type, this.user, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    type = json['Type'];
    user = json['User'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Type'] = this.type;
    data['User'] = this.user;
    data['Password'] = this.password;
    return data;
  }
}
