import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.onRemove,
    required this.transaction,
  });

  final void Function(String p1) onRemove;
  final Transaction transaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final colors = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.amber,
  ];

  late final Color _backgroundColor;

  @override
  void initState() {
    int index = Random().nextInt(5);
    _backgroundColor = colors[index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _backgroundColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                    "R\$ ${widget.transaction.value.toStringAsFixed(2).replaceAll('.', ',')}"),
              ),
            )),
        title: Text(widget.transaction.title,
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          DateFormat.yMMMd('pt').format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? ElevatedButton.icon(
                onPressed: () => widget.onRemove(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: Text(
                  "Excluir",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ))
            : IconButton(
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.onRemove(widget.transaction.id),
                icon: const Icon(Icons.delete)),
      ),
    );
  }
}
