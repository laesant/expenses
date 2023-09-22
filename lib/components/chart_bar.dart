import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final String label;
  final double value;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20,
            child: FittedBox(
                child: Text(value.toStringAsFixed(2).replaceAll('.', ',')))),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: 60 * percentage,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label.toUpperCase())
      ],
    );
  }
}
