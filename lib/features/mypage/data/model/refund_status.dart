import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';

enum RefundStatus { refundable, pending, completed, notRefundable }

extension RefundStatusExtension on RefundStatus {
  String get displayName {
    switch (this) {
      case RefundStatus.refundable:
        return '환불';
      case RefundStatus.pending:
        return '환불대기';
      case RefundStatus.completed:
        return '환불완료';
      case RefundStatus.notRefundable:
        return '환불불가';
    }
  }

  Color get tagColor {
    switch (this) {
      case RefundStatus.refundable:
        return redColor;
      case RefundStatus.pending:
        return Colors.green;
      case RefundStatus.completed:
        return pointColor529DFF;
      case RefundStatus.notRefundable:
        return textBlack;
    }
  }
}
