
class TravelModel {
  String id;
  String idName;
  String nameTravel;
  String detail;
  String urlImage;
  String lat;
  String lng;

  TravelModel(
      {this.id,
      this.idName,
      this.nameTravel,
      this.detail,
      this.urlImage,
      this.lat,
      this.lng});

  TravelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idName = json['idName'];
    nameTravel = json['NameTravel'];
    detail = json['Detail'];
    urlImage = json['UrlImage'];
    lat = json['Lat'];
    lng = json['Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idName'] = this.idName;
    data['NameTravel'] = this.nameTravel;
    data['Detail'] = this.detail;
    data['UrlImage'] = this.urlImage;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    return data;
  }
}
