enum ShopProductype { ticket, beans500, beans1000, beans1500, beans3000 }

class ShopProduct {
  final String itemName;
  final ShopProductype itemType;
  final int itemPrice;
  final int itemDiscountLabel;

  const ShopProduct({
    required this.itemName,
    required this.itemType,
    required this.itemPrice,
    required this.itemDiscountLabel,
  });
}

extension ShopProductypeExtension on ShopProductype {
  String get imageAssetName {
    switch (this) {
      case ShopProductype.ticket:
        return 'assets/images/mypage/logo_roulette_ticket.png';
      case ShopProductype.beans500:
        return 'assets/images/mypage/bean500.png';
      case ShopProductype.beans1000:
        return 'assets/images/mypage/bean1000.png';
      case ShopProductype.beans1500:
        return 'assets/images/mypage/bean1500.png';
      case ShopProductype.beans3000:
        return 'assets/images/mypage/bean3000.png';
    }
  }

  String get displayName {
    switch (this) {
      case ShopProductype.ticket:
        return '이용권';
      case ShopProductype.beans500:
        return '500 원두';
      case ShopProductype.beans1000:
        return '1000 원두';
      case ShopProductype.beans1500:
        return '1500 원두';
      case ShopProductype.beans3000:
        return '3000 원두';
    }
  }
}
