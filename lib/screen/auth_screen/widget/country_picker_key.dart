import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../../constant/const_color.dart';

class CountryPickedCode extends StatelessWidget {
  String countryKey;

  CountryPickedCode({super.key, required this.countryKey});

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (prints) {
        print('${prints.name}');
        print('${prints.dialCode}');
        countryKey = prints.name ?? '+966';
      },
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'SA',
      alignLeft: true,
      favorite: const ['SA', 'EG'],
      //  countryFilter: const ['IT', 'FR'],
      showFlagDialog: true,
      showFlag: true,
      flagWidth: 20,
      textStyle:
          TextStyle(locale: Locale('ar'), fontSize: 10, color: darkMainColor),
      comparator: (a, b) => b.name!.compareTo(a.name ?? ''),
      //Get the country information relevant to the initial selection
      onInit: (code) =>
          debugPrint("on init ${code?.name} ${code?.dialCode} ${code?.name}"),
    );
  }
}
