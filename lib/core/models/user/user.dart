import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:provider_start/core/models/serializers.dart';

part 'user.g.dart';

/// An example user model that should be serialized.
///   - @nullable: means that its ok if the value is null
///   - @BuiltValueField: is the key that is in the JSON you
///     receive from an API
abstract class User implements Built<User, UserBuilder> {
  int get id;

  String get username;

  String get email;

  @nullable
  String get name;

  @nullable
  String get phone;

  @nullable
  String get website;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(User.serializer, this);
  }

  factory User.fromJson(String jsonString) {
    return serializers.deserializeWith(
      User.serializer,
      json.decode(jsonString),
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return serializers.deserializeWith(
      User.serializer,
      map,
    );
  }

  User._();
  static Serializer<User> get serializer => _$userSerializer;
  factory User([void Function(UserBuilder) updates]) = _$User;
}
