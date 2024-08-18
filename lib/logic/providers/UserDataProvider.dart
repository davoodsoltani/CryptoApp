
import 'package:flutter/cupertino.dart';

import '../../data/data_source/api_provider.dart';
import '../../data/data_source/response_model.dart';
import '../../data/models/UserModel.dart';

class UserDataProvider extends ChangeNotifier{
  ApiProvider apiProvider = ApiProvider();

  late dynamic dataFuture;
  ResponseModel? registerStatus;
  var error;
  var response;

  callRegisterApi(name, email, password) async {

    registerStatus = ResponseModel.loading("is loading...");
    notifyListeners();

    try{
      response = await apiProvider.callRegisterApi(name, email, password);
      if(response.statusCode == 201){
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);

      }else if(response.statusCode == 200){
        dataFuture = ApiStatus.fromJson(response.data);
        registerStatus = ResponseModel.error(dataFuture.message);
      }
      notifyListeners();

    }catch(e) {
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

}