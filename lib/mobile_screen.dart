import 'package:flutter/material.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 115,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 30),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'HUMMING\nBIRD.',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
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
              const SizedBox(height: 20),
              const Text(
                'In this course we will go over the basics of using Flutter Web for development. Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals, and more.',
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
                  minimumSize: const Size(double.infinity, 45),
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
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color(0xff20E492),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SKILL UP NOW',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'TAP HERE',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.local_movies_outlined),
                    title: Text(
                      'Episodes',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                    horizontalTitleGap: 50.0,
                    minVerticalPadding: 40,
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text(
                      'About',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                    horizontalTitleGap: 50.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
