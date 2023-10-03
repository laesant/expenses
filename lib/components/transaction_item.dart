import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.onRemove,
    required this.transaction,
  });

  final void Function(String p1) onRemove;
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                    "R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}"),
              ),
            )),
        title: Text(transaction.title,
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          DateFormat.yMMMd('pt').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? ElevatedButton.icon(
                onPressed: () => onRemove(transaction.id),
                icon: const Icon(Icons.delete),
                label: Text(
                  "Excluir",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ))
            : IconButton(
                color: Theme.of(context).colorScheme.error,
                onPressed: () => onRemove(transaction.id),
                icon: const Icon(Icons.delete)),
      ),
    );
  }
}