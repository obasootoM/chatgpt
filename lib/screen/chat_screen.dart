import 'package:chatgpt/constant/constant.dart';
import 'package:chatgpt/provider/model_provider.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/services/asset_manager.dart';
import 'package:chatgpt/widget/widget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/mod.dart';
import '../services/service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Services _services = Services();
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  late FocusNode focusNode;
  late ScrollController _scrollController;
  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusNode = FocusNode();
    _scrollController = ScrollController();
    controller = TextEditingController();
    super.initState();
  }

  void showModal() async {
    await _services.showModel(context);
  }

  List<ChatModel> chatMessage = [];
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AssetManager.openai,
              height: 40,
            ),
          ),
          title: const Text(
            'ChapGpt',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: showModal, icon: const Icon(Icons.more_vert_rounded))
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            Flexible(
                child: ListView.builder(
                    itemCount: chatMessage.length,
                    itemBuilder: (context, index) {
                      return WidgetScreen(
                          msg: chatMessage[index].msg,
                          index: chatMessage[index].index);
                    })),
            if (isLoading) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              )
            ],
            const SizedBox(
              height: 20,
            ),
            Material(
              color: ConstantColor.cardcolor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: controller,
                        onSubmitted: (value) async {
                          sendMessage(modelProvider: modelProvider);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: 'type here'),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          sendMessage(modelProvider: modelProvider);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  void scrollToTheEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeOut);
  }

  Future<void> sendMessage({required modelProvider}) async {
    try {
      setState(() {
        isLoading = true;
        chatMessage.add(ChatModel(msg: controller.text, index: 0));
        controller.text;
        focusNode.unfocus();
      });
      chatMessage.addAll(await Apiservice.sendModel(
          msg: controller.text, modelId: modelProvider.currentModelList));
      setState(() {});
    } catch (e) {
      print('e $e');
    } finally {
      setState(() {

        isLoading = false;
      });
    }
  }
}
