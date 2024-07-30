import 'dart:convert';

import 'package:http/http.dart' as http;

class StreamingRepository {
  Future<List<Map<String, dynamic>>> fetchYouTubeVideos(
    String apiKey,
    String query,
  ) async {
    // YouTube API endpoint
    const String apiUrl = 'https://www.googleapis.com/youtube/v3/search';

    // Parameters for the API request
    final Map<String, String> parameters = {
      'part': 'snippet',
      'maxResults': '2000', // Adjust max results as needed
      'q': query,
      'type': 'video',
      'key': apiKey,
    };

    // Send GET request to YouTube API
    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: parameters);
    final http.Response response = await http.get(uri);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse response JSON
      final Map<String, dynamic> data = json.decode(response.body);

      // Extract video information
      final List<dynamic> items = data['items'];
      List<Map<String, dynamic>> videos = [];
      for (var item in items) {
        Map<String, dynamic> video = {
          'id': item['id']['videoId'],
          'title': item['snippet']['title'],
          'description': item['snippet']['description'],
          'thumbnailUrl': item['snippet']['thumbnails']['default']['url'],
          'channelTitle': item['snippet']['channelTitle'],
        };
        videos.add(video);
      }

      return videos;
    } else {
      // If the request fails, throw an error
      throw Exception('Failed to load videos');
    }
  }
}
