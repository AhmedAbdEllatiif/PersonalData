import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:personal_data/comman/functions/open_url.dart';
import 'package:personal_data/comman/functions/open_whats_app.dart';
import 'package:personal_data/data/params/whatsapp_params.dart';
import 'package:personal_data/widgets/social_media_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'comman/functions/compose_email.dart';
import 'comman/functions/make_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Abd Elltif',
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        //maxWidth: 1200,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(220, name: "S"),
          const ResponsiveBreakpoint.resize(350, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(600, name: TABLET),
          const ResponsiveBreakpoint.resize(800, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.transparent,
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// personal image
              CircleAvatar(
                backgroundImage: const AssetImage('assets/images/ahmed.jpeg'),
                backgroundColor: Colors.transparent,
                radius: MediaQuery.of(context).size.width * 0.4 / 2,
              ),

              // Container(
              //   color: Colors.white,
              //   child: Container(
              //     margin: EdgeInsets.all(30),
              //     child: Column(
              //       children: [
              //         QrImage(
              //           data: "https://contact-with-ahmed.web.app/#/",
              //           version: QrVersions.auto,
              //           backgroundColor: Colors.white,
              //          // embeddedImage: AssetImage('assets/images/ahmed.jpeg'),
              //
              //           size: 400.0,
              //         ),
              //
              //         Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 20.0),
              //           child: Text(
              //             "Ahmed  Abd El-latif",
              //             style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              /// name
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Ahmed  Abd El-latif",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              /// space
              const SizedBox(height: 20),

              /// email
              SocialMediaText(
                text: "ahmedmohamedaneng@gmail.com",
                subText: "email",
                imageUrl: "assets/images/google-logo.png",
                url: "ahmedmohamedaneng@gmail.com",
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
                onClicked: () => composeEmail(email: "ahmedmohamedaneng@gmail.com"),
              ),

              /// phone
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// call
                  SocialMediaText(
                    text: "Call Me",
                    subText: "call",
                    imageUrl: "assets/images/phoneCall.png",
                    url: "",
                    imageColor: Colors.green,
                    onClicked: () => makeAPhoneCall("+2001124466700"),
                  ),

                  const SizedBox(width: 20),

                  /// whatsapp
                  SocialMediaText(
                    text: "Message Me",
                    subText: "whatsapp",
                    imageUrl: "assets/images/whatsapp.png",
                    url: "",
                    onClicked: () => openWhatsapp(const WhatsappParams(
                        num: "2001124466700",
                        text:
                            "I reached you through the personal QR code, I would like to inform you that ...")),
                  ),
                ],
              ),

              /// linkedIn
              const SocialMediaText(
                text: "Connect with me on LinkedIn",
                subText: "Ahmed Mohamed",
                imageUrl: "assets/images/linked_in.png",
                url: "https://www.linkedin.com/in/ahmedmohamedmobiledeveloper",
              ),

              /// Github
              const SocialMediaText(
                text: "Follow me on Github",
                subText: "AhmedAbdEllatiif",
                imageUrl: "assets/images/github.png",
                url: "https://github.com/AhmedAbdEllatiif?tab=repositories",
              ),

              /// instagram
              const SocialMediaText(
                text: "Follow me on Instagram",
                subText: "ahmeedmohameedd",
                imageUrl: "assets/images/instagram.png",
                url: "https://instagram.com/ahmeedmohameedd?igshid=YmMyMTA2M2Y=",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
