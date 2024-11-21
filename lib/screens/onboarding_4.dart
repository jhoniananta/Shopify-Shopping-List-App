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
      home: const OnboardingScreen4(),
    );
  }
}

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/landing.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bagian Atas (Text Heading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40), // Atur padding kiri-kanan
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Text.rich(
                        TextSpan(
                          text: 'Your Smart\n', // Baris pertama
                          style: const TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 34,
                            color: Colors.white,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Shopping Assistant', // Baris kedua
                              style: TextStyle(
                                fontFamily: 'Baloo',
                                fontSize: 34,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Mulai sekarang untuk pengalaman belanja tanpa ribet!',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Bagian Bawah
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Gambar belanja
                    Image.asset(
                      'assets/belanja.png',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    // Tombol Skip, kanan.png, dan Next
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
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
                          Image.asset(
                            'assets/kanan.png',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}