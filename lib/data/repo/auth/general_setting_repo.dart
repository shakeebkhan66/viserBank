
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/utils/method.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/url.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/services/api_service.dart';

class GeneralSettingRepo {

  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient});

  Future<dynamic> getGeneralSetting() async {
      String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;
  }

  Future<dynamic> getLanguage(String languageCode) async {
    try{
      String url='${UrlContainer.baseUrl}${UrlContainer.languageUrl}$languageCode';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;
    }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }

  }

  Future<ResponseModel>logout()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.userLogoutEndPoint}';
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null,passHeader: true);
    await clearSharedPrefData();
    return responseModel;
  }

  Future<void> clearSharedPrefData()async{
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    await apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    return Future.value();
  }

}
