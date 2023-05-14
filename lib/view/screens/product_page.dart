import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../helper/db_helper.dart';
import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/theme_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

late Future<List<Product>> getAllData;
late TabController tabController2;
int initialTabIndex2 = 0;

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController2 = TabController(length: 4, vsync: this, initialIndex: 0);
    getAllData = DBHleper.dbHleper.fetchSearchedRecode(data: "Caps");
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _height * 0.05),
            Row(
              children: [
                Spacer(),
                Switch(
                    value: Provider.of<ThemeProvider>(context).isdrk,
                    onChanged: (val) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme();
                    }),
              ],
            ),
            SizedBox(height: _height * 0.02),
            const Text("Hi,Arshit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: _height * 0.016),
            Text("URBAN MONKEY®",
                style: TextStyle(
                    fontSize: _width * 0.07, fontWeight: FontWeight.bold)),
            SizedBox(height: _height * 0.02),
            TabBar(
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                controller: tabController2,
                onTap: (value) {
                  setState(() {
                    initialTabIndex2 = value;
                    if (initialTabIndex2 == 0) {
                      getAllData =
                          DBHleper.dbHleper.fetchSearchedRecode(data: "Caps");
                    }

                    if (initialTabIndex2 == 1) {
                      getAllData =
                          DBHleper.dbHleper.fetchSearchedRecode(data: "Wallet");
                    }
                    if (initialTabIndex2 == 2) {
                      getAllData =
                          DBHleper.dbHleper.fetchSearchedRecode(data: "Hoodie");
                    }
                    if (initialTabIndex2 == 3) {
                      getAllData = DBHleper.dbHleper
                          .fetchSearchedRecode(data: "Eyewear");
                    }
                  });
                },
                tabs: const [
                  Tab(
                    text: "    Caps     ",
                  ),
                  Tab(
                    text: "     Wallet      ",
                  ),
                  Tab(
                    text: "    Hoodie     ",
                  ),
                  Tab(
                    text: "    Eyewear",
                  ),
                ]),
            FutureBuilder(
              future: getAllData,
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Center(child: Text("Error : ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  List<Product>? data = snapshot.data;
                  return Container(
                    height: _height * 0.57,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5),
                      itemCount: data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 3,
                          child: Container(
                            child: Column(
                              children: [
                                FullScreenWidget(
                                  child: Hero(
                                    tag: "urban",
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        data[i].image,
                                        height: _height * 0.1,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("${data[i].name}".split(".")[0]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (data[i].like == "false") {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .addToFavourite(
                                                      product: data[i]);
                                            } else {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .RemoveFromFavourite(
                                                      product: data[i]);
                                            }
                                          });
                                        },
                                        icon: (data[i].like == "false")
                                            ? const Icon(
                                                CupertinoIcons.heart_fill,
                                              )
                                            : const Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Colors.red,
                                              )),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (data[i].quantity == 0) {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .addToCart(product: data[i]);
                                          } else {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .RemoveFromCart(
                                                    product: data[i]);
                                          }
                                        });
                                      },
                                      icon: (data[i].quantity == 0)
                                          ? const Icon(Icons.shopping_cart)
                                          : const Icon(Icons
                                              .remove_shopping_cart_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}
