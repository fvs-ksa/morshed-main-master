import 'package:easy_localization/easy_localization.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/screen/inner_screen/another_services_screens/prayer_time.dart';
import 'package:morshed/screen/inner_screen/another_services_screens/transportation_screen.dart';

import '../component/navigation_functions.dart';
import '../screen/inner_screen/another_services_screens/guides_screens/guides_for_hajji_screen.dart';
import '../screen/inner_screen/another_services_screens/shopping.dart';
import '../tranlations/locale_keys.g.dart';

class AnotherServicesModel {
  String image;
  String title;
  Function fct;

  AnotherServicesModel(
      {required this.title, required this.fct, required this.image});
}

List<AnotherServicesModel> anotherServicesList = [
  AnotherServicesModel(
      title: LocaleKeys.Instructions.tr(),
      fct: () {
        navigateForward(const GuidesForHajjiScreen());
      },
      image: 'assets/images/guides.png'),
  AnotherServicesModel(
      title: LocaleKeys.transports.tr(),
      fct: () {
        navigateForward(const TransportationScreen());
      },
      image: 'assets/images/bus.png'),
  AnotherServicesModel(
      title: LocaleKeys.salah.tr(),
      fct: () {navigateForward(const PrayerTimeScreen());},
      image: 'assets/images/hajj (1).png'),
  AnotherServicesModel(
      title: LocaleKeys.shopping.tr(),
      fct: () {navigateForward(ShoppingScreen());},
      image: 'assets/images/guides.png'),
];
