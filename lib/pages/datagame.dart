import 'discount_product.dart';

class Product {
  int? harga, diskon, hasil;

  String? picture,
      name,
      os,
      genre,
      genre2,
      genre3,
      developer,
      publisher,
      released,
      description;

  Product({
    required this.picture,
    required this.name,
    required this.os,
    required this.genre,
    required this.genre2,
    this.genre3,
    required this.harga,
    this.developer,
    this.publisher,
    this.released,
    this.diskon,
    this.hasil,
    this.description,
  });

  void calculateDiscount() {
    if (diskon != null) {
      hasil = DiscountCount.mathDiscount(
          harga ?? 0, diskon ?? 0); // Memanggil metode dari DiscountCount
    }
  }
}

List<Product> listProduct = <Product>[
  Product(
    picture: "lib/icons/header1_2.jpg",
    name: "Escape Dungeon 2",
    os: "lib/icons/windows.png",
    genre: "Mature",
    genre2: "RPG",
    developer: "Hilde Games",
    publisher: "Hilde Games, PlayMeow",
    released: "14 Jan, 2022",
    description:
        "Help Shunral infiltrate the Demon Lord's castle in this turn-based, rogue-lite adventure. Remember to keep a safe distance while eliminating his cronies with your bow and arrow. Failure to do so may result in an animated interactive experience with the local monsters.",
    harga: 152999,
    diskon: 10,
  ),
  Product(
    picture: "lib/icons/header2.jpg",
    name: "The Elder Scrolls V: Skyrim",
    os: "lib/icons/windows.png",
    genre: "Open World",
    genre2: "RPG",
    developer: "Bethesda Game Studios",
    publisher: "Bethesda Softworks",
    released: "28 Oct, 2016",
    description:
        "Winner of more than 200 Game of the Year Awards, Skyrim Special Edition brings the epic fantasy to life in stunning detail. The Special Edition includes the critically acclaimed game and add-ons with all-new features like remastered art and effects, volumetric god rays, dynamic depth of field, screen-space",
    harga: 409999,
    diskon: 45,
  ),
  Product(
    picture: "lib/icons/header3.jpg",
    name: "Watch Dogs®: Legion",
    os: "lib/icons/windows.png",
    genre: "Action",
    genre2: "Open World",
    genre3: "RPG",
    developer: "Hilde Games",
    publisher: "Hilde Games, PlayMeow",
    released: "14 Jan, 2022",
    description:
        "Help Shunral infiltrate the Demon Lord's castle in this turn-based, rogue-lite adventure. Remember to keep a safe distance while eliminating his cronies with your bow and arrow. Failure to do so may result in an animated interactive experience with the local monsters.",
    harga: 312314,
    diskon: 45,
  ),
  Product(
      picture: "lib/icons/header4.jpg",
      name: "Phasmophobia",
      os: "lib/icons/windows.png",
      genre: "Horror",
      genre2: "Online Co-op",
      developer: "Hilde Games",
      publisher: "Hilde Games, PlayMeow",
      released: "14 Jan, 2022",
      description:
          "Help Shunral infiltrate the Demon Lord's castle in this turn-based, rogue-lite adventure. Remember to keep a safe distance while eliminating his cronies with your bow and arrow. Failure to do so may result in an animated interactive experience with the local monsters.",
      harga: 89999,
      diskon: 0),
  Product(
      picture: "lib/icons/header5.jpg",
      name: "Monster Hunter: World",
      os: "lib/icons/windows.png",
      genre: "Co-op",
      genre2: "Multiplayer",
      genre3: "Action",
      developer: "Hilde Games",
      publisher: "Hilde Games, PlayMeow",
      released: "14 Jan, 2022",
      description:
          "Help Shunral infiltrate the Demon Lord's castle in this turn-based, rogue-lite adventure. Remember to keep a safe distance while eliminating his cronies with your bow and arrow. Failure to do so may result in an animated interactive experience with the local monsters.",
      harga: 334999,
      diskon: 50),
  Product(
      picture: "lib/icons/header6.jpg",
      name: "Forza Horizon 5",
      os: "lib/icons/windows.png",
      genre: "Racing",
      genre2: "Racing",
      genre3: "Driving",
      developer: "Hilde Games",
      publisher: "Hilde Games, PlayMeow",
      released: "14 Jan, 2022",
      description:
          "Help Shunral infiltrate the Demon Lord's castle in this turn-based, rogue-lite adventure. Remember to keep a safe distance while eliminating his cronies with your bow and arrow. Failure to do so may result in an animated interactive experience with the local monsters.",
      harga: 699000,
      diskon: 50),
];
