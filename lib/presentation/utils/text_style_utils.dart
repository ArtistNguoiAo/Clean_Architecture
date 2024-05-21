import 'package:flutter/cupertino.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';
import 'package:risky_coin/presentation/utils/font_utils.dart';

class TextStyleUtils {
  // font
  static const TextStyle textStyleNunito = TextStyle(fontFamily: FontUtils.nunito);

  // size
  static TextStyle textStyleNunitoS16 = textStyleNunito.copyWith(fontSize: 16);
  static TextStyle textStyleNunitoS18 = textStyleNunito.copyWith(fontSize: 18);
  static TextStyle textStyleNunitoS20 = textStyleNunito.copyWith(fontSize: 20);

  // weight
  static TextStyle textStyleNunitoS16W400 = textStyleNunitoS16.copyWith(fontWeight: FontWeight.w400);
  static TextStyle textStyleNunitoS18W500 = textStyleNunitoS18.copyWith(fontWeight: FontWeight.w500);
  static TextStyle textStyleNunitoS20W600 = textStyleNunitoS20.copyWith(fontWeight: FontWeight.w600);

  // color
  static TextStyle textStyleNunitoS16W400Black = textStyleNunitoS16W400.copyWith(color: ColorUtils.black);
  static TextStyle textStyleNunitoS16W400Primary = textStyleNunitoS16W400.copyWith(color: ColorUtils.primaryColor);
  static TextStyle textStyleNunitoS16W400Red = textStyleNunitoS16W400.copyWith(color: ColorUtils.red);
  static TextStyle textStyleNunitoS18W500Black = textStyleNunitoS18W500.copyWith(color: ColorUtils.black);
  static TextStyle textStyleNunitoS20W600White = textStyleNunitoS20W600.copyWith(color: ColorUtils.white);
}