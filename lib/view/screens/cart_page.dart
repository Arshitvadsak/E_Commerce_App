import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/theme_provider.dart';

class cart_page extends StatefulWidget {
  const cart_page({Key? key}) : super(key: key);

  @override
  State<cart_page> createState() => _cart_pageState();
}

class _cart_pageState extends State<cart_page> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart page"),
        centerTitle: true,
        elevation: 20,
        actions: [
          Switch(
            value: Provider.of<ThemeProvider>(context).isdrk,
            onChanged: (val) {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 12,
              child: ListView.builder(
                  itemCount: Provider.of<CartProvider>(context).allcart.length,
                  itemBuilder: (contecxt, i) {
                    Product product =
                        Provider.of<CartProvider>(context).allcart[i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: _height * 0.15,
                          width: _width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      FullScreenWidget(
                                        child: Hero(
                                          tag: "urban",
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.asset(
                                              product.image,
                                              height: _height * 0.1,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: _height * 0.01),
                                      Text(
                                        "${product.name}".split(".")[0],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .Countpluse(
                                                        product: product);
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text(
                                                    "+",
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(width: _width * 0.03),
                                          Text(
                                            "${product.quantity}",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(width: _width * 0.03),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .CountdecrementAndRemove(
                                                      product: product);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: const Text(
                                                  "-",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .RemoveFromCart(
                                                      product: product);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Price : ${product.price}",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: _height * 0.03),
                    Text(
                      "Total Product : ${Provider.of<CartProvider>(context).allProduct}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: _height * 0.02),
                    Text(
                      "Total Price : ${Provider.of<CartProvider>(context).totalPrice}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
