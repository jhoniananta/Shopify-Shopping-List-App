//page3
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen3(),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/landing.png', // Ganti dengan nama gambar background Anda
            fit: BoxFit.cover,
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  padding: const EdgeInsets.symmetric(vertical: 106),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center, // Agar elemen rata tengah
                    children: [
                      // Teks dengan padding kiri dan kanan
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40), // Padding kanan kiri
                        child: Text(
                          'Organize Your Shopping, Simplified',
                          style: TextStyle(
                            fontFamily: 'Baloo', // Sesuaikan dengan font Anda
                            fontSize: 34,
                            height: 1.2, // Jarak antar baris
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center, // Rata tengah
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Teks kedua dengan padding kiri dan kanan
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40), // Padding kanan kiri
                        child: Text(
                          'Buat daftar belanjaan Anda dengan mudah',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center, // Rata tengah
                        ),
                      ),
                      const SizedBox(height: 73),
                      // Gambar keranjang belanjaan
                      Image.asset(
                        'assets/keranjang.png', // Ganti dengan nama file gambar Anda
                        width: double.infinity,
                        fit: BoxFit.contain,
                        semanticLabel: 'Shopping illustration',
                      ),
                      const SizedBox(height: 46),
                      // Tombol untuk skip dan next
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Fungsi Skip
                              },
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Gambar tengah antara tombol Skip dan Next
                            Image.asset(
                              'assets/tengah.png', // Ganti dengan nama gambar Anda
                              width: 40, // Ukuran kecil gambar
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Fungsi tombol Next
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.white, // Warna tombol
                              ),
                              child: const Icon(
                                Icons.arrow_forward, // Ikon panah
                                color: Color(0xFF7F56D9), // Warna ikon
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}