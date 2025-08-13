import 'dart:io';

/// Class in charge for handling bad certificates
class HttpCertificateOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}
