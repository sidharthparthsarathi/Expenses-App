import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionDetails extends StatelessWidget {
  final String title;
  final String id;
  final DateTime date;
  final double amount;
  TransactionDetails(
    this.title,
    this.id,
    this.date,
    this.amount
    );
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime=DateTime.parse(id);
    final String day=DateFormat("EEEE").format(dateTime);
    final String date1=DateFormat.yMMMMd().format(dateTime);
    final String time=DateFormat("jms").format(dateTime);
    final String day1=DateFormat("EEEE").format(date);
    final String date2=DateFormat.yMMMMd().format(date);
    final AppBar appbar=AppBar(title: Text('Transaction Details'),
      centerTitle: true,
      );
    final MediaQueryData mediaquery=MediaQuery.of(context);
    final height=mediaquery.size.height-mediaquery.padding.top-appbar.preferredSize.height;
    final width=mediaquery.size.width;
     final isLandscape=mediaquery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(height: height*0.02),
          Container(
            height: isLandscape ? height*0.15 : height*0.08,
            child: Column(
              children: [
                Text("Transaction Name",
                style: TextStyle(
                  backgroundColor: Colors.black87,
                  color: Colors.blue.shade500,
                ),
                ),
                Container(
                  width: isLandscape ? width*0.8 : width*0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                            child: Text(title),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: isLandscape ? height*0.09 : height*0.05,
            child: Center(
            child: Text(
              "Transaction Added Date(Details)",
              textAlign: TextAlign.center,
              style: 
              TextStyle(
                color: Colors.blue.shade400,
                backgroundColor: Colors.black87,
              ),
              ),
          ),
            ),
          Container(height: isLandscape ? height*0.2 : height*0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Text("Day - "+day),
                        Text("Date - "+date1),
                        Text("Time - "+time),
                      ],
                    ),
                  ),
            SizedBox(height: isLandscape ? height*0.0001 : height*0.015,),
            Container(
              height: isLandscape ? height*0.1 : height*0.05,
              child: Center(
                child: Text(
                  "Transaction Date(Chosen Date)",
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    backgroundColor: Colors.black87,
                  ),
                ),
              ),
            ),
            Container(
              height: isLandscape ? height*0.14 : height*0.09,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Text("Day - "+day1),
                        Text("Date - "+date2),
                      ],
                    ),
                  ),
                  SizedBox(height: isLandscape ? height*0.02 : height*0.001,),
                  Container(
                    height: isLandscape ? height*0.1 : height*0.04,
              child: Center(
                child: Text(
                  "Money Spent(₹)",
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    backgroundColor: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(height: isLandscape ? height*0.02 : height*0.01,),
            Container(
              height: height*0.15,
              width: isLandscape ? width*0.8 : width*1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                              Container(
                                child: Text("Amount in Rs.(₹) - ")),
                              Container(
                                width: isLandscape ? width*0.40 : width*0.55,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text("$amount"),
                                ),
                              ),
                      ],
                    ),
                  ),
            ],
          ),
      ),
    );
  }
}