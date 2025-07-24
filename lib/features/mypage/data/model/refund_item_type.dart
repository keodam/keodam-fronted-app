enum RefundItemType { ticket, beans500, beans1000, beans1500, beans3000 }

extension RefundItemTypeExtension on RefundItemType {
  String get imageAssetName {
    switch (this) {
      case RefundItemType.ticket:
        return 'assets/images/mypage/logo_rulet_ticket.png';
      case RefundItemType.beans500:
        return 'assets/images/mypage/bean500.png';
      case RefundItemType.beans1000:
        return 'assets/images/mypage/bean1000.png';
      case RefundItemType.beans1500:
        return 'assets/images/mypage/bean1500.png';
      case RefundItemType.beans3000:
        return 'assets/images/mypage/bean3000.png';
    }
  }

  String get displayName {
    switch (this) {
      case RefundItemType.ticket:
        return '이용권';
      case RefundItemType.beans500:
        return '500 원두';
      case RefundItemType.beans1000:
        return '1000 원두';
      case RefundItemType.beans1500:
        return '1500 원두';
      case RefundItemType.beans3000:
        return '3000 원두';
    }
  }
}
