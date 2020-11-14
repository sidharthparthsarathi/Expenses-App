import '../Models/Transactions.dart';
import 'package:flutter/material.dart';
import '../widgets/Date.dart';
import '../screens/transaction-details-screen.dart';
class FiltersItem extends StatelessWidget {
  final Transaction e;
  FiltersItem(this.e);
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData=MediaQuery.of(context);
    final isLandscape=mediaQueryData.orientation==Orientation.landscape;
    return InkWell(
      splashColor: Colors.blue.shade900,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionDetails(
              e.title,
              e.id,
              e.date,
              e.amount,
              ),
            ),
            ),
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.redAccent),
        ),
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 10,
          color: Color.fromRGBO(10, 15, 255, 0.65),
          margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.black,
                        radius: mediaQueryData.size.height*0.1,
                        child: Container(width: mediaQueryData.size.width*(isLandscape ? 0.1 : 0.15),
                          child: FittedBox(child: Text('\₹'+e.amount.toString(),
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500),
                          ),
                          ),
                        ),
                        ),
                              title: Text('${e.title}',
                              style: TextStyle(
                                color: Color.fromRGBO(40, 10, 10, 0.8),
                                fontWeight: FontWeight.w900,
                              ),
                              ),
                              subtitle: ADate(e.date),
                      )
                      ),
                  ],
                ),
        ), 
      ),
    );
  }
}