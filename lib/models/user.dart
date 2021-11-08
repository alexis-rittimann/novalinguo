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
  final bool isChatting;

  AppUserData({
    required this.uid,
    required this.name,
    required this.age,
    required this.isConnected,
    required this.isChatting,
    this.image,
    this.country,
    this.description,
  });
}
