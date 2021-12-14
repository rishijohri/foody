import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _initialPage = 0;
  int _initialPage2 = 0;
  List<String> foodList = [];
  String foodTitle = "PlaceHold";
  String img_address = "https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg";
  @override
  void initState() {
    super.initState();
    foodList = ["Pizza", "Desserts", "GGG", "ssss"];
    foodTitle = foodList[0];
    _initialPage = 0;
    _initialPage2 = 0;
  }

  List<BannerModel> bannerModels = [
    BannerModel(
        imagePath:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg",
        boxFit: BoxFit.fill,
        id: "0"),
    BannerModel(
        imagePath:
            "https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg",
        id: "1"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                foodTitle,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BannerCarousel(
                height: 220,
                banners: bannerModels,
                onPageChanged: (index) {
                  setState(() {
                    // print(foodList.length);
                    foodTitle = foodList[index];
                  });
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Browse by Food Type",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HorizontalCardPager(
                initialPage: _initialPage,
                // onPageChanged: (page) => print(page),
                items: [
                  IconTitleCardItem(
                      iconData: Icons.coffee,
                      text: "Coffee",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      noSelectedIconTextColor:
                          Theme.of(context).colorScheme.onSecondary),
                  IconTitleCardItem(
                      iconData: FontAwesomeIcons.utensils,
                      text: "Main Course",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      noSelectedIconTextColor:
                      Theme.of(context).colorScheme.onSecondary),
                  IconTitleCardItem(
                      iconData: FontAwesomeIcons.cocktail,
                      text: "Beverages",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      noSelectedIconTextColor:
                          Theme.of(context).colorScheme.onSecondary),
                  IconTitleCardItem(
                      iconData: Icons.fastfood_rounded,
                      text: "Fast Food",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      noSelectedIconTextColor:
                          Theme.of(context).colorScheme.onSecondary),
                  IconTitleCardItem(
                      iconData: Icons.cake,
                      text: "Cake",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      selectedIconTextColor: Theme.of(context).colorScheme.primaryVariant,
                      noSelectedIconTextColor:
                          Theme.of(context).colorScheme.onSecondary),
                  IconTitleCardItem(
                      iconData: FontAwesomeIcons.cookieBite,
                      text: "Snacks",
                      noSelectedBgColor: Theme.of(context).colorScheme.secondary,
                      selectedBgColor: Theme.of(context).colorScheme.primary,
                      noSelectedIconTextColor:
                          Theme.of(context).colorScheme.onSecondary),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 3,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Previous Orders",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HorizontalCardPager(
                initialPage: _initialPage2,
                // onPageChanged: (page) => print(page),
                items: [
                  ImageCarditem(
                      image: Image(
                          image: NetworkImage(
                              img_address),
                          width: 100.0,
                          height: 100.0)),
                  ImageCarditem(
                      image: Image(
                          image: NetworkImage(
                              img_address),
                          width: 100.0,
                          height: 100.0))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
