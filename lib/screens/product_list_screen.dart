

import 'dart:convert';

import 'package:assignment_of_ostad/screens/update_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../widgets/update_product_screen.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      appBar: AppBar(
        title: const Text('Product list'),
        actions: [
          IconButton(
              onPressed: () {
                getProductList();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: _inProgress
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productList[index],
                    onDelete: () {
                      setState(
                        () {
                          productList.removeAt(index);
                        },
                      );
                    },
                    onUpdate: () async {
                      bool? shouldRefresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UpdateProductScreen(
                                product: productList[index]);
                          },
                        ),
                      );

                      if (shouldRefresh == true) {
                        getProductList();
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddNewProductScreen();
              },
            ),
          );

          if (shouldRefresh == true) {
            getProductList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getProductList() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      productList.clear();
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      for (var item in jsonResponse['data']) {
        Product product = Product(
          id: item['_id'],
          productName: item['ProductName'] ?? '',
          productCode: item['ProductCode'] ?? '',
          productImage: item['Img'] ?? '',
          unitPrice: item['UnitPrice'] ?? '',
          quantity: item['Qty'] ?? '',
          totalPrice: item['TotalPrice'] ?? '',
          createdAt: item['CreatedDate'] ?? '',
        );
        productList.add(product);
      }
    }

    _inProgress = false;
    setState(() {});
  }
}
