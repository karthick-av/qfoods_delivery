import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qfoods_delivery/Navigation/DrawerMenu.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/PickedOrdersRestaurantScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/PickedOrdersGroceryScreen.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';


class PickedOrdersScreen extends StatefulWidget {
  const PickedOrdersScreen({super.key});

  @override
  State<PickedOrdersScreen> createState() => _PickedOrdersScreenState();
}

class _PickedOrdersScreenState extends State<PickedOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 2,
  child: Scaffold(
     drawer: DrawerMenu(),
   
      body: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
      new SliverAppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('Picked Order',style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(16))),
          pinned: true,
          floating: true,
          bottom: TabBar(
            indicatorColor: AppColors.whitecolor,
            tabs: [
              Tab(child: Text('Restaurant', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)),)),
              Tab(child: Text('Grocery', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)))),
             
            ],
          ),
        )
      ];
    },
    body: TabBarView(
      children: <Widget>[
       PickedOrdersRestaurantScreen(),
        PickedOrdersGroceryScreen(),
      ],
    ),
  )),
);
  }
}
