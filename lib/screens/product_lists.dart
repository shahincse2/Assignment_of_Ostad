import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductLists extends StatefulWidget {
  const ProductLists({super.key});

  @override
  State<ProductLists> createState() => _ProductListsState();
}

class _ProductListsState extends State<ProductLists> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Pullover',
      'color': 'Black',
      'size': 'L',
      'price': 51,
      'quantity': 1,
      'image': 'assets/images/pullover.png'
    },
    {
      'name': 'T-Shirt',
      'color': 'Gray',
      'size': 'L',
      'price': 30,
      'quantity': 1,
      'image': 'assets/images/newshirt.png'
    },
    {
      'name': 'Sport Dress',
      'color': 'Black',
      'size': 'M',
      'price': 43,
      'quantity': 1,
      'image': 'assets/images/sport.png'
    },
  ];


  mySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: AppBar(
          title: const Text('My Bag'),
          backgroundColor: const Color(0xffF9F9F9),
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 32),
        ),
        body: buildProductDetailsListTile(),
      ),
    );
  }

  Widget buildProductDetailsListTile() {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;

              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item['image'],
                        width: 100,
                        height: 130,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Color: ',
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${item['color']}  ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Size: ',
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${item['size']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity(index, false);
                                      },
                                      icon: const Icon(Icons.remove),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 4,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${item['quantity']}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity(index, true);
                                      },
                                      icon: const Icon(Icons.add),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 4,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${item['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total amount:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                  ),
                  Text(
                    '${totalAmount.toStringAsFixed(0)}\$',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  mySnackBar("Congratulations...", context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'CHECK OUT',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void calculateTotalAmount() {
    totalAmount = 0;
    for (var item in items) {
      totalAmount += item['price'] * item['quantity'];
    }
  }

  void updateQuantity(int index, bool isIncrement) {
    setState(
          () {
        if (isIncrement) {
          items[index]['quantity']++;
        } else {
          if (items[index]['quantity'] > 0) {
            items[index]['quantity']--;
          }
        }
        calculateTotalAmount(); // Recalculate the total amount whenever quantity changes
      },
    );
  }
}