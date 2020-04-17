import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(
    this.addTx,
  );

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(amountController==null)
      {
        return;
      }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 ||_selectedDate==null)
      return;
    widget.addTx(
        enteredTitle,
        enteredAmount,
      _selectedDate
     );
    Navigator.of(context).pop();
  }
  void _datePicker( ){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
         firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectedDate=pickedDate;
      });

    });
    print('>>>>>>>');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right:10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title:',
                ),
                controller: titleController,
                onChanged: (value) {
                  //titleInput=value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
                //onChanged: (value){
                //amountInput=value;},
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                            _selectedDate==null ?
                            'no date choosen':
                            DateFormat.yMd().format(_selectedDate)
                        )
                    ),
                    FlatButton(
                        color: Colors.purple,
                        onPressed:_datePicker,
                        child: Text(
                          'choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              FlatButton(
                  color: Colors.purple,
                  onPressed: _submitData,
                  child: Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
