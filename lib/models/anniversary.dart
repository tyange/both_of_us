class Anniversary {
  Anniversary({
    required this.date,
    required this.isCurrentDay,
    required this.interval,
  });

  final DateTime date;
  bool isCurrentDay;
  final int interval;
}
