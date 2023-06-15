import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/consts.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (error) {
      VxToast.show(context, msg: error.toString());
    }
  }
}
