import 'package:flutter/material.dart';
import 'package:kuis_h/data/movie_data.dart';   // data list film
import 'package:kuis_h/model/movie_model.dart'; // model data Movie
import 'package:kuis_h/pages/movie_detail_page.dart'; // halaman detail film

// Halaman Home, StatefulWidget karena ada data yang bisa berubah (savedMovies)
class HomePage extends StatefulWidget {
  final String username; // dapet username dari LoginPage

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Set untuk menyimpan index film yang sudah disimpan (bookmark)
  final Set<int> savedMovies = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Store"),
        backgroundColor: Colors.brown, // warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan username dari LoginPage
            Text(
              "Welcome, ${widget.username}!",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Expanded agar ListView memenuhi sisa layar
            Expanded(
              child: ListView.builder(
                itemCount: movieList.length, // jumlah film dari movie_data
                itemBuilder: (context, index) {
                  return _movieCard(context, movieList[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan Card setiap film
  Widget _movieCard(BuildContext context, MovieModel movie, int index) {
    // cek apakah film ini sudah disimpan/bookmark
    final bool isSaved = savedMovies.contains(index);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        // Gambar poster film
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            movie.imgUrl, // url gambar film
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        // Judul film + tahun
        title: Text(
          "${movie.title} (${movie.year})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Genre dan rating
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.genre),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text("${movie.rating}/10"),
              ],
            ),
          ],
        ),
        // Tombol simpan (bookmark)
        trailing: IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border, // ganti icon
            color: isSaved ? Colors.brown : Colors.black,     // ganti warna
          ),
          onPressed: () {
            setState(() {
              // kalau sudah disimpan → hapus
              // kalau belum → tambahkan
              if (isSaved) {
                savedMovies.remove(index);
              } else {
                savedMovies.add(index);
              }
            });
          },
        ),
        // Klik list item → pindah ke halaman detail film
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(movie: movie),
            ),
          );
        },
      ),
    );
  }
}
