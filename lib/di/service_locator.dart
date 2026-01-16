import 'package:get_it/get_it.dart';
import '../features/auth/data/datasources/auth_repository.dart';
import '../features/auth/domain/repositories/auth_repository_impl.dart';
import '../features/auth/presentation/provider/auth_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// ===============================
  /// AUTH FEATURE
  /// ===============================

  // 🔹 Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  // 🔹 Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      sl<AuthRemoteDataSource>(),
    ),
  );

  // 🔹 Provider
  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      sl<AuthRepository>(),
    ),
  );
}
