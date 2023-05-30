import 'package:fast_ui_kit/extension/context.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class FastCalendar extends StatefulWidget {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialSelectedFirstDate;
  final DateTime? initialSelectedLastDate;
  final BoxDecoration? decoration;
  final bool rangeMode;
  final double maxHeight;
  final double maxWidth;
  final String? locale;
  final void Function(DateTime?, DateTime?)? onRangeSelected;

  const FastCalendar({
    super.key,
    this.firstDate,
    this.lastDate,
    this.rangeMode = false,
    this.maxHeight = 400,
    this.maxWidth = 400,
    this.locale,
    this.decoration,
    this.initialSelectedFirstDate,
    this.initialSelectedLastDate,
    this.onRangeSelected,
  });

  @override
  State<FastCalendar> createState() => _FastCalendarState();
}

class _FastCalendarState extends State<FastCalendar> {
  CleanCalendarController? calendarController;

  void initValues() {
    final old = calendarController;
    old?.dispose();

    calendarController = CleanCalendarController(
      minDate: widget.firstDate ??
          DateTime.now().subtract(const Duration(days: 365)),
      maxDate: widget.lastDate ?? DateTime.now().add(const Duration(days: 365)),
      rangeMode: widget.rangeMode,
      onRangeSelected: widget.onRangeSelected,
      initialDateSelected: widget.initialSelectedFirstDate,
      endDateSelected: widget.initialSelectedLastDate,
      initialFocusDate: DateTime.now(),
    );
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FastCalendar oldWidget) {
    initValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    calendarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
        maxWidth: widget.maxWidth,
      ),
      decoration: widget.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: context.colors.primary,
              width: 2,
            ),
          ),
      child: ScrollableCleanCalendar(
        calendarController: calendarController!,
        layout: Layout.BEAUTY,
        calendarCrossAxisSpacing: 0,
        calendarMainAxisSpacing: 0,
        locale: widget.locale ?? 'en',
        dayRadius: 100,
      ),
    );
  }
}
