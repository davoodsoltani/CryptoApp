

import 'package:flutter/cupertino.dart';

import '../../data/data_source/api_provider.dart';
import '../../data/data_source/response_model.dart';
import '../../data/models/crypto_model/AllCryptoModel.dart';


class MarketViewProvider extends ChangeNotifier{
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;

  late ResponseModel state;
  var response;


  getCryptoData() async {

    state = ResponseModel.loading("is loading...");

    try{
      response = await apiProvider.getAllCryptoData();
      if(response.statusCode == 200){
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("something wrong please try again...");
      }
      notifyListeners();
    }catch(e){
      state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }



}