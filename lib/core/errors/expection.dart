//Low-level technical errors (Supabase, network, auth)

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class AppAuthException implements Exception {
  final String message;
 AppAuthException(this.message);
}

class NetworkException implements Exception {}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}
