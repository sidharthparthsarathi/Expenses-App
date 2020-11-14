import 'dart:math';
import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import '../widgets/Date.dart';
import 'transaction-details-screen.dart';
class TransactionItem extends StatefulWidget {
   final Transaction transaction;
  final Function deleteTransaction;
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color bgColor;
  @override
  void initState() {
    const availableColors=[Colors.blueGrey,Colors.brown];
    bgColor=availableColors[Random().nextInt(2)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.transaction.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(6),
           margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        ),
          child: InkWell(
            splashColor: Colors.blue.shade900,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionDetails(
              widget.transaction.title,
              widget.transaction.id,
              widget.transaction.date,
              widget.transaction.amount,
              )
            ),
            ),
                      child: Card(elevation: 8,
                            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),//using const to avoid performance drop
                            child: ListTile(leading: CircleAvatar(backgroundColor: bgColor,
                              radius: 30,child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(child: Text('\₹${widget.transaction.amount}',style: TextStyle(
                                color: Color.fromRGBO(10, 10, 100, 0.8),
                                fontWeight: FontWeight.bold,
                              ),),
                              ),
                              ),
                              ),
                              title: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text('${widget.transaction.title}',
                                style: TextStyle(
                                  color: Color.fromRGBO(10, 5, 100, 0.9),
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                              subtitle: ADate(widget.transaction.date),
                              trailing: MediaQuery.of(context).size.width > 480 ? FlatButton.icon(onPressed: () => widget.deleteTransaction(widget.transaction.id),
                              icon: Icon(Icons.delete),
                              label: const Text('Delete'),//using const to avoid performance drop
                              textColor: Theme.of(context).errorColor)
                              : IconButton(
                                icon: Icon(
                                  Icons.delete),
                                   onPressed: () => widget.deleteTransaction(
                                     widget.transaction.id),
                                     color: Theme.of(context).errorColor,
                                     ),
        ),
      ),
          ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        widget.deleteTransaction(widget.transaction.id);
      },
    );
  }
}