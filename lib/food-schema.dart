import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String temp_img =
    "https://realfood.tesco.com/media/images/RFO-1400x919-classic-chocolate-mousse-69ef9c9c-5bfb-4750-80e1-31aafbd80821-0-1400x919.jpg";

class Food {
  final String id;
  final String name;
  final String shop;
  final num price;
  final String image;
  Food(
      {this.id = "0",
      this.name = "0",
      this.shop = "0",
      this.price = 0,
      this.image = temp_img});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "shop": shop,
      "price": price,
      "image": image,
    };
  }

  Widget toBigWidget1(context) {
    return SizedBox(
      key: Key(id + name),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        child: Column(
          children: [
            Image(
              image: NetworkImage(image),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(shop, style: Theme.of(context).textTheme.subtitle2),
            Text(
              price.toString(),
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }

  Widget toBigWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              Image(
                image: NetworkImage(image),
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      shop,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      price.toString(),
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
