class TournametsModel {
  String? name, imageSearch;
  bool? isSelected;

  TournametsModel(this.name, this.imageSearch, this.isSelected);

  TournametsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageSearch = json['imageSearch'];
    isSelected = json['selected'];
  }

  // get selected => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageSearch'] = this.imageSearch;
    data['selected'] = this.isSelected;

    return data;
  }
}
