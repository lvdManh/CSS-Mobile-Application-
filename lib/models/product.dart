class ProductModel{
  static final products = [
    Product(
      id: "1",
      name: "RAM Kingston KVR32S",
      description: "DDR4-3200MHz",
      price: 8900000,
      quantity: 19,
      branch: "All",
      imgUrl: "https://images.fpt.shop/unsafe/fit-in/214x214/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/27/637736097183292342_ram-kingston-kvr32s22s8-8-8-gb-ddr4-3200-mhz-xanh-dd.jpg",
    ),
  ];
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String branch;
  final String imgUrl;
  Product({required this.id, required this.name, required this.description, required this.price, required this.quantity, required this.branch, required this.imgUrl});
}
