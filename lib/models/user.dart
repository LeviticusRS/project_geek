class User {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String biography;

  User(this.firstName, this.lastName, this.phoneNumber, this.email,
      this.biography);

  User.fromJson(Map<String, dynamic> json): firstName = json['firstName'],
        lastName = json['lastName'], phoneNumber = json['phoneNumber'],
        email = json['email'], biography = json['biography'];

  static User fetchDefault() {
    return User("Joshua", "Ransom", "910-105-1039", "joshua.ransom@approachablegeek.com", "Potential Future Approachable Geek, Looking to find a new home to build and experience new things.");
  }

  Map toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'email': email,
    'biography': biography,
  };

}

