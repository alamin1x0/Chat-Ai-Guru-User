import 'package:get/get.dart';
import 'package:probot/controllers/common_controllers/text_to_speech_controller.dart';
import 'package:probot/widgets/dialog_common.dart';
import 'package:probot/widgets/text_common.dart';

import 'common/app_array.dart';
import 'common/app_fonts.dart';
import 'common/session.dart';
import 'controllers/common_controllers/ad_controller.dart';
import 'controllers/common_controllers/app_controller.dart';
export '../controllers/index.dart';

export 'package:flutter/material.dart';
// All extensions library
export '../common/extension/text_style_extensions.dart';
export '../common/extension/widget_extension.dart';
export '../common/theme/app_css.dart';
export '../common/assets/index.dart';
export '../common/extension/spacing.dart';
export '../common/theme/theme_service.dart';
export '../common/theme/app_theme.dart';

// All models library


export '../models/home_option_model.dart';
export '../models/select_language_model.dart';
export '../models/notification_model.dart';
export '../models/content_model.dart';
export '../models/image_list_model.dart';
export '../models/page_list_model.dart';
export '../models/image_model.dart';
export '../models/firebase_config.dart';
export '../package_list.dart';
export '../routes/index.dart';
export '../routes/route_name.dart';
export '../routes/screen_list.dart';

//utils
export '../utils/extensions.dart';

// All widgets library
export '../widgets/button_common.dart';
export '../widgets/dotted_line.dart';
export '../widgets/or_layout.dart';
export '../widgets/text_field_common.dart';
export '../widgets/validation.dart';
export '../widgets/app_bar_common.dart';
export '../widgets/directionality_rtl.dart';
export '../widgets/common_menu_icon.dart';
export '../widgets/auth_app_bar_common.dart';

export '../models/message_model.dart';
export '../models/chat_model.dart';
export '../widgets/common_pop_up_title.dart';
export '../widgets/alert_dialog_common.dart';
export '../widgets/common_stream.dart';
export '../widgets/scaffold_messenger.dart';
export '../widgets/adviser_dialog_common.dart';
export '../widgets/select_gender_layout.dart';
export '../widgets/api_notes_layout.dart';
export '../widgets/common_balance.dart';
export '../../../widgets/ad_layout_common.dart';
export '../../../widgets/common_social_login.dart';
export '../../../widgets/chat_loader_common.dart';
export '../../../widgets/favorite_list.dart';
export '../../../widgets/quick_advice_list.dart';
export '../models/category_access_model.dart';
export '../../widgets/common_app_widget.dart';


final appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());
final addCtrl = Get.isRegistered<AdController>()
    ? Get.find<AdController>()
    : Get.put(AdController());
final textToSpeechCtrl = Get.isRegistered<TextToSpeechController>()
    ? Get.find<TextToSpeechController>()
    : Get.put(TextToSpeechController());


AppFonts appFonts = AppFonts();
AppArray appArray = AppArray();
Session session = Session();
TextCommon textCommon = TextCommon();
DialogLayout dialogLayout = DialogLayout();
