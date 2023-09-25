import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker(
      {super.key, required this.selectedDate, required this.onDateChanged});

  final DateTime selectedDate;
  final void Function(DateTime) onDateChanged;

  void _showDatePicker(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      onDateChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2019),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Data selecionada: ${DateFormat.yMd('pt').format(selectedDate)}"),
              ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text("Selecionar Data"))
            ],
          );
  }
}
