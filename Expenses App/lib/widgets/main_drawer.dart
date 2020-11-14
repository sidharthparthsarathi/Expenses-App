import 'package:Personal_Expenses_App/Models/Transactions.dart';
import 'package:flutter/services.dart';
import '../screens/about-screen.dart';
import 'filters.dart';
import 'package:flutter/material.dart';
enum DrawerSelection{
  home,
  filters,
  about,
}
class MainDrawer extends StatefulWidget {
  final List<Transaction> recentTransactions;
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  MainDrawer(this.recentTransactions,this.currentFilters,this.saveFilters);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  DrawerSelection drawerSelection=DrawerSelection.home;
  Color bgcolor=Colors.white;
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData=MediaQuery.of(context);
    final size=mediaQueryData.size;
    final isLandscape=mediaQueryData.orientation == Orientation.landscape;
    var width=size.width*0.8;
    var cont1height=size.height*0.25;
    //var cont2height=size.height*0.25;
    if(isLandscape)
    {
          width=size.width*0.45;
          cont1height=size.height*0.43;
    }
    return Container(
      color: Colors.blueAccent,
      width: width,
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade600,
                    Colors.blueAccent.shade700,
                    Colors.blue.shade800,
                  ],
                ),
                  border: Border.all(color: Colors.green),
              ),
              height: cont1height,
              alignment: Alignment.center,
              child: /*InkWell(
                onTap: (){
                      //SystemNavigator.pop();
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                splashColor: Colors.green.shade900,
                              child: */Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.power_settings_new), 
                    onPressed: (){
                      //SystemNavigator.pop();
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    ),
                    InkWell(
                      onTap: (){
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child: Text('Close')),
                  ],
                //),
              )
            ),
            Container(
              height: isLandscape ? size.height*0.14 : null,
              child: ListTile(
                selected: drawerSelection==DrawerSelection.home,
                leading: Icon(Icons.home,),
                title: Text('Home'),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/');
                  setState(() {
                    drawerSelection=DrawerSelection.home;
                    bgcolor==Colors.white ? bgcolor=Colors.greenAccent : bgcolor=Colors.white;
                  });
                },
              ),
            ),
            Container(
              height: isLandscape ? size.height*0.16 : null,
              child: ListTile(
                selected: drawerSelection==DrawerSelection.filters,
                leading: Icon(Icons.filter_list,),
                title: Text('Filter'),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Filters(widget.recentTransactions,widget.currentFilters,widget.saveFilters),
                    ),
                    );
                  setState(() {
                    drawerSelection=DrawerSelection.filters;
                  });
                },
              ),
            ),
            Container(
              height: size.height*0.03,
              child: Divider(color: Color.fromRGBO(10, 10, 10, 1),)),
            Container(
              height: isLandscape ? size.height*0.12 : null,
              child: ListTile(
                selected: drawerSelection==DrawerSelection.about,
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: (){
                   Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => About(),),
                  );
                  setState(() {
                    drawerSelection=DrawerSelection.about;
                  });
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}