import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:provider_start/core/serializers/serializers.dart';

part 'user.g.dart';

/// An example user model that should be serialized.
///   - @nullable: means that its ok if the value is null
///   - @BuiltValueField: is the key that is in the JSON you
///     recieve from an API
abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  int get id;

  String get name;

  String get username;

  String get phone;

  String get email;

  String get website;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(
      User.serializer,
      json.decode(jsonString),
    );
  }

  static User fromMap(Map<String, dynamic> map) {
    return serializers.deserializeWith(
      User.serializer,
      map,
    );
  }

  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;
}
