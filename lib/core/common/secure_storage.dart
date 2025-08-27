import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:keodam/features/auth/data/model/social_login_model.dart';

const USERID = '';
const USERNAME = '';

const userInfo = 'user_info';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());
