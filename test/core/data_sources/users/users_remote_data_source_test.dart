import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  UsersRemoteDataSource usersRemoteDataSource;
  HttpService httpService;

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

  setUp(() async {
    await setupLocator(test: true);
    locator.allowReassignment = true;

    locator.registerSingleton<HttpService>(MockHttpService());
    httpService = locator<HttpService>();

    usersRemoteDataSource = locator<UsersRemoteDataSource>();
  });

  test('should call httpService.getHttp with correct uid when we fetch user',
      () async {
    // arrange
    final uid = 1;
    final url = '${ApiRoutes.users}/$uid';
    when(httpService.getHttp(url))
        .thenAnswer((_) => Future.value(mockUserJson));

    // act
    await usersRemoteDataSource.fetchUser(uid);

    // assert
    verify(httpService.getHttp(url));
  });

  test('should convert json data to posts when we fetch user', () async {
    // arrange
    final uid = 1;
    final url = '${ApiRoutes.users}/$uid';
    when(httpService.getHttp(url))
        .thenAnswer((_) => Future.value(mockUserJson));
    final mockUser = User.fromMap(mockUserJson);

    // act
    final user = await usersRemoteDataSource.fetchUser(uid);

    // assert
    expect(user, equals(mockUser));
  });
}
