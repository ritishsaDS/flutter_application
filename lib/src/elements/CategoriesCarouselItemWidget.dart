import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';
import '../common.dart';
import '../models/category.dart';
import '../models/route_argument.dart';

// ignore: must_be_immutable
class CategoriesCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Category category;
  CategoriesCarouselItemWidget({Key key, this.marginLeft, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        print("category.id"+category.id);
        Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: category.id, heroTag: "home_markets"));
       // Navigator.of(context).pushNamed('/Category', arguments: RouteArgument(id: category.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: category.id,
            child: Container(
              //margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              width: SizeConfig.blockSizeHorizontal * 22,
              height: SizeConfig.blockSizeHorizontal * 18,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 1.2),
              decoration: BoxDecoration(
                  color: appColorPrimary2, borderRadius: BorderRadius.circular(20)),   child: Padding(
                padding: const EdgeInsets.all(15),
                child: category.image.url.toLowerCase().endsWith('.svg')
                    ? SvgPicture.network(
                        category.image.url,
                        color: Theme.of(context).accentColor,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: category.image.icon,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                      ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
            child: Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
