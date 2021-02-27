class UserModel {
  String id;
  String name;
  String type;
  String user;
  String password;
  String urlPicture;

  UserModel(
      {this.id,
      this.name,
      this.type,
      this.user,
      this.password,
      this.urlPicture});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    type = json['Type'];
    user = json['User'];
    password = json['Password'];
    urlPicture = json['UrlPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Type'] = this.type;
    data['User'] = this.user;
    data['Password'] = this.password;
    data['UrrlPicture'] = this.urlPicture;
    return data;
  }
}
