import 'dart:convert';
import 'package:http/http.dart' as http;

/// Hanya bertugas fetch & parse API TVMaze. Tidak tahu apa pun soal UI/state.
class TvMazeService {
  static const String _base = 'https://api.tvmaze.com';

  Future<List<Map<String, dynamic>>> fetchShows() async {
    final response = await http.get(Uri.parse('$_base/shows'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat daftar show (${response.statusCode})');
    }
    final list = jsonDecode(response.body) as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<Map<String, dynamic>> fetchShowDetail(int id) async {
    final response = await http.get(Uri.parse('$_base/shows/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail show (${response.statusCode})');
    }
    return Map<String, dynamic>.from(jsonDecode(response.body) as Map);
  }
}
