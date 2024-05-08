class UserModelOne {
  String uid;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? userName;
  String? profilePictureUrl;
  String? skills;
  String? bio;
  String? address;

  UserModelOne(
      {
        required this.uid,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.profilePictureUrl,
        this.userName,
        this.skills,
        this.bio,
        this.address,
      });
  // data from server
  factory UserModelOne.fromMap(map) {
    return UserModelOne(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      userName: map['userName'],
      phoneNumber: map['phoneNumber'],
      profilePictureUrl: map['profilePictureUrl'],
      skills: map['skills'],
      bio: map['bio'],
      address: map['address'],
    );
  }
// sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'profilePictureUrl': profilePictureUrl,
      'skills': skills,
      'bio': bio,
      'address': address,
    };
  }
}