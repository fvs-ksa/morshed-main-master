abstract class SettingState {}

class InitialSettingState extends SettingState {}

class SetLanguageARState extends SettingState {}

class SetLanguageENState extends SettingState {}

class DeleteUserLoadingState extends SettingState {}

class DeleteUserSuccessState extends SettingState {}

class DeleteUserErrorState extends SettingState {
  final String error;
  DeleteUserErrorState({required this.error});
}
