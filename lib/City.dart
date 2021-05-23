class City {
  int id;
  String name;
  String countryCode;

  City(this.id, this.name, this.countryCode);

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        countryCode = json['country'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': countryCode,
      };
}
