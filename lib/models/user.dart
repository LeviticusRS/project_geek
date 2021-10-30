class User {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String biography;

  User(this.firstName, this.lastName, this.phoneNumber, this.email,
      this.biography);

  static User fetchDefault() {
    return User("Joshua", "Ransom", "", "", "");
  }
}

