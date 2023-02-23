class User {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final double lat;
  final double lon;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.image,
      required this.lat,
      required this.lon});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        image: json['image'],
        lat: json['lat'],
        lon: json['lon']);
  }
}
