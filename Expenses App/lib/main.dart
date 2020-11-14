import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './widgets/New_Transactions.dart';
import './widgets/TransactionsList.dart';
import './Models/Transactions.dart';
import './widgets/chart.dart';
import 'widgets/main_drawer.dart';
import 'dart:math';
import './storage/storage-logs.dart';
void main()
{
  runApp(MyAppState());
}


class MyAppState extends StatefulWidget {
  @override
  _MyAppStateState createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  Color bgColor;

  @override
  void initState() {
    const availableColors=[Colors.blueGrey,Colors.brown,Colors.green,Colors.blue,Colors.red,Colors.orange,Colors.black,Colors.pink];
    bgColor=availableColors[Random().nextInt(8)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.blue[700],
      primaryColor: Colors.blue,
      appBarTheme: AppBarTheme/*only works for appbar*/(textTheme: ThemeData.light()/*set of Defaults*/.textTheme/*access TextTheme*/.copyWith(
        headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
        ), 
      )/*Copy with our own setting*/,//to set the title of every appbar to this global font.
      color: bgColor),
      fontFamily: 'QuickSand',//you can write 'quicksand' also which is valis but 'quick sand' is not valid because space is not valid
      textTheme: /*global fontfamily*/ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
        button: TextStyle(color: Colors.white,),
      )
    ),
    darkTheme: ThemeData.dark(),
    initialRoute: '/',
      routes: {
        '/': (ctx) => MyApp(),
      },
    );
  }
}




class MyApp extends StatefulWidget {//converted stateless to stateful widget
  @override
  _MyAppState createState() => _MyAppState();
}




class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static String encode=Transaction.encodeTransactions([]);//Converted The Lists into String format in Transactions.dart
  static String data;
  Map<String, bool> filters={
    'Today': false,
    'LastWeek': false,
    'LastMonth': false,
  };
 
  List<Transaction> transaction=Transaction.decodeTransactions(encode);//Transaction List Declaration

  bool showChart=false;

  List<Transaction> get recentTransactions{
    return transaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }




  void _addNewTransaction(String txTitle,double txAmount,DateTime chosenDate)
  {
    final newTx=Transaction(title: txTitle,amount: txAmount,date: chosenDate/*DateTime.now()*/,id: DateTime.now().toString(),);
    setState(() {
      transaction.add(newTx);
      data=Transaction.encodeTransactions(transaction);
      writeContent(data);
    });
  }



  void startNewTransaction(BuildContext hellctc)
  {
    showModalBottomSheet(context: hellctc, builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransactions(_addNewTransaction),
        behavior: HitTestBehavior.opaque,);
    },
    );
  }


  void deleteTransaction(String id)//Delete Transac
  {
    setState(() {
          transaction.removeWhere((tx) => tx.id==id);
          data=Transaction.encodeTransactions(transaction);
          deleteContent(data);
    });
  }


  List<Widget> buildPortrait(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget){//Portrait Mode
    return [Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.3,
        child: Chart(recentTransactions)),
        txListWidget];
  }


  List<Widget> buildLandscape(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget)//Landscpe Mode
  {
    return [Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.13,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Chart', style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w700,fontSize: 16)),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: showChart,
                onChanged: (val)
              {
                setState(() {
                   showChart=val;
                });
              }),
            ],),
        ),
        showChart ? Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.6,
        child: Chart(recentTransactions),
        )
        : txListWidget];
  }



  Widget buildAppBar(String appBarTitle)//In Case of Error Use PreferredSizeWidget Instead of Widget//Another Solution
  {
    return Platform.isIOS ? CupertinoNavigationBar(//Ignore For Android
      middle: FittedBox(child: Text(appBarTitle)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          child: const Icon(CupertinoIcons.add),//using const to avoid performance drop
          onTap: () => startNewTransaction(context),),
      ],),
    )
    : AppBar(centerTitle: true,
    title: FittedBox(child: Text(appBarTitle)),
    actions: [
        IconButton(
          icon: const Icon(Icons.add),//using const to avoid performance drop
          onPressed: () => startNewTransaction(context),//startNewTransaction(context),
          color: Colors.indigo,
          ),
          ],
    );
  }

  void setFilters(Map<String,bool> filtersData){
    setState(() {
      filters=filtersData;
    });
  }

  @override
  void initState() {
        WidgetsBinding.instance.addObserver(this);
    super.initState();
    //writeContent();
    readContent().then((String value) {
      setState(() {
        data = value;
        transaction=Transaction.decodeTransactions(data);
        print('This Is My String'+data+'In Set State Line-242');
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    //print('build() MyHomePageState');
    print(data);
    final appBarTitle='SPENDING LOGS';
    final mediaQuery=MediaQuery.of(context);
    final isLandscape=mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar=buildAppBar(appBarTitle);
    //print(mediaQuery.size.height);
    final txListWidget=Container(height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top)*(isLandscape ? 0.87 : 0.7),
        child: TransactionList(transaction,deleteTransaction,isLandscape),);
        final pageBody= SafeArea(child: SingleChildScrollView(//For adding Scrolling Functionality To Column
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
        if(isLandscape)//we can use ternary expression here or if statement
        ...buildLandscape(mediaQuery, appbar, txListWidget),
        if(!isLandscape)//we can use ternary expression here or if statement
        ...buildPortrait(mediaQuery,appbar,txListWidget),
      ],
      ),
    ),);
    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appbar,
      )
     : Scaffold(appBar: appbar,//AppBar(centerTitle: true,//to place the title in center
          drawer: MainDrawer(transaction,filters,setFilters),
          body: pageBody,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
          floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(child: const Icon(Icons.add,color: Colors.blue,),onPressed: () => startNewTransaction(context),backgroundColor: Color.fromRGBO(200, 200, 200, 0.556),),//Platform.isAndroid ? FloatingActionButton(child: Icon(Icons.add),onPressed: () => startNewTransaction(context),backgroundColor: Colors.indigo,) : Container(),
      );
  }
}
class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}