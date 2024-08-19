import 'dart:convert';

import 'package:http/http.dart' as http;

class CVGenerator {
  Future<String> generateCV(String name, String email, String phone,
      String objective, String education, String experience) async {
    final apiUrl = 'https://api.gemini.ai/v1/text/generate';
    final apiKey = 'AIzaSyDn8jLnaUDtzpOm2FOHWr2YcB8pd4ssWZ0';

    final requestBody = {
      'prompt':
          'Generate a CV for $name with email $email and phone number $phone. The objective is $objective. The education is $education. The experience is $experience.',
      'temperature': 0.5,
      'max_tokens': 1024,
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['text'];
    } else {
      throw Exception('Failed to generate CV');
    }
  }
}
