import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/utils/strings.dart';
import 'package:sahaj_dhan/core/widgets/button.dart';

class FilterDrawer extends StatefulWidget {
  final Function({
    required bool isHistorical,
    bool? profitOnly,
    bool? highest,
    bool? tradeMonthWise,
  }) onApplyTap;
  final bool openPositions;
  final bool? profitOnly;
  final bool? highest;
  final bool? monthwiseTrade;
  const FilterDrawer({
    super.key,
    required this.onApplyTap,
    required this.openPositions,
    this.profitOnly,
    this.highest,
    this.monthwiseTrade,
  });

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool openPositions = false;
  bool? profitOnly;
  bool? highest;
  bool? monthwiseTrade;

  bool isApplyFilteredTap = false;

  @override
  void initState() {
    openPositions = widget.openPositions;
    profitOnly = widget.profitOnly;
    highest = widget.highest;
    monthwiseTrade = widget.monthwiseTrade;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              "Filters and Sort Options",
              style: CustomTextTheme.text16Bold,
            ),
            SizedBox(height: 24.h),
            ListTile(
              title: Text(
                "Show Open Positions",
                style: CustomTextTheme.text14,
              ),
              trailing: Switch.adaptive(
                value: openPositions,
                onChanged: (value) {
                  setState(() {
                    openPositions = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                "Capital Gain Type",
                style: CustomTextTheme.text14,
              ),
              trailing: DropdownButton<bool?>(
                value: profitOnly,
                hint: Text(
                  "None",
                  style: CustomTextTheme.text14,
                ),
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      "Profit",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      "loss",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: null,
                    child: Text(
                      "None",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    profitOnly = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                "Sort Gains",
                style: CustomTextTheme.text14,
              ),
              trailing: DropdownButton<bool?>(
                value: highest,
                hint: Text(
                  "None",
                  style: CustomTextTheme.text14,
                ),
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      "Highest First",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      "Lowest First",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: null,
                    child: Text(
                      "None",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    highest = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                "Traded on",
                style: CustomTextTheme.text14,
              ),
              trailing: DropdownButton<bool?>(
                value: monthwiseTrade,
                hint: Text(
                  "None",
                  style: CustomTextTheme.text14,
                ),
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      "Month-wise",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      "Overall",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                  DropdownMenuItem(
                    value: null,
                    child: Text(
                      "None",
                      style: CustomTextTheme.text14,
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    monthwiseTrade = value;
                  });
                },
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              width: double.infinity,
              child: Button(
                onTap: () {
                  widget.onApplyTap(
                    isHistorical: openPositions,
                    highest: highest,
                    profitOnly: profitOnly,
                    tradeMonthWise: monthwiseTrade,
                  );
                  isApplyFilteredTap = true;
                  Navigator.of(context).pop();
                },
                title: Strings.apply,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (isApplyFilteredTap == false) {
      widget.onApplyTap(
        isHistorical: openPositions,
        highest: highest,
        profitOnly: profitOnly,
        tradeMonthWise: monthwiseTrade,
      );
    }
    super.dispose();
  }
}
