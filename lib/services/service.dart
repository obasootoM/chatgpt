import 'package:flutter/material.dart';

import '../constant/const.dart';
import '../widget/widget.dart';

class Services {
  
  Future<void> showModel(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: ConstantColor.scaffoldBackgroundcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TextWidget(
                  label: 'chose Model:',
                  fontSize: 16,
                  color: Colors.white,
                )),
                Flexible(
                  flex: 2,
                  child: DropDownWidget())
              ],
            ),
          );
        });
  }
}
