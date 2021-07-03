import 'package:http/http.dart' show Client;
import 'package:proyecto_curso_dart/src/models/photos.dart';

class API {

  static const baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  final Client _client = Client();

  Future<List<Photos>> getPhotos() async {
    List<Photos> photosList;

    final response = await _client.get(Uri.parse(baseUrl));
    photosList = photosFromJson(response.body);

    return photosList;
  }

}