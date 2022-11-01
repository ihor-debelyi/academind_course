extension DateOnlyCompare on DateTime {
  bool isSameDateAs(DateTime otherDate) {
    return year == otherDate.year &&
        month == otherDate.month &&
        day == otherDate.day;
  }
}
