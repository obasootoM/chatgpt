import 'package:chatgpt/models/mod.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class ModelProvider with ChangeNotifier {
  List<Model> modelList = [];
  String currentModel = 'text-davinci-001';
  List<Model> get getModelList {
    return modelList;
  }

  String get currentModelList {
    return currentModel;
  }

 void setcurrentModel(String getMoedl) {
    currentModel = getMoedl;
    notifyListeners();
  }

  Future<List<Model>> getAllModel() async {
    modelList = await Apiservice.getModel();
    return modelList;
  }
}
