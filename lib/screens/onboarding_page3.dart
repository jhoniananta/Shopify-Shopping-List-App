//page3
// ignore_for_file: prefer_const_constructors

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
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center, // Agar elemen rata tengah
                  children: [
                    // Teks dengan padding kiri dan kanan
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 55, 12, 0), // Padding kanan kiri
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
                    const SizedBox(height: 50),
                    // Gambar keranjang belanjaan
                    Image.asset(
                      'assets/keranjang.png', // Ganti dengan nama file gambar Anda
                      width: double.infinity,
                      fit: BoxFit.contain,
                      semanticLabel: 'Shopping illustration',
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 12,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/onBoardingPage4');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/onboarding/arrow.png',
                              width: 48,
                              height: 48,
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
        ],
      ),
    );
  }
}