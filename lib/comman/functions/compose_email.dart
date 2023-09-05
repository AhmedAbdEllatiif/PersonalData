import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

void composeEmail({required String email}) async {
  try {


    try {
      final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=Contact with Ahmed  & body=Hey Ahmed, \nI reached you through the personal QR code, I would like to inform you that ...', //add subject and body here
      );

      // var url = params.toString();
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
      //
      // Uri fbBundleUri = Uri.parse(fallbackUrl);
      var canLaunchNatively = await canLaunchUrl(params);

      if (canLaunchNatively) {
        launchUrl(params);
      } else {
        await launchUrl(
          Uri.parse("mailto:$email"),
        );
      }
    } catch (e) {
      log("openUrl >> onTap >> error: $e");
    }
  } on Exception catch (e) {
    log("openUrl >> onTap >> Exception >> error: $e");
  }
}
