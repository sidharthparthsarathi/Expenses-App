import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactions
  {
    return List.generate(7, (index){
      final weekday=DateTime.now().subtract(Duration(days: index),);
      double totalSum=0.0;
      for(var i=0;i<recentTransactions.length;i++/*i=i+1*/){
        if(recentTransactions[i].date.day==weekday.day &&
        recentTransactions[i].date.month==weekday.month &&
        recentTransactions[i].date.year==weekday.year
        )
        totalSum+=recentTransactions[i].amount;
      }
      //print(DateFormat.E().format(weekday).toString()+totalSum.toString());
      return {'day': DateFormat.E().format(weekday).substring(0,3),//substring method
       'amount': totalSum};
    }).reversed.toList();
  }
  double get totalSpending{
    return groupedTransactions.fold(0.0, (sum, item){
      return sum + item['amount'];
      });//we will get error if we restart the app
  }
  @override
  Widget build(BuildContext context) {
    //print('Build() Chart');
    //print(groupedTransactions);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
              Colors.blueGrey.shade900,
              Colors.pink.shade800,
              Colors.teal.shade900,
            ],
            ),
          ),
          alignment: Alignment.center,
          child: Text('Chart For Last Week\'s Transactions',
          style: TextStyle(
            color: Color.fromRGBO(110, 230, 110, 0.8),
            fontWeight: FontWeight.w400,
          ),
          ),
          ),
        Expanded(
              child: Card(elevation: 6,
          margin: const EdgeInsets.all(10),//using const to avoid performance drop
          child: Padding(padding: const EdgeInsets.all(10),//Padding is simple container with only padding//using const to avoid performance drop
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [...groupedTransactions.map((tx){
                return Flexible(fit: FlexFit.tight,
                            child: ChartBar(tx['day'], tx['amount'],
                  totalSpending == 0.0 ? 0.0 : (tx['amount'] as double)/totalSpending,
                  ),
                )/*Text('${tx['day']}: ${tx['amount']} ')*/;
              }).toList(),
              ],
              ),
          ),
          ),
        ),
      ],
    );
  }
}