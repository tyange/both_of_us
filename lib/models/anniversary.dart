class Anniversary {
  Anniversary({
    required this.date,
    required this.isFirstDay,
    required this.isCurrentDay,
    required this.isYearAnniversary,
  });

  final DateTime date;
  bool isFirstDay;
  bool isCurrentDay;
  bool isYearAnniversary;
}
