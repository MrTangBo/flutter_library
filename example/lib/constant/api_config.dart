/*Api管理*/
class Api {


  static final getBannerType = {1: "https://kylinba.ejar.cn/contentManagement/getBannerByType"};

  static final getVersion = {2: "https://kylinba.ejar.cn/version/getVersion"};

  static const baseUrl = "http://192.168.5.81:9170";

  static const idCardAnalysis = {1: "$baseUrl/relate/query/idCard"};

  static const getCarList = {1: "$baseUrl/car/getCarListApi"};
}
