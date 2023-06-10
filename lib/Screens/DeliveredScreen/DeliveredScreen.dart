import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qfoods_delivery/Navigation/DrawerMenu.dart';
import 'package:qfoods_delivery/Provider/OrdersProvider.dart';
import 'package:qfoods_delivery/Screens/DeliveredScreen/Screens/GroceryDeliveredScreen.dart';
import 'package:qfoods_delivery/Screens/DeliveredScreen/Screens/RestaurantDeliveredScreen.dart';
import 'package:qfoods_delivery/Screens/RecentGroceryOrdersScreen/RecentGroceryOrdersScreen.dart';
import 'package:qfoods_delivery/Screens/RestaurantOrdersScreen/RestaurantOrdersScreen.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';

class DeliveredScreen extends StatefulWidget {
  const DeliveredScreen({super.key});

  @override
  State<DeliveredScreen> createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  @override
  Widget build(BuildContext context) {
      final ordersProvider = Provider.of<OrdersProvider>(context, listen: true);
    
    return DefaultTabController(
  length: 2,
  child: Scaffold(
    drawer: DrawerMenu(),
      body: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('Delivered Orders',style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(16))),
          pinned: true,
          floating: true,
          bottom: TabBar(
            indicatorColor: AppColors.whitecolor,
            tabs: [
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Restaurant', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)),),
                 if((ordersProvider?.RecentRestaurantOrders?.length ?? 0) > 0)
                 Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                      color: AppColors.whitecolor
                                                ),
                                                child: Text("${ordersProvider?.RecentRestaurantOrders?.length}", style: TextStyle(color: AppColors.primaryColor, fontSize: ScreenUtil().setSp(12), fontFamily: FONT_FAMILY, fontWeight: FontWeight.w500),),
                                              )
         
                ],
              )),
               Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Grocery', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)),),
                 if((ordersProvider?.RecentGroceryOrders?.length ?? 0) > 0)
                 Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                      color: AppColors.whitecolor
                                                ),
                                                child: Text("${ordersProvider?.RecentGroceryOrders?.length}", style: TextStyle(color: AppColors.primaryColor, fontSize: ScreenUtil().setSp(12), fontFamily: FONT_FAMILY, fontWeight: FontWeight.w500),),
                                              )
         
                ],
              )),
            ],
          ),
        ),
      ];
    },
    body: TabBarView(
      children: <Widget>[
        RestaurantDeliveredScreen(),
        GroceryDeliveredScreen()
      ],
    ),
  )),
);
  }
}