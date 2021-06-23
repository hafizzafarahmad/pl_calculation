import 'package:flutter/material.dart';
import 'package:pl_calculation/core/platform/component.dart';

typedef OnSelectedItem<OpsiDropDown> = void Function(OpsiDropDown item);

class DropDownWidget extends StatefulWidget {
  final initial;
  final List<OpsiDropDown>? opsi;
  final Widget? prefix;
  final OnSelectedItem<OpsiDropDown>? onSelectedItem;

  DropDownWidget({
    @required this.opsi,
    this.initial,
    Key? key,
    @required this.onSelectedItem,
    this.prefix
  }) : super(key: key);

  @override
  _DropDownWidget createState() => _DropDownWidget();
}

class _DropDownWidget extends State<DropDownWidget> {

  List<DropdownMenuItem<String>>? _dropDownOpsi;
  var  _dropOpsi;

  _getListOpsi() async {

    if(widget.initial != null && widget.initial != 'null'){
      _dropOpsi = widget.initial;
    }

    if(widget.opsi != null){
      setState(() {
        _dropDownOpsi =  getDropDownOpsiItems();
      });
    }
  }
  List<DropdownMenuItem<String>> getDropDownOpsiItems() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < widget.opsi!.length; i++) {
      items.add(DropdownMenuItem(value: widget.opsi![i].id.toString(),
          child: Text('${widget.opsi![i].name}')));
    }



    return items;
  }
  void _selectedOpsi(String selected) {
    hideKeyboard(context);
    if (selected != null || selected != '') {
      setState(() {
        var selectedOpsi = OpsiDropDown(
          id: selected,
          name: widget.opsi!.where((element) => element.id == selected).first.name
        );
        _dropOpsi = selected;
        print(selected);
        widget.onSelectedItem!(selectedOpsi);
      });
    }
  }

  @override
  void initState() {
    _getListOpsi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.longestSide,
      height: 55,
      child: Row(
        children: [
          widget.prefix != null ?
          Row(
            children: [
              widget.prefix!,
              SizedBox(width: 12,),
            ],
          ): SizedBox(),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _dropOpsi,
                items: _dropDownOpsi,
                onChanged: (val){
                  _selectedOpsi(val!);
                },
                hint: Text("Pilih Jawaban"),
              ),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
    );
  }

}

class OpsiDropDown {
  String? id;
  String? name;

  OpsiDropDown({this.id, this.name});
}