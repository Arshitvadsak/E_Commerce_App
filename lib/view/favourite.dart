import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/theme_provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite page"),
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
                  itemCount:
                      Provider.of<CartProvider>(context).favourite.length,
                  itemBuilder: (contecxt, i) {
                    Product product =
                        Provider.of<CartProvider>(context).favourite[i];
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
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FullScreenWidget(
                                  child: Hero(
                                    tag: "urban",
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        product.image,
                                        height: _height * 0.1,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                      SizedBox(height: _height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${product.name}".split(".")[0],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Price : ${product.price}",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .RemoveFromFavourite(
                                                      product: product);
                                            });
                                          },
                                          child: Text("Remove")),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
