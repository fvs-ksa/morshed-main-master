import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:morshed/constant/text_theme.dart';
import '../constant/const_color.dart';
import '../models/api_model/profile_model.dart';

void showToast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,

        fontSize: 16.0.sp);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = orangeColor;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget richText(
    {required Function navigation,
    required String text,
    required String tappedText,
    required BuildContext context}) {
  return Text.rich(
      maxLines: 1,

      TextSpan(

      text: text,
      style: cairoRegular.copyWith(fontSize: 17),
      children: [
        TextSpan(
            text: tappedText,
            style: cairoBold.copyWith(fontSize: 17,decoration: TextDecoration.underline,color: darkMainColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigation();
              })
      ]));
}
cardIdWidget({required ProfileModel model,required BuildContext context,
// double? height,
//   double? width,
}){
 return Padding(
   padding: const EdgeInsets.all(28.0),
   child: Card(
     elevation: 3,
     clipBehavior: Clip.antiAliasWithSaveLayer,
     color: lightMainColor,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
     child: Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 16.h,horizontal: 16.w),

          child: Container(
            height: 200,
            width:double.infinity,
            decoration: BoxDecoration(

              color: lightMainColor,
              borderRadius: BorderRadius.circular(25),

            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:CircleAvatar(backgroundImage: NetworkImage(model.data!.image!),radius: 30,) ,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(model.data!.nameAr??'',style: cairoBold.copyWith(fontSize: 20,color: whiteColor),maxLines: 1,),
                    ),
                    subtitle: Text(model.data!.id.toString()??'',style: cairoRegular.copyWith(color: whiteColor,fontSize: 17)),
                    trailing:
                      Container(
                          height: 60,
                          width: 60,
                          child: FittedBox(child: Image.network(model.data!.qrCode??''))),
                  ),
                  // Row(children: [
                  //
                  //
                  //  // SizedBox(width: 10,),
                  //
                  //   // Spacer(),
                  //   // Container(
                  //   //     height: 60,
                  //   //     width: 60,
                  //   //     child: FittedBox(child: Image.network(model.data!.qrCode!)))
                  // ],),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.data!.nationality??'',style: cairoRegular.copyWith(fontSize: 17,color: whiteColor),),
                      Text(model.data!.arrivalDate??'',style: cairoRegular.copyWith(fontSize: 17,color: whiteColor))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.data!.companyName??'',style: cairoRegular.copyWith(fontSize: 17,color: whiteColor)),
                      Text(model.data!.departureDate??'',style: cairoRegular.copyWith(fontSize: 17,color: whiteColor))
                    ],
                  )

                ],
              ),
            ),
          )
      ),
   ),
 );
}
cardIdWidgetSmallSize({required ProfileModel model,required BuildContext context,
  // double? height,
  // double? width,
}){
  TextStyle style=cairoSemiBold.copyWith(fontSize: 14,color: whiteColor);
  return Card(
    elevation: 3,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: darkMainColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
    child: Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 5.w),

        child: Container(
          height: 130,
          width:220.w,
          decoration: BoxDecoration(
            color: darkMainColor,
            borderRadius: BorderRadius.circular(25),

          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(model.data!.image!),radius: 17,),
                      Container(
                          height: 30,
                          width: 30,
                          child: FittedBox(child: Image.network(model.data!.qrCode!))),
                    ],
                ),
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(model.data!.nameAr!,style: style,softWrap: true,presetFontSizes: [10,8,9]),
                    AutoSizeText(model.data!.id!.toString(),style: style,softWrap: true,presetFontSizes: [10,8,9])
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(model.data!.nationality??'',softWrap: true,style: style,presetFontSizes: [10,8,9]),
                    AutoSizeText(model.data!.arrivalDate??'',softWrap: true,style: style,presetFontSizes: [10,8,9])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(model.data!.companyName??'',softWrap: true,style: style,presetFontSizes: [10,8,9]),
                    AutoSizeText(model.data!.departureDate??"",softWrap: true,style: style,presetFontSizes: [10,8,9])
                  ],
                )

              ],
            ),
          ),
        )
    ),
  );
}
