import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// User model used by the app.
///
/// Contains the user's id, email, name, and photo.
///
/// [id] is the unique identifier of the user.
/// [email] is the user's email.
/// [name] is the user's full name.
/// [photo] is the user's profile picture.
class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The unique identifier of the user.
  final String id;

  /// The user's email.
  final String? email;

  /// The user's full name.
  final String? name;

  /// The user's profile picture.
  final String? photo;

  /// An empty user.
  static const empty = User(id: '');

  /// Creates a new [User] from a [firebase_auth.User].
  factory User.fromFirebase(firebase_auth.User user) {
    return User(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photo: user.photoURL,
    );
  }

  @override
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String?,
      name: map['name'] as String?,
      photo: map['photo'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
    };
  }

  @override
  List<Object?> get props => [email, id, name, photo];
}
