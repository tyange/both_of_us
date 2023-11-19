import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:both_of_us/models/user_info.dart';
import 'package:both_of_us/providers/user_info.dart';
import 'package:both_of_us/screens/edit.dart';
import 'package:both_of_us/screens/intro.dart';
import 'package:both_of_us/widgets/anniversary_card.dart';

import 'package:both_of_us/models/anniversary.dart';

const Map<String, int> anniversaryInterval = {
  "hundred": 100,
  "year": 365,
};

const double extent = 120.0;

const int firstDayColorHex = 0xffFBF0B2;
const int currentDayColorHex = 0xffFFC7EA;
const int yearAnniversaryColorHex = 0xffD8B4F8;
const int hundredAnniversaryColorHex = 0xffCAEDFF;
const int actionButtonColorHex = 0xffF1EFEF;

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({
    super.key,
    this.meName,
    this.loverName,
    this.firstDay,
  });

  final String? meName;
  final String? loverName;
  final DateTime? firstDay;

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  late FixedExtentScrollController controller;

  UserInfo? _userInfo;
  List<Anniversary> _allAnniversaries = [];
  DateTime? _targetDate;

  DateTime get nowDate {
    return DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  bool _isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Set<DateTime> _getAnniversaries(
      DateTime beforeDate, DateTime firstDay, int interval) {
    List<DateTime> anniversariesDate = [];

    DateTime targetAnniversaryDate = firstDay;

    while (targetAnniversaryDate.isBefore(beforeDate)) {
      anniversariesDate.add(targetAnniversaryDate);

      targetAnniversaryDate = targetAnniversaryDate.add(
        Duration(
          days: interval == 365 && _isLeapYear(targetAnniversaryDate.year + 1)
              ? interval + 1
              : interval,
        ),
      );
    }

    anniversariesDate.add(nowDate);

    return Set.from(anniversariesDate);
  }

  String _displayDays(DateTime anniversaryDate, DateTime firstDay) {
    int days = anniversaryDate.difference(firstDay).inDays;

    if (days == 0) {
      return '첫날';
    }

    bool isYearAnniversary = anniversaryDate.month == firstDay.month &&
        anniversaryDate.day == firstDay.day;

    if (isYearAnniversary) {
      final years = anniversaryDate.year - firstDay.year;

      return '$years주년';
    }

    return '$days일';
  }

  List<Anniversary> _getAnniversaryList(DateTime targetDate) {
    final firstDay = widget.firstDay ?? _userInfo!.firstDay!;

    Set<DateTime> hundredAnniversaries = _getAnniversaries(
        targetDate == firstDay
            ? targetDate.add(const Duration(days: 365))
            : targetDate,
        firstDay,
        anniversaryInterval['hundred']!);
    Set<DateTime> yearAnniversaries = _getAnniversaries(
        targetDate == firstDay
            ? targetDate.add(const Duration(days: 365))
            : targetDate,
        firstDay,
        anniversaryInterval['year']!);

    List<DateTime> calculatedAnniversariesDate =
        yearAnniversaries.union(hundredAnniversaries).toList();

    List<Anniversary> anniversaries = [];

    for (DateTime anniversaryDate in calculatedAnniversariesDate) {
      anniversaries.add(
        Anniversary(
          date: anniversaryDate,
          displayTitle: _displayDays(anniversaryDate, firstDay),
          bgColor: const Color(0xffFFFBF5),
        ),
      );
    }

    anniversaries.sort((a, b) => a.date.compareTo(b.date));

    return anniversaries;
  }

  void _onSelectedItemChangedHandler() {
    List<Anniversary> futureAnniversaries = _getAnniversaryList(_targetDate!);

    _targetDate =
        DateTime(_targetDate!.year + 1, _targetDate!.month, _targetDate!.day);

    setState(() {
      _allAnniversaries = [...futureAnniversaries];
    });
  }

  void _jumpToFirstDay() {
    controller.animateTo(
      0,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.linear,
    );
  }

  void _jumpToCurrentDay() {
    int currentDayAnniversaryIndex =
        _allAnniversaries.indexWhere((element) => element.date == nowDate);

    if (currentDayAnniversaryIndex == -1) {
      return;
    }

    controller.animateTo(
      currentDayAnniversaryIndex * extent,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.linear,
    );
  }

  void _clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }

  void _navigateIntroScreen() {
    ref.read(userInfoProvider.notifier).resetUserInfo();
    _clearPrefs();

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const IntroScreen(),
      ),
    );
  }

  void _navigateToEditScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditScreen(
          meName: widget.meName ?? _userInfo!.meName!,
          loverName: widget.loverName ?? _userInfo!.loverName!,
          firstDay: widget.firstDay ?? _userInfo!.firstDay!,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _userInfo = ref.read(userInfoProvider);

    controller = FixedExtentScrollController();

    List<Anniversary> allAnniversaries = _getAnniversaryList(nowDate);

    final firstDay = widget.firstDay ?? _userInfo!.firstDay!;

    _targetDate = DateTime(
        nowDate == firstDay ? nowDate.year + 2 : nowDate.year + 1,
        nowDate.month,
        nowDate.day);
    _allAnniversaries = [...allAnniversaries];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 20,
        childPadding: const EdgeInsets.all(8),
        backgroundColor: const Color(0xffffffff),
        elevation: 5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.restart_alt),
            labelStyle: GoogleFonts.hahmlet(),
            label: '초기화',
            onTap: () {
              _navigateIntroScreen();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.settings_backup_restore),
            labelStyle: GoogleFonts.hahmlet(),
            label: '다시 설정하기',
            onTap: () {
              _navigateToEditScreen();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.first_page_rounded),
            labelStyle: GoogleFonts.hahmlet(),
            label: '1일',
            onTap: () {
              _jumpToFirstDay();
            },
          ),
          SpeedDialChild(
              child: const Icon(Icons.today),
              labelStyle: GoogleFonts.hahmlet(),
              label: '오늘',
              onTap: () {
                _jumpToCurrentDay();
              }),
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.meName ?? _userInfo!.meName!,
                    style: GoogleFonts.hahmlet(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.loverName ?? _userInfo!.loverName!,
                    style: GoogleFonts.hahmlet(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListWheelScrollView(
            onSelectedItemChanged: (value) {
              if (_allAnniversaries.length == value + 1) {
                print('onSelectedItemChanged');
                _onSelectedItemChangedHandler();
              }
            },
            itemExtent: extent,
            squeeze: 0.5,
            physics: const FixedExtentScrollPhysics(),
            controller: controller,
            children: [
              for (final anniversary in _allAnniversaries)
                AnniversaryCard(
                  anniversary: anniversary,
                )
            ],
          ),
        ]),
      ),
    );
  }
}
