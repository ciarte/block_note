class UserEntity {
  final String id;
  final String email;
  final String? displayName;

  UserEntity({
    required this.id,
    required this.email,
    this.displayName,
  });

  UserEntity? copyWith({required String displayName}) {
    return UserEntity(
      id: id,
      email: email,
      displayName: displayName,
    );
  }
}