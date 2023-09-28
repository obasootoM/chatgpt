import 'package:chatgpt/models/mod.dart';
import 'package:chatgpt/provider/model_provider.dart';
import 'package:chatgpt/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/const.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context, listen: false);
    currentModel = modelProvider.currentModelList;
    return FutureBuilder<List<Model>>(
        future: modelProvider.getAllModel(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: TextWidget(
                label: snapShot.error.toString(),
                fontSize: 15,
              ),
            );
          }
          return snapShot.data == null || snapShot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: ConstantColor.scaffoldBackgroundcolor,
                      value: currentModel,
                      items: List<DropdownMenuItem<String>>.generate(
                          snapShot.data!.length,
                          (index) => DropdownMenuItem(
                              value: snapShot.data![index].id,
                              child: TextWidget(
                                label: snapShot.data![index].id,
                                fontSize: 18,
                              ))),
                      onChanged: (String? value) {
                        setState(() {
                          currentModel = value.toString();
                        });
                        modelProvider.setcurrentModel(value.toString());
                      }),
                );
        });
  }
}
