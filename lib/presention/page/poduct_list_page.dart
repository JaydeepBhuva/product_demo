import 'package:flutter/material.dart';

import 'package:product_demo/data/model/product_model.dart';
import 'package:product_demo/domain/api_helper/product_helper.dart';
import 'package:product_demo/presention/custom_widget/common_contanier.dart';
import 'package:product_demo/presention/page/product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textSearchController = TextEditingController();
  List<ProductData> searchData = [];
  @override
  void initState() {
    // setState(() {});
    super.initState();
    getProductData();
  }

  Future<void> getProductData() async {
    await ProductHelper.getProductApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: textSearchController,
              onChanged: (value) {
                searchData.clear();
                for (var element in ProductHelper.productList) {
                  if (element.category.name.toLowerCase().contains(value)) {
                    searchData.add(element);
                  }
                }
                setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            Expanded(
              child: textSearchController.text.isEmpty || searchData.isEmpty
                  ? ListView.builder(
                      itemCount: ProductHelper.productList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetalisPage(
                                  ratingStar: ProductHelper
                                      .productList[index].rating.rate
                                      .toString(),
                                  image: ProductHelper.productList[index].image,
                                  title: ProductHelper.productList[index].title,
                                  category: ProductHelper
                                      .productList[index].category.name,
                                  description: ProductHelper
                                      .productList[index].description,
                                  price: ProductHelper.productList[index].price
                                      .toString()),
                            )),
                        child: commonContanier(
                            rating: ProductHelper.productList[index].rating.rate
                                .toString(),
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            image: ProductHelper.productList[index].image,
                            productName:
                                ProductHelper.productList[index].category.name,
                            price: ProductHelper.productList[index].price
                                .toString(),
                            details: ProductHelper.productList[index].title),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchData.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetalisPage(
                                ratingStar:
                                    searchData[index].rating.rate.toString(),
                                image: searchData[index].image,
                                title: searchData[index].title,
                                category: searchData[index].category.name,
                                description: searchData[index].description,
                                price: searchData[index].price.toString()),
                          ),
                        ),
                        child: commonContanier(
                            rating: searchData[index].rating.rate.toString(),
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            image: searchData[index].image,
                            productName: searchData[index].category.name,
                            price: searchData[index].price.toString(),
                            details: searchData[index].title),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
