import '../models/User.dart';

final me = User(
    id: 5,
    firstName: "David",
    lastName: "Jones",
    image: "https://stumble-api.herokuapp.com/images/image5.jpeg",
    lat: 10,
    lon: 10,
    email: '');

final other = User(
    id: 6,
    firstName: "Samantha",
    lastName: "Lee",
    image: "https://stumble-api.herokuapp.com/images/image6.jpeg",
    lat: 10,
    lon: 10,
    email: '');

enum Gender {
  MALE,
  FEMALE,
  OTHER,
}
