import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.onSubmit});
  final void Function(String title, double value, DateTime dateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _valueController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _titleController = TextEditingController();
    _valueController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onDateChanged(DateTime value) {
    setState(() => _selectedDate = value);
  }

  void _submitForm() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
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
            AdaptativeTextField(
              autofocus: true,
              controller: _titleController,
              textInputAction: TextInputAction.next,
              label: 'Titulo',
            ),
            const SizedBox(height: 10),
            AdaptativeTextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              label: 'Valor (R\$)',
              onSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(height: 20),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: 20),
            AdaptativeButton(label: "Nova Transação", onPressed: _submitForm)
          ],
        ),
      ),
    );
  }
}
