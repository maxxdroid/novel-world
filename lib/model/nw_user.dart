class LocalUser {
  String name;
  String? email;
  String? imageUrl;
  String? description;
  String role;
  String userID;
  bool verified;

  LocalUser(
      {required this.name,
        required this.role,
        this.description,
        this.imageUrl,
        required this.verified,
        required this.userID,
        this.email});

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
        name: json['name'],
        email: json['email'],
        verified: json['verified'],
        imageUrl: json['imageUrl'],
        description: json['description'],
        userID: json['userID'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'description': description,
      'verified' : verified,
      'imageUrl': imageUrl,
      'userID' : userID
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalUser &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.verified == verified &&
        other.role == role &&
        other.description == description &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    email.hashCode ^
    imageUrl.hashCode ^
    role.hashCode ^
    verified.hashCode ^
    description.hashCode ^
    userID.hashCode;
  }
}
