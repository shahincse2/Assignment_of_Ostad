import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late TextEditingController _productNameTEController;
  late TextEditingController _unitPriceTEController;
  late TextEditingController _totalPriceTEController;
  late TextEditingController _imageTEController;
  late TextEditingController _codeTEController;
  late TextEditingController _quantityTEController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    _productNameTEController =
        TextEditingController(text: widget.product.productName);
    _unitPriceTEController =
        TextEditingController(text: widget.product.unitPrice.toString());
    _totalPriceTEController =
        TextEditingController(text: widget.product.totalPrice.toString());
    _imageTEController =
        TextEditingController(text: widget.product.productImage);
    _codeTEController = TextEditingController(text: widget.product.productCode);
    _quantityTEController =
        TextEditingController(text: widget.product.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildNewProductForm(),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _productNameTEController,
            decoration: const InputDecoration(
                hintText: 'Name', labelText: 'Product Name'),
          ),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: const InputDecoration(
                hintText: 'Unit Price', labelText: 'Unit Price'),
          ),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: const InputDecoration(
                hintText: 'Total Price', labelText: 'Total Price'),
          ),
          TextFormField(
            controller: _imageTEController,
            decoration: const InputDecoration(
                hintText: 'Image', labelText: 'Product Image'),
          ),
          TextFormField(
            controller: _codeTEController,
            decoration: const InputDecoration(
                hintText: 'Product code', labelText: 'Product Code'),
          ),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(
                hintText: 'Quantity', labelText: 'Quantity'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
            onPressed: _onTapUpdateProductButton, // Call update function
            child: const Text('UPDATE'),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapUpdateProductButton() async {
    _inProgress = true;
    setState(() {});
    if (!_formKey.currentState!.validate()) return;
    Uri uri = Uri.parse(
        'http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> updatedProduct = {
      'ProductName': _productNameTEController.text,
      'UnitPrice': _unitPriceTEController.text,
      'TotalPrice': _totalPriceTEController.text,
      'Img': _imageTEController.text,
      'ProductCode': _codeTEController.text,
      'Qty': _quantityTEController.text,
    };

    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedProduct),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update product...!!')));
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _unitPriceTEController.dispose();
    _imageTEController.dispose();
    _codeTEController.dispose();
    super.dispose();
  }
}
