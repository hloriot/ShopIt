import 'package:shop_it/domain/model/permission.dart';
import 'package:permission_handler/permission_handler.dart' as phandler;
import 'package:shop_it/domain/manager/permission_manager.dart';

class PermissionManagerImpl implements PermissionManager {
  @override
  Future<bool> isPermissionGranted(Permission permission) {
    return phandler.Permission.location.isGranted;
  }

  @override
  Future<void> requestPermission(Permission permission) {
    return phandler.Permission.location.request();
  }

}