class ImageModel {
  String? url;
  bool? didExist;

  ImageModel({this.url, this.didExist});

  ImageModel.fromJson(Map<String, dynamic> json) {
    didExist = json['didExist'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['didExist'] = didExist;
    data['url'] = url;
    return data;
  }
}
