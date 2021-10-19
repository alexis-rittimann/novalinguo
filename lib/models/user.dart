class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final DateTime age;
  final String? country;
  final String? image;
  final String? description;

  AppUserData({
    required this.uid,
    required this.name,
    required this.age,
    this.image,
    this.country,
    this.description,
  });
}
