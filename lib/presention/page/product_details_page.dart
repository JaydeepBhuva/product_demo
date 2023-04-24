import 'package:flutter/material.dart';

class ProductDetalisPage extends StatefulWidget {
  String image, title, category, description, price, ratingStar;
  ProductDetalisPage(
      {super.key,
      required this.image,
      required this.ratingStar,
      required this.title,
      required this.category,
      required this.description,
      required this.price});

  @override
  State<ProductDetalisPage> createState() => _ProductDetalisPageState();
}

class _ProductDetalisPageState extends State<ProductDetalisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.title),
            Container(
              margin: const EdgeInsets.only(left: 80),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.fill)),
            ),
            Text('Price :${widget.price}'),
            SizedBox(
                height: 180,
                child: Text(
                  'Description :${widget.description}',
                  style: const TextStyle(overflow: TextOverflow.visible),
                )),
            Text('Rating :${widget.ratingStar}')
          ],
        ),
      ),
    );
  }
}
