import 'package:supabase_flutter/supabase_flutter.dart';

import 'expection.dart';
import 'failure.dart';



Failure mapExceptionToFailure(Object error) {
  if (error is AppAuthException) {
    return AuthFailure(error.message);
  }

  if (error is AuthApiException) {
    return AuthFailure(error.message);
  }

  if (error is NetworkException) {
    return const NetworkFailure();
  }

  if (error is ServerException) {
    return ServerFailure(error.message);
  }

  return const UnknownFailure();
}
