import 'package:both_of_us/models/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoNotifier extends StateNotifier<UserInfo> {
  UserInfoNotifier()
      : super(
          UserInfo(
            meName: null,
            loverName: null,
            firstDay: null,
          ),
        );

  void setMeName(String name) {
    var userInfo = state;
    userInfo.meName = name;
    state = userInfo;
  }

  void setLoverName(String name) {
    var userInfo = state;
    userInfo.loverName = name;
    state = userInfo;
  }

  void setFirstDay(DateTime date) {
    var userInfo = state;
    userInfo.firstDay = date;
    state = userInfo;
  }
}

final userInfoProvider = StateNotifierProvider<UserInfoNotifier, UserInfo>(
  (ref) => UserInfoNotifier(),
);
