import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/services/asset_manager.dart';
import 'package:chatgpt/widget/widget.dart';
import 'package:flutter/material.dart';
import '../constant/const.dart';

class WidgetScreen extends StatelessWidget {
  const WidgetScreen({super.key, required this.msg, required this.index});
  final String msg;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: index == 0 ? ConstantColor.scaffoldBackgroundcolor : ConstantColor.cardcolor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  index == 0 ? AssetManager.openperson : AssetManager.openlogo,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: index ==0 ? TextWidget(label: msg) : DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    animatedTexts: [TyperAnimatedText(msg.trim())]),
                )),
                index == 0 ? const SizedBox.shrink() :
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.thumb_up_alt_outlined,color: Colors.white,),
                    SizedBox(width: 10,),
                    Icon(Icons.thumb_down_alt_outlined,color: Colors.white,)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
