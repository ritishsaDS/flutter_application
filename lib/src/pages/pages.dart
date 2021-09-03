import 'package:flutter/material.dart';
import 'package:markets/src/models/cart.dart';
import 'package:markets/src/pages/profile.dart';

import '../color.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import 'cart.dart';
import 'favorites.dart';
import 'messages.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);

          break;
        case 1:
          widget.currentPage = CartWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage = FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = ProfileWidget(parentScaffoldKey: widget.scaffoldKey); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 5:
          widget.currentPage = ProfileWidget(parentScaffoldKey: widget.scaffoldKey); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),
        body: widget.currentPage,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: appColorPrimary,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).accentColor,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
            currentIndex: widget.currentTab,
            onTap: (int i) {
              this._selectTab(i);
            },
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Container(
                    width: 42,
                    height: 42,
                    margin: EdgeInsets.only(bottom: 5),

                    child: new Icon(widget.currentTab == 0 ? Icons.home : Icons.home_outlined, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                icon: Icon(widget.currentTab == 1 ? Icons.shopping_basket : Icons.shopping_basket_outlined,color:Colors.white,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(widget.currentTab == 2 ? Icons.favorite : Icons.favorite_border,color:Colors.white,),
                label: '',
              ),

              BottomNavigationBarItem(
                icon: new Icon(widget.currentTab == 3 ? Icons.local_mall : Icons.local_mall_outlined,color:Colors.white,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: new Icon(widget.currentTab == 4 ? Icons.person : Icons.person_outline_rounded,color:Colors.white,),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
