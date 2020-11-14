import 'dart:ui';
import 'package:flutter/material.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBar appbar=AppBar(title: Text('About'),
      centerTitle: true,
      );
    final MediaQueryData mediaquery=MediaQuery.of(context);
    final isLandScape=mediaquery.orientation==Orientation.landscape;
    return Scaffold(
      appBar: appbar,
      body: Column(children: [
        Container(
          height: (mediaquery.size.height-mediaquery.padding.top-appbar.preferredSize.height)*0.08,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline,color: Colors.teal.shade900,),
                  Text('About Application',style: TextStyle(fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline),),
                ],
              ),
        ),
        Container(
          height: (mediaquery.size.height-mediaquery.padding.top-appbar.preferredSize.height)*0.42,
          padding: EdgeInsets.all(8),
          child: ListView(
            children:[
            isLandScape ? Center(child: Text('Scroll Down',style: TextStyle(backgroundColor: Colors.black,color: Colors.white),),) : Text(''),
            Text('\u2022'+' This is a Mobile Utility Application.'),
            Text('\u2022 This makes users to add their daily Expenses.'),
            Text('\u2022 You could find the following features in this Application :- '),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text('\u2022 Adding Large Number of Transactions.'),
              Text('\u2022 Saving These Transactions in Memory.'),
              FittedBox(child: Text('(Path- storage/emulated/0/Spending-Logs-Tracker-Expenses/Data/Logs.txt)'),),
              Text('\u2022 Filter The Transactions (Beta-Version).'),
              Text('\u2022 Details Of The Transaction You Made. '),
              Text('(By Simply Tapping On The Transaction)'),
            ],
            ),
            Text('\u2022 Application Version- 1.0.0',style: TextStyle(fontWeight: FontWeight.bold),),
            Center(
              child: Text('If You Found Any Bugs Then Feel Free To Contact',
              style: TextStyle(fontStyle: FontStyle.italic,color: Colors.red,),),
            ),
            Center(child: Text('THANK YOU',style: TextStyle(color: Colors.pink),),),
          ],),
        ),
                   Container(
                     height: (mediaquery.size.height-mediaquery.padding.top-appbar.preferredSize.height)*0.1,
                     child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_box,color: Colors.purple.shade700,),
                Text('About Developer',style: TextStyle(fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),),
              ],
            ),
                   ),
        Container(
          height: (mediaquery.size.height-mediaquery.padding.top-appbar.preferredSize.height)*0.4,
          padding: EdgeInsets.all(5),
          child: ListView(children: [
            Row(children: [
              Icon(Icons.account_circle,color: Colors.yellow.shade900,),
              Text('Name : ',style: TextStyle(fontWeight: FontWeight.w900),),
              Text('SIDHARTH PARTH SARATHI',style: TextStyle(fontWeight: FontWeight.w500),),
            ],),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            Icon(Icons.mail,color: Colors.red.shade800,),
                Text('E-Mail : ',style: TextStyle(fontWeight: FontWeight.w900),),
                Text('sidharthparthsarathi051@gmail.com',style: TextStyle(fontWeight: FontWeight.w500),),
              ],),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            Icon(Icons.phone,color: Colors.green.shade700,),
                Text('Contact No : ',style: TextStyle(fontWeight: FontWeight.w900),),
                Text('+91-7894541080',style: TextStyle(fontWeight: FontWeight.w500),),
              ],),
            ),
          ],
          ),
        ),
      ],
      ),
    );
  }
}