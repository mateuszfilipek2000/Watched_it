import 'package:http/http.dart' as http;

mixin TmdbBaseNetworkMixin {
  static http.Client client = http.Client();
}
