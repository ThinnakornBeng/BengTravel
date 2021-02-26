class TravelModel {
  String id;
  String idName;
  String nameTravel;
  String detail;
  String pathImage;

  TravelModel(
      {this.id, this.idName, this.nameTravel, this.detail, this.pathImage});

  TravelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idName = json['idName'];
    nameTravel = json['NameTravel'];
    detail = json['Detail'];
    pathImage = json['PathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idName'] = this.idName;
    data['NameTravel'] = this.nameTravel;
    data['Detail'] = this.detail;
    data['PathImage'] = this.pathImage;
    return data;
  }
}
