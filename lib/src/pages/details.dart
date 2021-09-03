import 'package:flutter/material.dart';
import 'package:markets/src/color.dart';
import 'package:markets/src/pages/pages.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../models/conversation.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';
import 'chat.dart';
import 'map.dart';
import 'market.dart';
import 'menu_list.dart';

// ignore: must_be_immutable
class DetailsWidget extends StatefulWidget {
  RouteArgument routeArgument;
  dynamic currentTab;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget currentPage;

  DetailsWidget({
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
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  MarketController _con;

  _DetailsWidgetState() : super(MarketController()) {
    _con = controller;
  }

  initState() {
    _selectTab(widget.currentTab);
    super.initState();
  }

  @override
  void didUpdateWidget(DetailsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          _con.listenForMarket(id: widget.routeArgument.param).then((value) {
            setState(() {
              _con.market = value as Market;
              print(_con.market.toMap());
              widget.currentPage = MarketWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(param: _con.market));
            });
          });
          break;
        // case 1:
        //   if (currentUser.value.apiToken == null) {
        //     widget.currentPage = PermissionDeniedWidget();
        //   } else {
        //     Conversation _conversation = new Conversation(
        //         _con.market?.users?.map((e) {
        //           e.image = _con.market.image;
        //           return e;
        //         })?.toList(),
        //         name: _con.market.name);
        //     widget.currentPage = ChatWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(id: _con.market.id, param: _conversation));
        //   }
        //   break;
        // case 2:
        //   widget.currentPage = MapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(param: _con.market));
        //   break;
        // case 3:
        //   widget.currentPage = MenuWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(param: _con.market));
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        bottomNavigationBar: Container(
          color: appColorPrimary,
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
        body: widget.currentPage ?? CircularLoadingWidget(height: 400));
  }
}
