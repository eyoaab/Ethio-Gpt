class SettingState {}

final class SettingInitial extends SettingState {}

final class CurrentindexState extends SettingState {
  final int index;
  CurrentindexState(this.index);
}
