import 'package:hive/hive.dart';
import 'package:provider_start/core/models/user/user.dart';

part 'user_h.g.dart';

/// A Hive Database compatible UserH Model
///   - @HiveType(typeId: unique) is necessary for each HiveObject
///   - @HiveField(unique) is necessary if you need the object to persist
@HiveType(typeId: 0)
class UserH extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String website;

  UserH({
    this.id,
    this.name,
    this.username,
    this.phone,
    this.email,
    this.website,
  });

  factory UserH.fromUser(User user) {
    return UserH(
      id: user.id,
      name: user.name,
      username: user.username,
      phone: user.phone,
      email: user.email,
      website: user.website,
    );
  }

  factory UserH.fromMap(Map<String, dynamic> map) {
    return UserH(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      phone: map['phone'],
      email: map['email'],
      website: map['website'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['phone'] = phone;
    map['email'] = email;
    map['website'] = website;
    return map;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      website.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserH &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          phone == other.phone &&
          email == other.email &&
          website == other.website;
}
