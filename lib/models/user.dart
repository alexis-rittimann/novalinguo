class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final String age;
  final String? country;
  final String? image;
  final String? description;
  final bool isConnected;

  AppUserData({
    required this.uid,
    required this.name,
    required this.age,
    required this.isConnected,
    this.image,
    this.country,
    this.description,
  });
}
