class UserDetails {
  final String firstName;
  final String lastName;
  final String email;
  final String description;
  final String gender;
  final String instagramAccount;
  final String facebookAccount;
  final String linkedinAccount;
  final String image;

  UserDetails(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.description,
      required this.gender,
      required this.instagramAccount,
      required this.facebookAccount,
      required this.linkedinAccount,
      required this.image});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        description: json['description'],
        gender: json['gender'],
        instagramAccount: json['instagramAccount'] ?? '',
        facebookAccount: json['facebookAccount'] ?? '',
        linkedinAccount: json['linkedinAccount'] ?? '',
        image: json['imagePath']);
  }
}
