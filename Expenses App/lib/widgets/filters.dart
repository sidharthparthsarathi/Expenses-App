import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import '../screens/filters-item.dart';
enum DrawerSelection{
  today,
  lastWeek,
  lastMonth,
  yesterday,
}
class Filters extends StatefulWidget {
  static const routeName='/Filters';
  final List<Transaction> transactions;
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  Filters(this.transactions,this.currentFilters,this.saveFilters);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  DrawerSelection drawerSelection=DrawerSelection.yesterday;
  int days=0;
  bool today=false;
  bool lastWeek=false;
  bool lastMonth=false;
  
    List<Transaction> get recentTransactions{
    return widget.transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: days),),);
    }).toList();
  }
  

  Widget buildSwitchList(String title,bool value,Function onpress,bool data)
  {
    return SwitchListTile(
      activeTrackColor: Colors.yellow.shade800,
      activeColor: Colors.green.shade600,
          title: Text(title,
          style: TextStyle(
            //color: Colors.indigoAccent.shade400,
            fontWeight: FontWeight.w500,
            )
            ,),
          onChanged: onpress,
          value: value,
          selected: data,
        );
  }

   @override
  initState(){
    today=widget.currentFilters['Today'];
    lastWeek=widget.currentFilters['LastWeek'];
    lastMonth=widget.currentFilters['LastMonth'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediquery=MediaQuery.of(context);
    final isLandscape=mediquery.orientation == Orientation.landscape;
    final AppBar appbar=AppBar(
      title: FittedBox(child: Text('Filters'),),
      centerTitle: true,
       actions: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.greenAccent.shade200,
                Colors.blue.shade400,
                Colors.red.shade500,
                Colors.orange.shade500,
              ],
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.save,color: Colors.purple.shade900,),
          onPressed: (){
            final selectedFilters={
                'Today': today,
                'LastWeek': lastWeek,
                'LastMonth': lastMonth,
              };
              widget.saveFilters(selectedFilters);
          }),
        )
      ],
      );
    if(today)
    {
      lastWeek=false;
      lastMonth=false;
      days=1;
      drawerSelection=DrawerSelection.today;
    }
    else if(lastWeek)
    {
      today=false;
      lastMonth=false;
      days=7;
      drawerSelection=DrawerSelection.lastWeek;
    }
    else if(lastMonth)
    {
      today=false;
      lastWeek=false;
      days=30;
      drawerSelection=DrawerSelection.lastMonth;
    }
    else if(!today && !lastWeek && !lastMonth){
      today=false;
      lastWeek=false;
      lastMonth=false;
      days=0;
      drawerSelection=DrawerSelection.yesterday;
    }
    return Scaffold(appBar: appbar,
      body: Column(
      children: [
        Container(
          height: (mediquery.size.height-appbar.preferredSize.height-mediquery.padding.top)*(isLandscape ? 0.7 : 0.4),
          child: ListView(children: [
            Center(child: Text('Select Any One',
            style: TextStyle(color: Colors.white,
            backgroundColor: Colors.blue.shade900
            ),
            ),),
        buildSwitchList('Today\'s Transactions', (today && !lastWeek && !lastMonth),
        (h){
            setState(() {
              today=h;
              drawerSelection=DrawerSelection.today;
            });
          },
          drawerSelection==DrawerSelection.today
        ),
        buildSwitchList('Last Week\'s Transactions', (lastWeek && !today && !lastMonth),
        (h){
            setState(() {
              lastWeek=h;
              drawerSelection=DrawerSelection.lastWeek;
            });
          },
          drawerSelection==DrawerSelection.lastWeek
        ),
        buildSwitchList('Last 30 Day\'s Transactions', (lastMonth && !today && !lastWeek),
        (h){
            setState(() {
              lastMonth=h;
              drawerSelection=DrawerSelection.lastMonth;
            });
          },
          drawerSelection==DrawerSelection.lastMonth,
        ),
          ],
        ),
        ),
        Container(
          height: (mediquery.size.height-appbar.preferredSize.height-mediquery.padding.top)*(isLandscape ? 0.3 : 0.6),
          child: widget.transactions.isEmpty ? Text('No Transactions Added Yet',
          style: TextStyle(color: Colors.blue.shade900),)
           : ListView(children: [...recentTransactions.map((e) => FiltersItem(e)).toList(),
          ],
          ),
        ),
      ],
      ),
    );
  }
}