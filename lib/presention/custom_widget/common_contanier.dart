import 'package:flutter/material.dart';

Widget commonContanier(
        {required double height,
        required double width,
        required String image,
        required String productName,
        required String price,
        required String rating,
        required String details}) =>
    Card(
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.fill)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 250,
                  child: Text(details,
                      // maxLines: 2,
                      style: const TextStyle(overflow: TextOverflow.visible)),
                ),
                Text(price,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(rating)
              ],
            )
          ],
        ),
      ),
    );
