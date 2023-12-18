import 'package:shop_it/domain/model/permission.dart';

abstract class PermissionManager {
  Future<bool> isPermissionGranted(Permission permission);
  Future<void> requestPermission(Permission permission);
}