import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:realator_rapid_api/model/model.dart';
import 'package:realator_rapid_api/service/service.dart';


class GetDataController extends GetxController {

 var isDataLoading = false.obs;

  var isfirstData = false.obs;
 
  RxList<WelcomeSuccess> saveData = <WelcomeSuccess>[].obs;
var itemName = ''.obs;
 var searchItemController = TextEditingController().obs;
  
  Future<bool> filmDataResult() async {
    isDataLoading(true);
    try {
      saveData.clear();
      debugPrint('api called');
      var welcomeSuccessList = await DataService().getFilmData();
      debugPrint('welcomeSuccessList fetched...');

      saveData.addAll([welcomeSuccessList]);
      debugPrint('save data list $saveData');
      if (saveData.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to get data in controller $e');
    } finally {
      isDataLoading(false);
    }
  }

}