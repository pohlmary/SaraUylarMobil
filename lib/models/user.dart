class User {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? profileImage;
  final UserRole role;
  final DateTime registeredAt;
  final DateTime lastActive;
  final List<String> savedHouses;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.profileImage,
    required this.role,
    required this.registeredAt,
    required this.lastActive,
    required this.savedHouses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'profileImage': profileImage,
      'role': role.name,
      'registeredAt': registeredAt.millisecondsSinceEpoch,
      'lastActive': lastActive.millisecondsSinceEpoch,
      'savedHouses': savedHouses,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      profileImage: map['profileImage'],
      role: UserRole.values.byName(map['role']),
      registeredAt: DateTime.fromMillisecondsSinceEpoch(map['registeredAt']),
      lastActive: DateTime.fromMillisecondsSinceEpoch(map['lastActive']),
      savedHouses: List<String>.from(map['savedHouses']),
    );
  }
}

enum UserRole { user, agent, admin }