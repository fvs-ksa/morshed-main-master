// import 'dart:async';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:morshed/bloc/notification_cubit/state.dart';
// import 'package:morshed/constant/const_color.dart';
// import 'package:morshed/constant/text_theme.dart';
// import '../../bloc/notification_cubit/cubit.dart';
// import '../../models/api_model/notification_model.dart';
// import '../../tranlations/locale_keys.g.dart';
//
// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }
//
// class _NotificationsScreenState extends State<NotificationsScreen> {
//   // @override
//   // void dispose() {
//   //  // NotificationCubit.get(context).notificationStream.close();
//   //   super.dispose();
//   // }
//   // @override
//   // void didChangeDependencies() {
//   //  // NotificationCubit.get(context).notificationStream;
//   //   super.didChangeDependencies();
//   // }
//   // @override
//   // void initState() {
//   //   //Timer.periodic(Duration(seconds: 3), (timer) {
//   //     NotificationCubit.get(context).getNotificationData();
//   //   //});
//   //   super.initState();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     var notificationCubit = NotificationCubit.get(context);
//     return BlocConsumer<NotificationCubit, NotificationState>(
//         listener: (context, state) {},
//        // bloc: notificationCubit.getNotificationData(),
//         builder: (context, state) {
//           return
//            notificationCubit.isNotificationGet?
//            notificationCubit.getNotificationModel.notifications!.isEmpty
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset('assets/svg/notifications.svg'),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         Center(
//                           child: Text(
//                             LocaleKeys.no_notifications.tr(),
//                             style: cairoMedium.copyWith(fontSize: 20),
//                           ),
//                         )
//                       ],
//                     )
//                   : Scaffold(
//                       body: FutureBuilder<GetNotificationModel?>(
//                         future: notificationCubit.getNotificationData(),
//                         builder: (context,snapShot) {
//                           if(snapShot.hasData){
//                             Widget widget=  Column(
//                               children: [
//                                 Card(
//                                   margin: EdgeInsets.zero,
//                                   elevation: 3,
//                                   child: Container(
//                                     height: 148.h,
//                                     padding: EdgeInsetsDirectional.only(top: 30
//                                         .h),
//                                     child: Center(
//                                         child: Text(
//                                           LocaleKeys.notifications.tr(),
//                                           style:
//                                           cairoBold.copyWith(fontSize: 20),
//                                           textAlign: TextAlign.center,
//                                         )),
//                                   ),
//                                 ),
//                                 //Divider(),
//                                 Expanded(
//                                   child: ListView.separated(
//                                     padding: EdgeInsetsDirectional.only(top: 10
//                                         .h),
//                                     itemBuilder: (context, index) {
//                                       //DateTime dateTime1 = DateTime.parse(snapShot.data?.notifications![index].createdAt??'');
//                                       DateTime dateTime = DateTime.parse(
//                                           snapShot.data?.notifications![index]
//                                               .createdAt ?? '');
//                                       String date =
//                                           "${dateTime.year}-${dateTime.month
//                                           .toString().padLeft(
//                                           2, '0')}-${dateTime.day.toString()
//                                           .padLeft(2, '0')}";
//                                       String time =
//                                           "${dateTime.hour.toString().padLeft(
//                                           2, '0')}:${dateTime.minute.toString()
//                                           .padLeft(2, '0')}";
//                                       return GestureDetector(
//                                         onTap: () {
//                                           notificationCubit
//                                               .markNotificationAsRead(
//                                               id: snapShot.data
//                                                   ?.notifications![index].id ??
//                                                   0
//                                           );
//                                           // notificationCubit.markNotificationAsRead(
//                                           //     id: notificationCubit
//                                           //         .getNotificationModel
//                                           //         .notifications![index]
//                                           //         .id!
//                                           // );
//                                           //notificationCubit.getNotificationData();
//                                         },
//                                         child: Container(
//                                           color: notificationCubit
//                                               .getNotificationModel
//                                               .notifications![index]
//                                               .read ==
//                                               true
//                                               ? whiteColor
//                                               : whiteGreyColor.withOpacity(0.1),
//                                           padding: EdgeInsetsDirectional.only(
//                                               start: 20.w, top: 0, bottom: 0),
//                                           height: 86.5.h,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   SvgPicture.asset(
//                                                     'assets/svg/notifications.svg',
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10.w,
//                                                   ),
//                                                   Text(
//                                                     snapShot.data
//                                                         ?.notifications![index]
//                                                         .title ?? '',
//                                                     style: cairoBold.copyWith(fontSize: 17)
//                                                       ,
//                                                   ),
//                                                   // Text(
//                                                   //   notificationCubit
//                                                   //       .getNotificationModel
//                                                   //       .notifications![index]
//                                                   //       .title!,
//                                                   //   style: cairoBold.copyWith(fontSize: 17),
//                                                   // ),
//                                                   const Spacer(),
//                                                   Text(
//                                                     date,
//                                                     style: cairoRegular
//                                                         .copyWith(fontSize: 12,
//                                                         color: whiteGreyColor),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               Text(snapShot.data
//                                                   ?.notifications![index]
//                                                   .message ?? '',
//                                                 textAlign: TextAlign.start,
//                                                 style: cairoRegular.copyWith(
//                                                     fontSize: 14,
//                                                     color: greyColor),)
//                                               // Text(
//                                               //   notificationCubit
//                                               //       .getNotificationModel
//                                               //       .notifications![index]
//                                               //       .message!,
//                                               //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                                               //   textAlign: TextAlign.start,
//                                               // ),
//                                               // Text(
//                                               //   notificationCubit
//                                               //       .getNotificationModel
//                                               //       .notifications![index]
//                                               //       .message!,
//                                               //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                                               //   textAlign: TextAlign.start,
//                                               // ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     separatorBuilder: (context, index) {
//                                       return Divider(
//                                         height: 1,
//                                         thickness: 2,
//                                         endIndent: 8.w,
//                                         indent: 8.w,
//                                       );
//                                     },
//                                     itemCount: snapShot.data?.notifications!.length??0,
//                                     // itemCount: notificationCubit
//                                     //     .getNotificationModel
//                                     //     .notifications!
//                                     //     .length
//                                   ),
//                                 )
//                               ],
//                             );
//                           }else{
//                             Center(
//                               child: CircularProgressIndicator.adaptive(
//                                 backgroundColor: orangeColor,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   darkMainColor, //<-- SEE HERE
//                                 ),
//                               ),
//                             );
//                           }
//                           return widget;
//                           // switch(snapShot.connectionState){
//                           //   case ConnectionState.waiting:return Text('data');
//                           //   default: if(snapShot.hasError){
//                           //     Text(LocaleKeys.error_occurred.tr());
//                           //   }else{
//                           //
//                           //   }
//                           // }
//                           // if(snapShot.connectionState==ConnectionState.waiting){
//                           //   Center(
//                           //     child: CircularProgressIndicator.adaptive(
//                           //       backgroundColor: orangeColor,
//                           //       valueColor: AlwaysStoppedAnimation<Color>(
//                           //         darkMainColor, //<-- SEE HERE
//                           //       ),
//                           //     ),
//                           //   );
//                           // }else {
//                           //   return Column(
//                           //     children: [
//                           //       Card(
//                           //         margin: EdgeInsets.zero,
//                           //         elevation: 3,
//                           //         child: Container(
//                           //           height: 148.h,
//                           //           padding: EdgeInsetsDirectional.only(top: 30
//                           //               .h),
//                           //           child: Center(
//                           //               child: Text(
//                           //                 LocaleKeys.notifications.tr(),
//                           //                 style:
//                           //                 cairoBold.copyWith(fontSize: 20),
//                           //                 textAlign: TextAlign.center,
//                           //               )),
//                           //         ),
//                           //       ),
//                           //       //Divider(),
//                           //       Expanded(
//                           //         child: ListView.separated(
//                           //           padding: EdgeInsetsDirectional.only(top: 10
//                           //               .h),
//                           //           itemBuilder: (context, index) {
//                           //             //DateTime dateTime1 = DateTime.parse(snapShot.data?.notifications![index].createdAt??'');
//                           //             DateTime dateTime = DateTime.parse(
//                           //                 snapShot.data?.notifications![index]
//                           //                     .createdAt ?? '');
//                           //             String date =
//                           //                 "${dateTime.year}-${dateTime.month
//                           //                 .toString().padLeft(
//                           //                 2, '0')}-${dateTime.day.toString()
//                           //                 .padLeft(2, '0')}";
//                           //             String time =
//                           //                 "${dateTime.hour.toString().padLeft(
//                           //                 2, '0')}:${dateTime.minute.toString()
//                           //                 .padLeft(2, '0')}";
//                           //             return GestureDetector(
//                           //               onTap: () {
//                           //                 notificationCubit
//                           //                     .markNotificationAsRead(
//                           //                     id: snapShot.data
//                           //                         ?.notifications![index].id ??
//                           //                         0
//                           //                 );
//                           //                 // notificationCubit.markNotificationAsRead(
//                           //                 //     id: notificationCubit
//                           //                 //         .getNotificationModel
//                           //                 //         .notifications![index]
//                           //                 //         .id!
//                           //                 // );
//                           //                 //notificationCubit.getNotificationData();
//                           //               },
//                           //               child: Container(
//                           //                 color: notificationCubit
//                           //                     .getNotificationModel
//                           //                     .notifications![index]
//                           //                     .read ==
//                           //                     true
//                           //                     ? whiteColor
//                           //                     : whiteGreyColor.withOpacity(0.1),
//                           //                 padding: EdgeInsetsDirectional.only(
//                           //                     start: 20.w, top: 0, bottom: 0),
//                           //                 height: 86.5.h,
//                           //                 child: Column(
//                           //                   crossAxisAlignment:
//                           //                   CrossAxisAlignment.start,
//                           //                   children: [
//                           //                     Row(
//                           //                       children: [
//                           //                         SvgPicture.asset(
//                           //                           'assets/svg/notifications.svg',
//                           //                         ),
//                           //                         SizedBox(
//                           //                           width: 10.w,
//                           //                         ),
//                           //                         Text(
//                           //                           snapShot.data
//                           //                               ?.notifications![index]
//                           //                               .title ?? '',
//                           //                           style: cairoBold.copyWith(
//                           //                               fontSize: 17),
//                           //                         ),
//                           //                         // Text(
//                           //                         //   notificationCubit
//                           //                         //       .getNotificationModel
//                           //                         //       .notifications![index]
//                           //                         //       .title!,
//                           //                         //   style: cairoBold.copyWith(fontSize: 17),
//                           //                         // ),
//                           //                         const Spacer(),
//                           //                         Text(
//                           //                           date,
//                           //                           style: cairoRegular
//                           //                               .copyWith(fontSize: 12,
//                           //                               color: whiteGreyColor),
//                           //                         ),
//                           //                       ],
//                           //                     ),
//                           //                     SizedBox(
//                           //                       height: 10.h,
//                           //                     ),
//                           //                     Text(snapShot.data
//                           //                         ?.notifications![index]
//                           //                         .message ?? '',
//                           //                       textAlign: TextAlign.start,
//                           //                       style: cairoRegular.copyWith(
//                           //                           fontSize: 14,
//                           //                           color: greyColor),)
//                           //                     // Text(
//                           //                     //   notificationCubit
//                           //                     //       .getNotificationModel
//                           //                     //       .notifications![index]
//                           //                     //       .message!,
//                           //                     //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                           //                     //   textAlign: TextAlign.start,
//                           //                     // ),
//                           //                     // Text(
//                           //                     //   notificationCubit
//                           //                     //       .getNotificationModel
//                           //                     //       .notifications![index]
//                           //                     //       .message!,
//                           //                     //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                           //                     //   textAlign: TextAlign.start,
//                           //                     // ),
//                           //                   ],
//                           //                 ),
//                           //               ),
//                           //             );
//                           //           },
//                           //           separatorBuilder: (context, index) {
//                           //             return Divider(
//                           //               height: 1,
//                           //               thickness: 2,
//                           //               endIndent: 8.w,
//                           //               indent: 8.w,
//                           //             );
//                           //           },
//                           //           itemCount: snapShot.data!.notifications!
//                           //               .length,
//                           //           // itemCount: notificationCubit
//                           //           //     .getNotificationModel
//                           //           //     .notifications!
//                           //           //     .length
//                           //         ),
//                           //       )
//                           //     ],
//                           //   );
//                           // }
//                           // return Column(
//                           //   children: [
//                           //     Card(
//                           //       margin: EdgeInsets.zero,
//                           //       elevation: 3,
//                           //       child: Container(
//                           //         height: 148.h,
//                           //         padding: EdgeInsetsDirectional.only(top: 30
//                           //             .h),
//                           //         child: Center(
//                           //             child: Text(
//                           //               LocaleKeys.notifications.tr(),
//                           //               style:
//                           //               cairoBold.copyWith(fontSize: 20),
//                           //               textAlign: TextAlign.center,
//                           //             )),
//                           //       ),
//                           //     ),
//                           //     //Divider(),
//                           //     Expanded(
//                           //       child: ListView.separated(
//                           //         padding: EdgeInsetsDirectional.only(top: 10
//                           //             .h),
//                           //         itemBuilder: (context, index) {
//                           //           //DateTime dateTime1 = DateTime.parse(snapShot.data?.notifications![index].createdAt??'');
//                           //           DateTime dateTime = DateTime.parse(
//                           //               snapShot.data?.notifications![index]
//                           //                   .createdAt ?? '');
//                           //           String date =
//                           //               "${dateTime.year}-${dateTime.month
//                           //               .toString().padLeft(
//                           //               2, '0')}-${dateTime.day.toString()
//                           //               .padLeft(2, '0')}";
//                           //           String time =
//                           //               "${dateTime.hour.toString().padLeft(
//                           //               2, '0')}:${dateTime.minute.toString()
//                           //               .padLeft(2, '0')}";
//                           //           return GestureDetector(
//                           //             onTap: () {
//                           //               notificationCubit
//                           //                   .markNotificationAsRead(
//                           //                   id: snapShot.data
//                           //                       ?.notifications![index].id ??
//                           //                       0
//                           //               );
//                           //               // notificationCubit.markNotificationAsRead(
//                           //               //     id: notificationCubit
//                           //               //         .getNotificationModel
//                           //               //         .notifications![index]
//                           //               //         .id!
//                           //               // );
//                           //               //notificationCubit.getNotificationData();
//                           //             },
//                           //             child: Container(
//                           //               color: notificationCubit
//                           //                   .getNotificationModel
//                           //                   .notifications![index]
//                           //                   .read ==
//                           //                   true
//                           //                   ? whiteColor
//                           //                   : whiteGreyColor.withOpacity(0.1),
//                           //               padding: EdgeInsetsDirectional.only(
//                           //                   start: 20.w, top: 0, bottom: 0),
//                           //               height: 86.5.h,
//                           //               child: Column(
//                           //                 crossAxisAlignment:
//                           //                 CrossAxisAlignment.start,
//                           //                 children: [
//                           //                   Row(
//                           //                     children: [
//                           //                       SvgPicture.asset(
//                           //                         'assets/svg/notifications.svg',
//                           //                       ),
//                           //                       SizedBox(
//                           //                         width: 10.w,
//                           //                       ),
//                           //                       Text(
//                           //                         snapShot.data
//                           //                             ?.notifications![index]
//                           //                             .title ?? '',
//                           //                         style: cairoBold.copyWith(
//                           //                             fontSize: 17),
//                           //                       ),
//                           //                       // Text(
//                           //                       //   notificationCubit
//                           //                       //       .getNotificationModel
//                           //                       //       .notifications![index]
//                           //                       //       .title!,
//                           //                       //   style: cairoBold.copyWith(fontSize: 17),
//                           //                       // ),
//                           //                       const Spacer(),
//                           //                       Text(
//                           //                         date,
//                           //                         style: cairoRegular
//                           //                             .copyWith(fontSize: 12,
//                           //                             color: whiteGreyColor),
//                           //                       ),
//                           //                     ],
//                           //                   ),
//                           //                   SizedBox(
//                           //                     height: 10.h,
//                           //                   ),
//                           //                   Text(snapShot.data
//                           //                       ?.notifications![index]
//                           //                       .message ?? '',
//                           //                     textAlign: TextAlign.start,
//                           //                     style: cairoRegular.copyWith(
//                           //                         fontSize: 14,
//                           //                         color: greyColor),)
//                           //                   // Text(
//                           //                   //   notificationCubit
//                           //                   //       .getNotificationModel
//                           //                   //       .notifications![index]
//                           //                   //       .message!,
//                           //                   //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                           //                   //   textAlign: TextAlign.start,
//                           //                   // ),
//                           //                   // Text(
//                           //                   //   notificationCubit
//                           //                   //       .getNotificationModel
//                           //                   //       .notifications![index]
//                           //                   //       .message!,
//                           //                   //   style: cairoRegular.copyWith(fontSize: 14,color: greyColor),
//                           //                   //   textAlign: TextAlign.start,
//                           //                   // ),
//                           //                 ],
//                           //               ),
//                           //             ),
//                           //           );
//                           //         },
//                           //         separatorBuilder: (context, index) {
//                           //           return Divider(
//                           //             height: 1,
//                           //             thickness: 2,
//                           //             endIndent: 8.w,
//                           //             indent: 8.w,
//                           //           );
//                           //         },
//                           //         itemCount: snapShot.data!.notifications!
//                           //             .length,
//                           //         // itemCount: notificationCubit
//                           //         //     .getNotificationModel
//                           //         //     .notifications!
//                           //         //     .length
//                           //       ),
//                           //     )
//                           //   ],
//                           // );
//
//                         }
//                       ),
//                     )
//               : Center(
//                   child: CircularProgressIndicator.adaptive(
//                     backgroundColor: orangeColor,
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       darkMainColor, //<-- SEE HERE
//                     ),
//                   ),
//                 );
//         });
//     //);
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morshed/bloc/notification_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import '../../bloc/notification_cubit/cubit.dart';
import '../../constant/text_theme.dart';
import '../../tranlations/locale_keys.g.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notificationCubit = NotificationCubit.get(context);
    return BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        bloc: notificationCubit.getNotificationData(),
        builder: (context, state) {
          return notificationCubit.isNotificationGet
              ? notificationCubit.getNotificationModel.notifications!.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/notifications.svg'),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(
                  LocaleKeys.no_notifications.tr(),
                  style: cairoMedium.copyWith(fontSize: 20),
                ),
              )
            ],
          )
              : Scaffold(
            body: Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  child: Container(
                    height: 148.h,
                    padding: EdgeInsetsDirectional.only(top: 30.h),
                    child: Center(
                        child: Text(
                          LocaleKeys.notifications.tr(),
                          style:
                          cairoBold.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                //Divider(),
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(top: 10.h),
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                            notificationCubit.getNotificationModel
                                .notifications![index].createdAt!);
                        String date =
                            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                        String time =
                            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                        return GestureDetector(
                          onTap: () {
                            notificationCubit.markNotificationAsRead(
                                id: notificationCubit
                                    .getNotificationModel
                                    .notifications![index]
                                    .id!);
                            //notificationCubit.getNotificationData();
                          },
                          child: Container(
                            color: notificationCubit
                                .getNotificationModel
                                .notifications![index]
                                .read ==
                                true
                                ? whiteColor
                                : whiteGreyColor.withOpacity(0.1),
                            padding: EdgeInsetsDirectional.only(
                                start: 20.w, top: 0, bottom: 0),
                            height: 86.5.h,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/notifications.svg',
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      notificationCubit
                                          .getNotificationModel
                                          .notifications![index]
                                          .title!,
                                      style: cairoBold.copyWith(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    Text(
                                      date,
                                      style: cairoRegular.copyWith(color: whiteGreyColor,fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  notificationCubit
                                      .getNotificationModel
                                      .notifications![index]
                                      .message!,
                                  style:cairoRegular.copyWith(fontSize: 14,color: greyColor),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                          thickness: 2,
                          endIndent: 8.w,
                          indent: 8.w,
                        );
                      },
                      itemCount: notificationCubit
                          .getNotificationModel
                          .notifications!
                          .length),
                )
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: orangeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                darkMainColor, //<-- SEE HERE
              ),
            ),
          );
        });
    //);
  }
}

