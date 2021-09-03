import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../color.dart';
import '../common.dart';
import '../controllers/profile_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ProfileAvatarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';
import 'orders.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  ProfileController _con;

  _ProfileWidgetState() : super(ProfileController()) {
    _con = controller;
  }final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
          onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).profile,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).hintColor),
        ],
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: <Widget>[
                  ProfileAvatarWidget(user: currentUser.value),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).about,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      currentUser.value?.bio ?? "",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   leading: Icon(
                  //     Icons.shopping_basket_outlined,
                  //     color: Theme.of(context).hintColor,
                  //   ),
                  //   title: Text(
                  //     S.of(context).recent_orders,
                  //     style: Theme.of(context).textTheme.headline4,
                  //   ),
                  // ),
                  GestureDetector(onTap:(){
                    print("ffvkmkmfv");
                       Navigator.pushNamed(context,'/Pages', arguments: 3);

                  },child: Container(child: profileTile(iconAsset: "assets/order2.png",title: "My Order"))),
                  GestureDetector(
                      onTap:(){
                    Navigator.pushNamed(context,'/Pages', arguments: 1);
                  },child: Container(child: profileTile(iconAsset: "assets/cart.png",title: "My Cart"),)),
                  GestureDetector(onTap:(){
                    Navigator.pushNamed(context,'/Pages', arguments: 2);
                  },child: Container(child: profileTile(iconAsset: "assets/fav 2.png",title: "My Favourite"),)),
                  GestureDetector(onTap:(){
                    Navigator.pushNamed(context,'/Help');
                  },child: Container(child: profileTile(iconAsset: "assets/profile.png",title: "Help & Support"),)),
                  Container(child: profileTile(iconAsset: "assets/notification.png",title: "Notifications"),),
                  Container(child: profileTile(iconAsset: "assets/logout.png",title: "Logout"),),
                  // _con.recentOrders.isEmpty
                  //     ? EmptyOrdersWidget()
                  //     : ListView.separated(
                  //         scrollDirection: Axis.vertical,
                  //         shrinkWrap: true,
                  //         primary: false,
                  //         itemCount: _con.recentOrders.length,
                  //         itemBuilder: (context, index) {
                  //           var _order = _con.recentOrders.elementAt(index);
                  //           return OrderItemWidget(expanded: index == 0 ? true : false, order: _order);
                  //         },
                  //         separatorBuilder: (context, index) {
                  //           return SizedBox(height: 20);
                  //         },
                  //       ),


                ],
              ),
            ),
    );
  }
  profileSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "SampleProfileImageUrl",
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeHorizontal * 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                        color: appTextColor.withOpacity(0.5),
                        fontSize: SizeConfig.blockSizeHorizontal * 3),
                  ),
                  Text(
                    'Full Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone',
                    style: TextStyle(
                        color: appTextColor.withOpacity(0.5),
                        fontSize: SizeConfig.blockSizeHorizontal * 3),
                  ),
                  Text(
                    '+91 9876543210',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                    //  Navigator.pushNamed(context, UpdateProfileScreen.route);
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeHorizontal * 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 10,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'see more',
                        style: TextStyle(color: appColorPrimary),
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  profileTile({String iconAsset, String title, String route}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconAsset,
                height: SizeConfig.blockSizeHorizontal * 7,
                width: SizeConfig.blockSizeHorizontal * 7,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 2,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.blockSizeHorizontal * 3.5,
          ),
        ],
      ),
    );
  }
}
