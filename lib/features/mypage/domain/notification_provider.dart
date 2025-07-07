import 'package:flutter_riverpod/flutter_riverpod.dart';

final chattingNotificationProvider = StateProvider<bool>((ref) => true);
final eventNotificationProvider = StateProvider<bool>((ref) => false);
