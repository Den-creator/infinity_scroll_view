import 'package:http/http.dart' as http;

import '../../constants.dart';

class GoRestAPI {
  Future<String> getUsersJsonString(int page) async {
    try {
      final url = Uri.parse(
          'https://gorest.co.in/${k.error ? 'error' : ''}public-api/users?page=$page');

      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Status code - ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
