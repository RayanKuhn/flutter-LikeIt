import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secrets {
  static String get unsplashApiKey {
    final key = dotenv.env['UNSPLASH_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('Unsplash API key not found in .env');
    }
    return key;
  }
}
