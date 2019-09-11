import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:provider_start/core/serializers/serializers.dart';

part 'user.g.dart';

/// An example user model that should be serialized.
///   - @nullable: means that its ok if the value is null
///   - @BuiltValueField: is the key that is in the JSON you
///     recieve from an API
abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  @nullable
  int get id;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get phone;

  @nullable
  String get email;

  @nullable
  String get location;

  @nullable
  DateTime get created;

  @nullable
  BuiltList<int> get list;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(
      User.serializer,
      json.decode(jsonString),
    );
  }

  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;
}
