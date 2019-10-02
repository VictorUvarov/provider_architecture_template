// https://www.restapitutorial.com/httpstatuscodes.html
/// List of messages that are used when throwing and `HttpException`
class HttpExceptionMessages {
  static const code401 = '(ERROR) Unauthorized. Permission denied';
  static const code403 = '(ERROR) Forbidden. Permission denied';
  static const code404 = '(ERROR) Url not found';
  static const code500 = '(ERROR) Internal Server Error';
  static const code503 = '(ERROR) Service unavailable';
  static const general = '(ERROR) There was a problem connecting to the server';
}
