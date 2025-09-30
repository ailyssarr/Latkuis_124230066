import 'package:flutter/material.dart';
import 'package:kuis_h/model/movie_model.dart';  // import model Movie
import 'package:url_launcher/url_launcher.dart'; // buat buka link (Wikipedia)

// Halaman detail film
class MovieDetailPage extends StatelessWidget {
  final MovieModel movie; // data film yang dikirim dari HomePage

  const MovieDetailPage({super.key, required this.movie});

  // Fungsi untuk buka URL pakai url_launcher
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak bisa buka $url"); // error kalau gagal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
        backgroundColor: Colors.brown, // warna AppBar
      ),
      body: SingleChildScrollView( // biar bisa discroll kalau konten panjang
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster film
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.imgUrl, // ambil URL gambar dari model
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Judul + tahun
            Text(
              "${movie.title} (${movie.year})",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Sutradara
            Text(
              "Directed by ${movie.director}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Sinopsis
            Text(
              movie.synopsis,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 12),

            // Genre
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Genre: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: movie.genre),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // Casts
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Casts: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: movie.casts.join(", ")), // join list jadi string
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                const SizedBox(width: 6),
                Text(
                  "Rated ${movie.rating}/10",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol untuk buka link Wikipedia
            SizedBox(
              width: double.infinity, // full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  _launchURL(movie.movieUrl); // buka link dari model
                },
                child: const Text(
                  "Go to Wikipedia",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
