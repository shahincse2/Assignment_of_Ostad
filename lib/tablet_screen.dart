import 'package:flutter/material.dart';

class TabletScreen extends StatelessWidget {
  const TabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 30),
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'HUMMING\nBIRD.',
                style: TextStyle(fontSize: 18),
              )),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Episode',
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'About',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 80.0, bottom: 80.0, left: 80.0, right: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'FLUTTER WEB.\nTHE BASICS',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Add space between the texts
              const Text(
                'In this course we will go over the basics of using Flutter Web for development. Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals, and more.',
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff20E492),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text('Join Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
