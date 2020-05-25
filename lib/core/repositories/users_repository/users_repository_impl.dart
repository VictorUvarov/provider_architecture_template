import '../../../locator.dart';
import '../../data_sources/users/users_local_data_source.dart';
import '../../data_sources/users/users_remote_data_source.dart';
import '../../exceptions/cache_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/user/user.dart';
import '../../services/connectivity/connectivity_service.dart';
import '../../utils/logger.dart';
import 'users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final remoteDataSource = locator<UsersRemoteDataSource>();
  final localDataSource = locator<UsersLocalDataSource>();
  final connectivityService = locator<ConnectivityService>();

  @override
  Future<User> fetchUser(int uid) async {
    if (uid == null) {
      throw RepositoryException('uid must not be null');
    }

    try {
      if (await connectivityService.isConnected) {
        final user = await remoteDataSource.fetchUser(uid);
        await localDataSource.cacheUser(user);
        return user;
      } else {
        final user = await localDataSource.fetchUser(uid);
        return user;
      }
    } on NetworkException catch (e) {
      Logger.e('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      Logger.e('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
