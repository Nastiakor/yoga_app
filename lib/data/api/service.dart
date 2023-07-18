import 'package:dio/dio.dart';
import 'package:yoga_app/domain/entities/yoga_videos.dart';

class YogaService {
  Future<List<YogaVideo>> fetchYogaVideos() async {
    final dio = Dio();
    final response = await dio.get(
      'https://api.vimeo.com/me/projects/17013828/videos',
      options: Options(
        headers: {
          "authorization": "Bearer cae6cf867c64d1f50369a0d108e8d570",
        },
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> list = response.data['data'];
      return list.map((video) => YogaVideo.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}
