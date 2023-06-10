import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/Restaurant/PickedOrdersConfirmedScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/Restaurant/PickedOrdersDeliveredScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/Restaurant/PickedOrdersOntheWayScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/grocery/PickedOrdersConfirmedScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/grocery/PickedOrdersDeliveredScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/Screens/grocery/PickedOrdersOntheWayScreen.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';


class PickedOrdersGroceryScreen extends StatefulWidget {
  const PickedOrdersGroceryScreen({super.key});

  @override
  State<PickedOrdersGroceryScreen> createState() => _PickedOrdersGroceryScreenState();
}

class _PickedOrdersGroceryScreenState extends State<PickedOrdersGroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 3,
          child: Scaffold(
          
            bottomNavigationBar: menu(),
            body: TabBarView(
              children: [
               PickedGroceryOrdersConfirmedScreen(status_id: 2),
               PickedGroceryOrdersOntheWayScreen(status_id: 3),
               PickedGroceryOrdersDeliveredScreen(status_id: 4),
              ],
            ),
          ),
        );
  }
Widget menu() {
return Container(
  color: AppColors.primaryColor,
  child: TabBar(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white70,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: AppColors.whitecolor,
    tabs: [
       Tab(child: Text('Confirmed', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)),)),
              Tab(child: Text('On the Way', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)))),
              Tab(child: Text('Delivered', style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14)))),
             
    ],
  ),
);
}
  
}