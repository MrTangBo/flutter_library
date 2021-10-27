library flutter_library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


/*export*/
export 'package:dio/dio.dart';
export 'package:get/get.dart' hide Response, MultipartFile, FormData;
export 'package:flutter_easyrefresh/easy_refresh.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:date_format/date_format.dart';
export 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
export 'package:octo_image/octo_image.dart';
export 'package:image_picker/image_picker.dart';
export 'package:fijkplayer/fijkplayer.dart';
export 'package:wakelock/wakelock.dart';
export 'package:top_snackbar_flutter/top_snack_bar.dart';
export 'package:top_snackbar_flutter/custom_snack_bar.dart';
export 'package:flutter_svg/svg.dart';

/*base*/
part './base/tb_base_logic.dart';

part './base/tb_base_view_state.dart';

part './base/tb_base_widget_state.dart';
/*config*/
part './config/tb_app_colors.dart';

part './config/tb_app_theme.dart';

part './config/tb_base_globalization.dart';

part './config/tb_system_config.dart';
/*http*/
part './http/quest_list_info.dart';

part './http/quest_repeat_list_info.dart';

part './http/tb_http_result.dart';

part './http/tb_http_utils.dart';
/*util*/
part './util/regex_config.dart';

part './util/size_util.dart';

part './util/tb_log_utils.dart';

part './util/shared_preferences_utils.dart';

/*extend*/
part './extend/extend.dart';
part './extend/refresh_header.dart';
part './extend/refresh_footer.dart';



