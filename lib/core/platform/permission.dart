
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionChecker{
  Future<bool> checkCamera();
  Future<bool> checkFolder();
}

class PermissionCheckerImpl implements PermissionChecker{
  @override
  Future<bool> checkCamera()async {
    bool isPermission = false;
    var status = await Permission.camera.status;
    if(status.isDenied){
      await Permission.camera.request().then((value){
        if(value.isGranted){
          isPermission = true;
        }else{
          //JALANKAN DIALOG OPEN SETTING
        }
      });
    }else{
      isPermission = true;
    }
    return isPermission;
  }

  @override
  Future<bool> checkFolder()async {
    bool isPermission = false;
    var status = await Permission.storage.status;
    if(status.isDenied){
      await Permission.storage.request().then((value){
        if(value.isGranted){
          isPermission = true;
        }else{
          //JALANKAN DIALOG OPEN SETTING
        }
      });
    }else{
      isPermission = true;
    }
    return isPermission;
  }
}