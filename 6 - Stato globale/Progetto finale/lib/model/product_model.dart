class ProductModel {
  final String imageUrl;
  final String name;
  final double price;
  bool inShoppingCart;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.inShoppingCart = false,
  });
}

final products = [
  ProductModel(
    imageUrl:
        "https://blog.giallozafferano.it/francinut87/wp-content/uploads/2021/04/Pizza-margherita-fatta-in-casa-orizzontale.jpg",
    name: "Pizza margherita",
    price: 5,
  ),
  ProductModel(
    imageUrl: "https://static.cookist.it/wp-content/uploads/sites/21/2021/05/Pasta-gamberi-e-pomodorini-638x425.jpg",
    name: "Pasta ai gamberi",
    price: 8,
  ),
  ProductModel(
    imageUrl: "https://www.mammeincucina.it/wp-content/uploads/2021/02/EVIDENZA-1.jpg",
    name: "Cuori di pasta fresca",
    price: 7,
  ),
  ProductModel(
    imageUrl:
        "https://cdn.diredonna.it/app/uploads/2014/01/Ricette-dietetiche-scaloppine-al-limone-54452801_7dfe8b59aa_z-650x480.jpg",
    name: "Scaloppine al limone",
    price: 12,
  ),
  ProductModel(
    imageUrl: "https://blog.giallozafferano.it/loti64/wp-content/uploads/2019/02/IMG_9593.jpg",
    name: "Pollo alle olive",
    price: 13,
  ),
  ProductModel(
    imageUrl: "https://www.sfizioso.it/wp-content/uploads/2019/12/Arrosto-allarancia_0003.jpg",
    name: "Arrosto all'arancia",
    price: 21,
  ),
];
