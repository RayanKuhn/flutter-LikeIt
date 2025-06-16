import 'package:dio/dio.dart';
import '../models/image_model.dart';
import '../secrets.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<ImageModel>> fetchImages({int page = 1}) async {
    try {
      final response = await _dio.get(
        'https://api.unsplash.com/photos',
        queryParameters: {
          'page': page,
          'per_page': 12, // nombre d’images par page
          'client_id': unsplashAccessKey,
        },
      );

      final List data = response.data;
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des images : $e');
    }
  }
}
