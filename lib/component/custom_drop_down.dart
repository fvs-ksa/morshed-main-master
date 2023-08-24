import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/register_cubit/cubit.dart';
import 'package:morshed/bloc/register_cubit/state.dart';

import '../constant/const_color.dart';
import '../constant/text_theme.dart';
import '../tranlations/locale_keys.g.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var registerCubit=RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state){},
      builder: (context,state) {
        return Theme(
          data: ThemeData(
              fontFamily: 'Cairo-regular',
              textTheme:  TextTheme(subtitle1: cairoRegular.copyWith(fontSize: 12.sp,color: greyColor,))
          ),
          child: Container(
            padding: EdgeInsets.zero,
            height: 69.h,
            child: DropdownSearch(
              // validator: (var item) {
              //   if (item == null){
              //     return "من فضلك قم بأختيار جنسيتك";
              //   }
              //   return null;
              // },
              popupProps: PopupProps.menu(

                  searchFieldProps: TextFieldProps(

                    enableSuggestions: true,
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: darkMainColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: darkMainColor),
                      ),
                    ),
                    style: cairoRegular.copyWith(color: greyColor,) ,
                  ),
                  showSearchBox: true
              ),
              dropdownButtonProps: DropdownButtonProps(color: greyColor),
              items: registerCubit.nationalityModel.data!.map((e) => e.name).toList(growable: true),
              dropdownDecoratorProps:  DropDownDecoratorProps(
                baseStyle: cairoSemiBold.copyWith(color: blackColor,fontSize: 13.sp,),
                dropdownSearchDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkMainColor),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkMainColor),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    helperStyle: cairoRegular.copyWith(color: greyColor,),
                    fillColor: Colors.deepOrangeAccent,
                    labelText: LocaleKeys.nationality.tr(),
                    hintText: "",
                    labelStyle: cairoRegular.copyWith(color: greyColor,)
                ),
              ),

              onChanged: (onChange){
                registerCubit.onChangeNationalityName(onChange);
                print(onChange);
              },
              selectedItem: registerCubit.chooseNationality,
            ),
          ),
        );
      }
    );
  }
}
