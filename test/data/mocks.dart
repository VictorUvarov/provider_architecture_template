import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/user/user.dart';

final mockPost1 = Post(
  (p) => p
    ..id = 1
    ..title = 'title'
    ..description = 'desc'
    ..userId = 1,
);
final mockPost2 = mockPost1.rebuild(
  (p) => p
    ..id = 2
    ..userId = 2,
);
final mockPosts = [mockPost1, mockPost2];

final mockPostsJson = [
  {'userId': 1, 'id': 1, 'title': 'Post 1', 'body': 'Post 1 body'},
  {'userId': 1, 'id': 2, 'title': 'Post 2', 'body': 'Post 2 body'},
];

final mockUserJson = {
  'id': 1,
  'name': 'Leanne Graham',
  'username': 'Bret',
  'email': 'Sincere@april.biz',
  'address': {
    'street': 'Kulas Light',
    'suite': 'Apt. 556',
    'city': 'Gwenborough',
    'zipcode': '92998-3874',
    'geo': {'lat': '-37.3159', 'lng': '81.1496'}
  },
  'phone': '1-770-736-8031 x56442',
  'website': 'hildegard.org',
  'company': {
    'name': 'Romaguera-Crona',
    'catchPhrase': 'Multi-layered client-server neural-net',
    'bs': 'harness real-time e-markets'
  }
};

final mockUID = 1;
final mockEmail = 'email@gmail.com';
final mockPassword = 'password';
final mockDisplayName = 'Barrack Obama';
final mockUser = User(
  (u) => u
    ..id = mockUID
    ..name = mockDisplayName
    ..username = 'Barrack'
    ..phone = '1112223333'
    ..email = mockEmail
    ..website = 'barrackobama.com',
);
