// https://www.restapitutorial.com/httpstatuscodes.html
/// List of messages that are used when throwing and `NetworkException`
class NetworkExceptionMessages {
  static const code401 = '(ERROR) Unauthorized. Permission denied';
  static const code403 = '(ERROR) Forbidden. Permission denied';
  static const code404 = '(ERROR) Url not found';
  static const code500 = '(ERROR) Internal Server Error';
  static const code503 = '(ERROR) Service unavailable';
  static const jsonFormat =
      '(ERROR) There was a problem decoding json from response body';
  static const general = '(ERROR) There was a problem connecting to the server';
}
