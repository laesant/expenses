import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.onSubmit});
  final void Function(String title, double value, DateTime dateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime? _selectedDate;

  void _submitForm() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(title, value, _selectedDate!);
  }

  void _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() => _selectedDate = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? "Nenhuma data selecionada!"
                    : "Data selecionada: ${DateFormat.yMd('pt').format(_selectedDate!)}"),
                ElevatedButton(
                    onPressed: _showDatePicker,
                    child: const Text("Selecionar Data"))
              ],
            ),
            const SizedBox(height: 20),
            AdaptativeButton(label: "Nova Transação", onPressed: _submitForm)
          ],
        ),
      ),
    );
  }
}
