import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/params/whatsapp_params.dart';

void openWhatsapp(WhatsappParams params) async {
  try {
    //==> init phoneNum and message
    final phoneNum = params.num;
    final text = params.text;

    //==> init url according to current platform
    final String url = defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux
        ?
        // add the [https]
        "https://wa.me/$phoneNum/?text=${Uri.parse(text)}" // new line
        :
        // add the [https]
        "https://api.whatsapp.com/send?phone=$phoneNum=${Uri.parse(text)}"; // new line

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(
          url,
        ));
      } else {
        log("Can't open whats app ios");
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        log("Can't open whats app web or android");
      }
    } else if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        log("Can't open whats app web or android");
      }
    } else {
      // Some web specific code there
      log("openWhatsapp can't get defaultTargetPlatform");
    }

    // ios platform
    // if (Platform.isIOS) {
    //   // for iOS phone only
    //   if (await canLaunchUrl(Uri.parse(url))) {
    //     await launchUrl(Uri.parse(
    //       url,
    //     ));
    //   } else {
    //     log("Can't open whats app ios");
    //   }
    // }
    //
    // // android and web
    // else {
    //   if (await canLaunchUrl(Uri.parse(url))) {
    //     await launchUrl(
    //       Uri.parse(url),
    //       mode: LaunchMode.externalNonBrowserApplication,
    //     );
    //   } else {
    //     log("Can't open whats app web or android");
    //   }
    // }
  } on Exception catch (e) {
    return log("Open whats app error : $e");
  }
}
