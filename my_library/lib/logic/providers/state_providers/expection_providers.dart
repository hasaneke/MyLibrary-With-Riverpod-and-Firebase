import 'package:authentication/exceptions/auth_exception.dart';
import 'package:data_service/exceptions/data_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authExceptionProvider = StateProvider<AuthException?>((ref) {
  return null;
});

final dataExceptionProvider = StateProvider<DataException?>((ref) {
  return null;
});
