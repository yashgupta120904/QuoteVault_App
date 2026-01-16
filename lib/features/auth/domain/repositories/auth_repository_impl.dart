import '../../../../core/errors/error_mapper.dart';
import '../../../../core/errors/failure.dart';
import '../../data/datasources/auth_repository.dart';


// class AuthRepository {
//   final AuthRemoteDataSource remote;

//   AuthRepository(this.remote);

//   Future<Failure?> login(String email, String password) async {
//     try {
//       await remote.login(email: email, password: password);
//       return null;
//     } catch (e) {
//       return mapExceptionToFailure(e);
//     }
//   }

//   Future<Failure?> signup(String name, String email, String password) async {
//     try {
//       await remote.signup(
//         email: email,
//         password: password,
//         name: name,
//       );
//       return null;
//     } catch (e) {
//       return mapExceptionToFailure(e);
//     }
//   }

//   Future<Failure?> forgotPassword(String email) async {
//     try {
//       await remote.sendResetLink(email);
//       return null;
//     } catch (e) {
//       return mapExceptionToFailure(e);
//     }
//   }

//   Future<Failure?> resetPassword(String password) async {
//     try {
//       await remote.updatePassword(password);
//       return null;
//     } catch (e) {
//       return mapExceptionToFailure(e);
//     }
//   }
//   // Future<bool> checkEmailExists(String email) async {
//   //   try {
//   //     final response = await Supabase.instance.client.functions.invoke(
//   //       'check-email-exists',
//   //       body: {'email': email},
//   //     );

//   //     if (response.data == null) return false;

//   //     return response.data['exists'] == true;
//   //   } catch (_) {
//   //     // Fail-safe: agar function fail ho
//   //     return false;
//   //   }
//   // }
//    Future<bool> checkEmailExists(String email) async {
//     return await remote.checkEmailExists(email);
//   }

  
// }
class AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepository(this.remote);

  Future<Failure?> login(String email, String password) async {
    try {
      await remote.login(email: email, password: password);
      return null;
    } catch (e) {
      return mapExceptionToFailure(e);
    }
  }

  Future<Failure?> signup(String name, String email, String password) async {
    try {
      await remote.signup(
        email: email,
        password: password,
        name: name,
      );
      return null;
    } catch (e) {
      return mapExceptionToFailure(e);
    }
  }

  Future<Failure?> forgotPassword(String email) async {
    try {
      await remote.sendResetLink(email);
      return null;
    } catch (e) {
      return mapExceptionToFailure(e);
    }
  }

  Future<Failure?> resetPassword(String password) async {
    try {
      await remote.updatePassword(password);
      return null;
    } catch (e) {
      return mapExceptionToFailure(e);
    }
  }

  Future<bool> checkEmailExists(String email) async {
    return await remote.checkEmailExists(email);
  }
}
