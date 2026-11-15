/// Helper untuk membaca data show (Map dari JSON TVMaze) dengan aman.

String? showImage(Map show, {bool original = false}) {
  final img = show['image'];
  if (img is Map) {
    final url = original
        ? (img['original'] ?? img['medium'])
        : (img['medium'] ?? img['original']);
    // TVMaze mengembalikan http://, Android memblokir cleartext -> paksa https.
    return url?.toString().replaceFirst('http://', 'https://');
  }
  return null;
}

String showRating(Map show) {
  final r = show['rating'];
  final v = r is Map ? r['average'] : null;
  return v == null ? '-' : v.toString();
}

String showGenres(Map show) {
  final g = show['genres'];
  if (g is List && g.isNotEmpty) return g.join(', ');
  return '-';
}

String stripHtml(String? html) {
  if (html == null || html.isEmpty) return 'Tidak ada ringkasan.';
  return html
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&nbsp;', ' ')
      .trim();
}

/// Versi ringkas show yang disimpan ke Hive (favorit).
Map<String, dynamic> slimShow(Map show) => {
      'id': show['id'],
      'name': show['name'] ?? '',
      'image': showImage(show),
      'rating': showRating(show),
    };
