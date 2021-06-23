import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

typedef OnFinished<String> = void Function(String item);

  class InputFieldCurrencyWidget extends StatefulWidget {
  const InputFieldCurrencyWidget({this.initial, this.hint = '', this.enabled = true, this.onFinished, this.validator, this.prefix});
  final String? initial;
  final Widget? prefix;
  final hint;
  final bool enabled;
  final OnFinished<String>? onFinished;
  final FormFieldValidator<String>? validator;

  @override
  _InputFieldCurrencyWidget createState() => _InputFieldCurrencyWidget();
}

class _InputFieldCurrencyWidget extends State<InputFieldCurrencyWidget> {

  TextEditingController _inputController = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void initState() {
    if(widget.initial != null && widget.initial != 'null'){
      var val = '${_formatNumber(widget.initial!.replaceAll(',', ''))}';
      _inputController.value = TextEditingValue(
        text: val,
        selection: TextSelection.collapsed(offset: val.length),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      validator: widget.validator,
      enabled: widget.enabled,
      inputFormatters: [
        ThousandsFormatter()
      ],
      onChanged: (val){
        // var formatted = formatterCurrency(val);
        // setState(() {
        widget.onFinished!(val);
        // });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: '${widget.hint}',
      ),
    );
  }
}