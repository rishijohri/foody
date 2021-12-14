import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'food-schema.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  // ignore: non_constant_identifier_names
  String img_address = "test";
  List<Food> _foodList = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference? shops;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    shops = firestore.collection("Shops");
    img_address =
        "https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg";
    _controller = TextEditingController();
  }

  Future<void> querySearch(String query) async {
    List<Food> _queryResults = [];
    await shops!.get().then((res) async {
      for (var shop in res.docs) {
        CollectionReference menu = shop.reference.collection("Menu");
        await menu.get().then((items) {
          for (var item in items.docs) {
            if (item["name"].toLowerCase().contains(query)) {
              if (item["image"] != null &&
                  item["image"].toLowerCase() != "none") {
                _queryResults.add(Food(
                    id: item.id,
                    name: item["name"],
                    shop: shop["name"],
                    price: item["price"],
                    image: item["image"]));
              } else {
                _queryResults.add(Food(
                    id: item.id,
                    name: item["name"],
                    shop: shop["name"],
                    price: item["price"],
                    image: img_address));
              }
            }
          }
        });
      }
      setState(() {
        _foodList = _queryResults;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      labelText: "Search your Favorite Food"),
                  onChanged: querySearch,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    minHeight: MediaQuery.of(context).size.height * 0.75),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return _foodList[index].toBigWidget(context);
                  },
                  itemCount: _foodList.length,
                  shrinkWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
