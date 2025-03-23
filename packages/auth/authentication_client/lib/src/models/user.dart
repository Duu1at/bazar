import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.avatarUrl,
  });

  factory UserModel.fromSupabase(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String,
      email: data['email'] as String,
      name: data['user_metadata']?['name'] as String,
      avatarUrl: data['user_metadata']?['avatar_url'] as String,
    );
  }
  final String id;
  final String? email;
  final String? name;
  final String? avatarUrl;

  UserModel copyWith({
    String? name,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  bool get isAnonymous => this == anonymous;
  static const UserModel anonymous = UserModel(id: '');

  @override
  List<Object?> get props => [id, name, email, avatarUrl];
}
