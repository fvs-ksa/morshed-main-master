import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/chat_cubit/chat_with_provider/state.dart';

class ChatWithProvidersCubit extends Cubit<ChatWithProvidersState>{
  ChatWithProvidersCubit():super(InitialChatWithProviderState());
 static ChatWithProvidersCubit get(context)=>BlocProvider.of(context);
  List<String> messages = [];

  sendTextMessage(String message) {
    messages.add(message);
    emit(SendTextMessageState());
    print(messages);
  }

  void arabicTextField({required TextEditingController controller}) {
    if (controller.selection ==
        TextSelection.fromPosition(
            TextPosition(offset: controller.text.length - 1))) {
      // setState(() {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      // });
      emit(ArabicTextFieldAuthState());
    }
  }

  EdgeInsets viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;

  viewAboveKeyBoard(){
    window = WidgetsBinding.instance.window;
    window?.onMetricsChanged = () {
      final window = this.window;
      if (window != null) {
        viewInsets = EdgeInsets.fromWindowPadding(
          window.viewInsets,
          window.devicePixelRatio,
        ).add(EdgeInsets.fromWindowPadding(
          window.padding,
          window.devicePixelRatio,
        )) as EdgeInsets;
      }
      emit(ChangeKeyBoardViewState());
    };
  }


}