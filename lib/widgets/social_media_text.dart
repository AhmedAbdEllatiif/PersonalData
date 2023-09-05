import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../comman/functions/open_url.dart';

class SocialMediaText extends StatefulWidget {
  final String text;
  final String subText;
  final String url;
  final String imageUrl;
  final Function()? onClicked;
  final Color? imageColor;
  final TextStyle? textStyle;

  const SocialMediaText({
    Key? key,
    required this.text,
    required this.subText,
    required this.imageUrl,
    required this.url,
    this.imageColor,
    this.textStyle,
    this.onClicked,
  }) : super(key: key);

  @override
  State<SocialMediaText> createState() => _SocialMediaTextState();
}

class _SocialMediaTextState extends State<SocialMediaText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double imageHeight = _buildSize();
    final double imageWidth = _buildSize();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          /// image
          Image.asset(
            widget.imageUrl,
            fit: BoxFit.contain,
            width: imageWidth,
            height: imageHeight,
            color: widget.imageColor,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// text
                // RichText(
                //   text: TextSpan(
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: widget.text,
                //         style:
                //             Theme.of(context).textTheme.headlineSmall!.copyWith(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //         recognizer: TapGestureRecognizer()
                //           ..onTap = widget.onClicked ??
                //               () => openUrl(url: widget.url),
                //       ),
                //     ],
                //   ),
                // ),

                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8
                  ),
                  child: SelectableText(
                    widget.text,
                     onTap:  widget.onClicked ??
                      () => openUrl(url: widget.url),
                    style: widget.textStyle ?? Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),

                  ),
                ),


                /// subText
                SelectableText(
                  widget.subText,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _buildSize() {
    return ResponsiveValue(context, defaultValue: 20.0, valueWhen: [
          const Condition.equals(name: DESKTOP, value: 50.0),
          const Condition.largerThan(name: TABLET, value: 38.0),
          const Condition.equals(name: TABLET, value: 35.0),
          const Condition.equals(name: MOBILE, value: 30.0),
          const Condition.smallerThan(name: MOBILE, value: 22.0),
        ]).value ??
        24.0;
  }
}
