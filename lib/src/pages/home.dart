import 'package:flutter/material.dart';
import 'package:markets/src/pages/Appbar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../color.dart';
import '../common.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget>with SingleTickerProviderStateMixin {
  TabController _tabController;
  HomeController _con;
  final colors = [Colors.purple, Colors.green, Colors.pink];
  Color indicatorColor;
  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this) ..addListener(() {
      setState(() {
      //  indicatorColor = colors[_tabController.index];
      });
    });
    //indicatorColor = colors[0];;
   // _tabController.addListener(_handleTabSelection);
    //_tabController.index = 0;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      //backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: new IconButton(
      //     icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
      //     onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: ValueListenableBuilder(
      //     valueListenable: settingsRepo.setting,
      //     builder: (context, value, child) {
      //       return Text(
      //         value.appName ?? S.of(context).home,
      //         style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
      //       );
      //     },
      //   ),
      //   actions: <Widget>[
      //     new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
       SliverAppBar(
      //pinned: true,
         automaticallyImplyLeading: false,
        leadingWidth: 0.0,
        expandedHeight: SizeConfig.screenHeight * 0.15,
      //  collapsedHeight: 100,
        flexibleSpace:  MainDashBoardAppBar(  text: 'FastKart',
          scaffoldKey: widget.parentScaffoldKey,
          height: SizeConfig.screenHeight * 0.22,
          textfiledIcon: 'assets/filter.png',)
      ),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height-250,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return RefreshIndicator(
                  onRefresh: _con.refreshHome,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(settingsRepo.setting.value.homeSections.length, (index) {
                        String _homeSection = settingsRepo.setting.value.homeSections.elementAt(index);
                        switch (_homeSection) {
                          case "slider":

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(
                                  Icons.category_outlined,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  S.of(context).product_categories,
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
                                ),
                              ),
                            );
                          case 'top_markets_heading':

                            return  Column(
                              children: [
                                Container(

                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                        )),
                                    height: 130,
                                    child:CategoriesCarouselWidget(
                                      categories: _con.categories,
                                    )
                                ),

                              ],
                            );
                          // case 'search':
                          //   return
                          //     MainDashBoardAppBar(  text: 'FastKart',
                          //       scaffoldKey: widget.parentScaffoldKey,
                          //       height: SizeConfig.screenHeight * 0.22,
                          //       textfiledIcon: 'assets/filter.png',)
                          //
                          //   ;
                        // case 'top_markets_heading':
                        //   return Padding(
                        //     padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Expanded(
                        //               child: Text(
                        //                 S.of(context).top_markets,
                        //                 style: Theme.of(context).textTheme.headline4,
                        //                 maxLines: 1,
                        //                 softWrap: false,
                        //                 overflow: TextOverflow.fade,
                        //               ),
                        //             ),
                        //             InkWell(
                        //               onTap: () {
                        //                 if (currentUser.value.apiToken == null) {
                        //                   _con.requestForCurrentLocation(context);
                        //                 } else {
                        //                   var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                        //                     (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                        //                     shape: RoundedRectangleBorder(
                        //                       borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        //                     ),
                        //                   );
                        //                   bottomSheetController.closed.then((value) {
                        //                     _con.refreshHome();
                        //                   });
                        //                 }
                        //               },
                        //               child: Container(
                        //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.all(Radius.circular(5)),
                        //                   color: settingsRepo.deliveryAddress.value?.address == null
                        //                       ? Theme.of(context).focusColor.withOpacity(0.1)
                        //                       : Theme.of(context).accentColor,
                        //                 ),
                        //                 child: Text(
                        //                   S.of(context).delivery,
                        //                   style: TextStyle(
                        //                       color:
                        //                           settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(width: 7),
                        //             InkWell(
                        //               onTap: () {
                        //                 setState(() {
                        //                   settingsRepo.deliveryAddress.value?.address = null;
                        //                 });
                        //               },
                        //               child: Container(
                        //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.all(Radius.circular(5)),
                        //                   color: settingsRepo.deliveryAddress.value?.address != null
                        //                       ? Theme.of(context).focusColor.withOpacity(0.1)
                        //                       : Theme.of(context).accentColor,
                        //                 ),
                        //                 child: Text(
                        //                   S.of(context).pickup,
                        //                   style: TextStyle(
                        //                       color:
                        //                           settingsRepo.deliveryAddress.value?.address != null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         if (settingsRepo.deliveryAddress.value?.address != null)
                        //           Padding(
                        //             padding: const EdgeInsets.only(top: 12),
                        //             child: Text(
                        //               S.of(context).near_to + " " + (settingsRepo.deliveryAddress.value?.address),
                        //               style: Theme.of(context).textTheme.caption,
                        //             ),
                        //           ),
                        //       ],
                        //     ),
                        //   );
                        // case 'top_markets':
                        //   return CardsCarouselWidget(marketsList: _con.topMarkets, heroTag: 'home_top_markets');

                          case 'trending_week_heading':
                            return HomeSliderWidget(slides: _con.slides);

                          case 'trending_week':
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              // leading: Icon(
                              //   Icons.trending_up,
                              //   color: Theme.of(context).hintColor,
                              // ),
                              title: Text(
                                S.of(context).trending_this_week,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              // subtitle: Text(
                              //   S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                              //   maxLines: 2,
                              //   style: Theme.of(context).textTheme.caption,
                              // ),
                            );
                          case 'categories_heading':
                            return
                              ProductsCarouselWidget(productsList: _con.trendingProducts, heroTag: 'home_product_carousel');

                        // case 'categories':
                        //   return CategoriesCarouselWidget(
                        //     categories: _con.categories,
                        //   );
                          case 'popular_heading':

                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  // margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                                  child: TabBar(
                                    isScrollable: false,
                                    // indicatorPadding: EdgeInsets.all(0.0),
                                    //labelPadding: EdgeInsets.all(0.0),
                                    //indicatorWeight: 4,
                                    // labelColor:colors[0],
                                    indicatorColor: Colors.transparent,
                                    controller: _tabController,
                                    onTap: (index)
                                    {
                                      setState(() {
                                        print(_tabController.index);
                                      });
                                    },
                                    // indicatorSize: TabBarIndicatorSize.tab,
                                    tabs: [
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2.5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.0),
                                              color:_tabController.index==0?hometab:Colors.white),
                                          width: SizeConfig.blockSizeHorizontal*30,height: SizeConfig.blockSizeVertical*4,
                                          alignment: Alignment.center,
                                          child: Text("Newly Added",style:  TextStyle(
                                              fontWeight: FontWeight.w600,color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.85))),
                                      Container(
                                          margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2.5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.0),
                                              color: _tabController.index==1?hometab:Colors.white),
                                          width: SizeConfig.blockSizeHorizontal*29,height: SizeConfig.blockSizeVertical*4.25,
                                          alignment: Alignment.center,
                                          child: Text("Top Items",style:  TextStyle(
                                              fontWeight: FontWeight.w600,color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.85))),
                                      Container(
                                          margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*2.5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.0),color: _tabController.index==2? hometab:Colors.white),
                                          width: SizeConfig.blockSizeHorizontal*29,height: SizeConfig.blockSizeVertical*4.25,
                                          alignment: Alignment.center,
                                          child: Text("Best Offers",style:  TextStyle(
                                              fontWeight: FontWeight.w600,color: Colors.black,
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.85))),
                                    ],
                                  ),
                                ),

                              ],
                            );

                          case 'popular':
                            return Container(

                                child:  Container(
                                    height: 400,

                                    child: DefaultTabController(
                                      length: 3,
                                      child:  TabBarView(

                                        controller: _tabController,

                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: GridWidget(
                                              marketsList: _con.popularMarkets,
                                              heroTag: 'home_markets',
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 20),
                                            child: GridWidget(
                                              marketsList: _con.popularMarkets,
                                              heroTag: 'home_markets',
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 20),
                                            child: GridWidget(
                                              marketsList: _con.popularMarkets,
                                              heroTag: 'home_markets',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )));
                        // case 'recent_reviews_heading':
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20),
                        //     child: ListTile(
                        //       dense: true,
                        //       contentPadding: EdgeInsets.symmetric(vertical: 20),
                        //       leading: Icon(
                        //         Icons.recent_actors_outlined,
                        //         color: Theme.of(context).hintColor,
                        //       ),
                        //       title: Text(
                        //         S.of(context).recent_reviews,
                        //         style: Theme.of(context).textTheme.headline4,
                        //       ),
                        //     ),
                        //   );
                        // case 'recent_reviews':
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20),
                        //     child: ReviewsListWidget(reviewsList: _con.recentReviews),
                        //   );
                          default:
                            return SizedBox(height: 0);
                        }
                      }),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),

        ]
      ),
    );
  }
  topCategoryButton({String assets, String title, BuildContext context}) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 22,
      height: SizeConfig.blockSizeHorizontal * 18,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1.2),
      decoration: BoxDecoration(
          color: appColorPrimary2, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            assets,
            height: SizeConfig.blockSizeHorizontal * 8,
            width: SizeConfig.blockSizeHorizontal * 6,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: TextStyle(
                color: appTextColor.withOpacity(0.8),
                fontSize: SizeConfig.blockSizeHorizontal * 3,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

}
