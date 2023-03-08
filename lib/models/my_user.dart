class MyUser {
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
static const String COLLECTION_NAME='user';
  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
  });

  MyUser.formJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          userName: json['userName'],
          email: json['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
    };
   }
}
