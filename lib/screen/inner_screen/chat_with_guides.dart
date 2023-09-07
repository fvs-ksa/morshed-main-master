import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/chat_cubit/chat_with_support_cubit/chat_support_state.dart';
import 'package:morshed/constant/text_theme.dart';
import 'package:morshed/screen/inner_screen/vedio_chat/room_vedio_screen.dart';
import '../../bloc/chat_cubit/chat_with_provider/cubit.dart';
import '../../bloc/chat_cubit/chat_with_provider/state.dart';
import '../../bloc/chat_cubit/chat_with_support_cubit/chat_support_cubit.dart';
import '../../component/navigation_functions.dart';
import '../../constant/const_color.dart';
import '../../component/guide_escorts_component.dart';
import '../../tranlations/locale_keys.g.dart';

class ChatWithGuidesScreen extends StatefulWidget {
 final int channelName;
 final String name;
  ChatWithGuidesScreen({required this.channelName,required this.name});
  @override
  State<ChatWithGuidesScreen> createState() => _ChatWithGuidesScreenState();
}

class _ChatWithGuidesScreenState extends State<ChatWithGuidesScreen> {
  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;

  @override
  void initState() {
    super.initState();
    window = WidgetsBinding.instance.window;
    window?.onMetricsChanged = () {
      setState(() {
        final window = this.window;
        if (window != null) {
          _viewInsets = EdgeInsets.fromWindowPadding(
            window.viewInsets,
            window.devicePixelRatio,
          ).add(EdgeInsets.fromWindowPadding(
            window.padding,
            window.devicePixelRatio,
          )) as EdgeInsets;
        }
      });
    };
  }

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var chatWithSupportCubit = ChatWithProvidersCubit.get(context);
    return BlocConsumer<ChatWithProvidersCubit, ChatWithProvidersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: headerOfTechnicalSupport(
                  context: context,
                  title: widget.name,
                  child: [
                    Row(
                      children: [
                        circleAvtarWidget(
                            svgImage: 'assets/svg/end call.svg', fct: () {}),
                        circleAvtarWidget(
                            svgImage: 'assets/svg/video (1).svg', fct: () {
                             // navigateForward(VideoCallScreen(channelName:widget.channelName,));
                            }
                        ),
                      ],
                    )
                  ]),
              backgroundColor: whiteGreyColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        print(chatWithSupportCubit.messages);
                        return  ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Colors.blue,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                                    chatWithSupportCubit.messages[index],
                                    style: cairoSemiBold.copyWith(color: greyColor,fontSize: 14),
                            ),
                          ),
                        );
                        // return Align(
                        //   alignment: AlignmentDirectional.centerStart,
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 5.w, vertical: 3.h),
                        //     decoration: BoxDecoration(
                        //       color: whiteColor,
                        //       borderRadius: BorderRadiusDirectional.only(
                        //         bottomEnd: Radius.circular(15.sp),
                        //         topEnd: Radius.circular(15.sp),
                        //         topStart: Radius.circular(15.sp),
                        //       ),
                        //     ),
                        //     child: Text(
                        //       chatWithSupportCubit.messages[index],
                        //       style: cairoSemiBold.copyWith(color: greyColor,fontSize: 14),
                        //     ),
                        //   ),
                        // );
                      },
                      // separatorBuilder: (context, index) {
                      //   return SizedBox(
                      //     height: 5.h,
                      //   );
                      // },
                      itemCount: chatWithSupportCubit.messages.length),
                ),
              ),
              bottomNavigationBar: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: _viewInsets.bottom,
                    top: 6.h,
                    start: 7.w,
                    end: 7.w,
                  ),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 15.h),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      height: 64.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.sp),
                          color: whiteColor),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                chatWithSupportCubit.arabicTextField(
                                    controller: messageController);
                              },
                              controller: messageController,
                              style: cairoRegular.copyWith(fontSize: 17,color: greyColor),
                              decoration: InputDecoration(
                                  hintText: LocaleKeys.sendMessage.tr(),
                                  focusColor: greyColor,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: whiteColor),
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: whiteColor),
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: whiteColor),
                                    borderRadius: BorderRadius.circular(20.sp),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              messageController.text.isEmpty
                                  ? debugPrint('galal')
                                  : chatWithSupportCubit
                                      .sendTextMessage(messageController.text);
                              messageController.clear();
                            },
                            child: CircleAvatar(
                                child: SvgPicture.asset(
                              'assets/svg/Icon ionic-ios-send.svg',
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
