library flutter_library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_proxy/system_proxy.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

export 'package:badges/badges.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:date_format/date_format.dart';
/*export*/
export 'package:dio/dio.dart';
export 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:flutter_easyrefresh/easy_refresh.dart';
export 'package:flutter_pickers/pickers.dart';
export 'package:flutter_svg/svg.dart';
export 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
export 'package:flutter_xupdate/flutter_xupdate.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:get/get.dart' hide Response, MultipartFile, FormData;
export 'package:image_picker/image_picker.dart';
export 'package:marquee/marquee.dart';
export 'package:octo_image/octo_image.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:top_snackbar_flutter/custom_snack_bar.dart';
export 'package:top_snackbar_flutter/top_snack_bar.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:wakelock/wakelock.dart';

/*base*/
part './base/tb_base_logic.dart';
part './base/tb_base_state.dart';
part './base/tb_base_view.dart';
/*config*/
part './config/tb_app_colors.dart';
part './config/tb_app_theme.dart';
part './config/tb_base_globalization.dart';
part './config/tb_system_config.dart';
/*extend*/
part './extend/extend.dart';
part './extend/refresh_footer.dart';
part './extend/refresh_header.dart';
/*http*/
part './http/quest_list_info.dart';
part './http/quest_repeat_list_info.dart';
part './http/tb_http_result.dart';
part './http/tb_http_utils.dart';
/*tbNavigation*/
part './tb_bottom_navigation/tb_bottom_navigation_logic.dart';
part './tb_bottom_navigation/tb_bottom_navigation_state.dart';
part './tb_bottom_navigation/tb_bottom_navigation_view.dart';
/*tbLayout*/
part './tb_tab_layout_widget/tb_tab_layout_widget_logic.dart';
part './tb_tab_layout_widget/tb_tab_layout_widget_state.dart';
part './tb_tab_layout_widget/tb_tab_layout_widget_view.dart';
/*util*/
part './util/regex_config.dart';
part './util/shared_preferences_utils.dart';
part './util/size_util.dart';
part './util/tb_log_utils.dart';
