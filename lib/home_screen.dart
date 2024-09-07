import 'package:assignment_of_ostad/screens/product_lists.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductLists(),
    );
  }
}
