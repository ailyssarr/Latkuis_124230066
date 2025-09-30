import 'package:flutter/material.dart';
import 'package:kuis_h/pages/home_page.dart';

// Halaman login menggunakan StatefulWidget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// State untuk menyimpan data & logika login
class _LoginPageState extends State<LoginPage> {
  // Controller untuk ambil input dari TextFormField (username & password)
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  // Flag untuk menandai apakah login berhasil atau gagal
  bool isLoginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // warna background
      body: Center(
        child: SingleChildScrollView( // biar bisa discroll kalo layar kecil
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card putih buat form login
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _usernameField(), // field input username
                        const SizedBox(height: 16),
                        _passwordField(), // field input password
                        const SizedBox(height: 24),
                        _loginButton(context), // tombol login
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk input username
  Widget _usernameField() {
    return TextFormField(
      controller: usernameC, // ambil teks dari inputan
      decoration: InputDecoration(
        labelText: "Username",
        prefixIcon: const Icon(Icons.person_outline), // icon user
        filled: true,
        fillColor: Colors.grey[200], // background field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // hilangin garis border
        ),
      ),
    );
  }

  // Widget untuk input password
  Widget _passwordField() {
    return TextFormField(
      controller: passwordC,
      obscureText: true, // biar password nggak keliatan
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock_outline), // icon gembok
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Widget tombol login
  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity, // tombol full width
      child: ElevatedButton(
        onPressed: () {
          _login(); // panggil fungsi login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown, // warna tombol
          foregroundColor: Colors.white, // warna teks
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          "LOGIN",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Fungsi untuk cek login
  void _login() {
    String text = "", username, password;

    // Ambil inputan dari field
    username = usernameC.text.trim();
    password = passwordC.text.trim();

    // Logika sederhana: kalau password == "066" maka login berhasil
    if (password == "066") {
      setState(() {
        text = "Login Berhasil!";
        isLoginSuccess = true;
      });

      // Pindah ke halaman HomePage sambil bawa username
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(username: username);
          },
        ),
      );
    } else {
      setState(() {
        text = "Login Gagal";
        isLoginSuccess = false;
      });
    }

    // Tampilkan notifikasi bawah (SnackBar)
    SnackBar snackBar = SnackBar(
      backgroundColor: (isLoginSuccess) ? Colors.green : Colors.red,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
