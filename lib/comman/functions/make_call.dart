import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

void makeAPhoneCall(String phoneNum) async {
  try {
    //==> init phoneNum

    //==> init uri
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNum,
    );

    //==> launch
    await launchUrl(uri);
  } on Exception catch (e) {
    log("makeAPhoneCall >> Error: $e");
  }
}
