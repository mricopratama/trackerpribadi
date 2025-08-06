import 'package:flutter/material.dart';
import 'main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar untuk layout yang responsif
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        // Gradient untuk background yang halus
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
            center: Alignment.topCenter,
            radius: 1.2,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Bagian Atas: Gambar Ilustrasi
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  // Ganti URL ini dengan URL gambar ilustrasi 3D Anda sendiri
                  // Anda bisa mencari di situs seperti Freepik atau Iconscout
                  child: Image.network(
                    'https://ouch-cdn2.icons8.com/sI3nB0V3Iv5j4s2r_j6fT2Y2rByAbk5a2L1tT3s__jE/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMjAw/LzY2Y2VmZDE5LTg4/MmYtNDAyMy04Mzhl/LTQ3YjJjOWI5MGY4/NS5zdmc.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Bagian Bawah: Teks dan Tombol
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Judul Utama
                      const Text(
                        'Spend Smarter\nSave More',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E4B45), // Warna hijau tua
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Tombol "Get Started"
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => const MainScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4FA98E), // Warna tombol
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            shadowColor: Colors.teal.shade200,
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Teks "Log In"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have Account? ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: Color(0xFF4FA98E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}