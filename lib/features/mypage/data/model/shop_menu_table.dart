import 'package:keodam/features/mypage/data/model/shop_product_data.dart';

const List<ShopProduct> shopMenuTable = [
  ShopProduct(
    itemName: '500 원두',
    itemType: ShopProductype.beans500,
    itemPrice: 7000,
    itemDiscountLabel: 8000,
  ),
  ShopProduct(
    itemName: '1000 원두',
    itemType: ShopProductype.beans1000,
    itemPrice: 14000,
    itemDiscountLabel: 16000,
  ),
  ShopProduct(
    itemName: '1500 원두',
    itemType: ShopProductype.beans1500,
    itemPrice: 21000,
    itemDiscountLabel: 24000,
  ),
  ShopProduct(
    itemName: '3000 원두',
    itemType: ShopProductype.beans3000,
    itemPrice: 30000,
    itemDiscountLabel: 36000,
  ),
];
