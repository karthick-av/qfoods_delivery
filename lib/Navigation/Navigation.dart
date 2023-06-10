import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:qfoods_delivery/Model/GroceryOrderModel.dart';
import 'package:qfoods_delivery/Model/OrderModel.dart';
import 'package:qfoods_delivery/Provider/OrdersProvider.dart';
import 'package:qfoods_delivery/Screens/DashboardScreen/DashboardScreen.dart';
import 'package:qfoods_delivery/Screens/PickedOrdersScreen/PickedOrderScreen.dart';
import 'package:qfoods_delivery/constants/api_services.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:http/http.dart' as http;

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationHelpersScreen();
  }
}
class NavigationHelpersScreen extends StatefulWidget {
  const NavigationHelpersScreen({super.key});

  @override
  State<NavigationHelpersScreen> createState() => _NavigationHelpersScreenState();
}

class _NavigationHelpersScreenState extends State<NavigationHelpersScreen> {

 int i = 0;
 IO.Socket? socket;
@override
void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    
  initSocket();
  UpdateFcmTokenHandler();
    });
  super.initState();
}
initSocket() {
  try{
  print(ApiServices.SOCKET_RECENT_ORDER_URL);
  socket = IO.io(ApiServices.SOCKET_RECENT_ORDER_URL, <String, dynamic>{
    'autoConnect': true,
    'transports': ['websocket'],
  });
  socket?.connect();
  socket?.onConnect((_) {
    print('Connection established');
  });
  socket?.onDisconnect((_) => print('Connection Disconnection'));
  socket?.onConnectError((err) => print(err));
  socket?.onError((err) => print(err));
  socket?.on("recievedOrder", (data){
   
   try{
 if(data["type"] == "restaurant"){
     if(data["data"] != null){
       OrderModel order = OrderModel.fromJson(data["data"]);
       print(order?.orderId);
     
       Provider.of<OrdersProvider>(context, listen: false).AddRestaurantOrder(order);
     } 
    }
     if(data["type"] == "grocery"){
     if(data["data"] != null){
       GroceryOrderModel order = GroceryOrderModel.fromJson(data["data"]);
       print(order?.orderId);
     
       Provider.of<OrdersProvider>(context, listen: false).AddGroceryOrder(order);
     } 
    }
   }catch(e){

   }
  });
  }
  catch(e){
    
  }
}

Future<void> UpdateFcmTokenHandler() async{
  try{
 final uri = Uri.parse(ApiServices.update_fcmtoken);
 String? token = await FirebaseMessaging.instance.getToken();
final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
    final data = {
      "person_id": person_id,
      "fcm_token": token
    };

    var jsonString = json.encode(data);
    print(jsonString);
     var header ={
  'Content-type': 'application/json'
 };
    final response = await http.put(uri, body: jsonString, headers: header);

  }
  catch(e){

  }
}


List pages = [
DashBoardScreen(),
 PickedOrdersScreen(),
 
];

void _onItemTapped(int index) {
    setState(() {
      i = index;
    });
  }



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
      body: pages[i],
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 0.0,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greycolor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: FONT_FAMILY),
        unselectedLabelStyle: TextStyle(fontFamily: FONT_FAMILY),
        iconSize: ScreenUtil().setSp(25.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.yard),
            label: 'Picked Order',
          ),
           ],
        currentIndex: i,
        onTap: _onItemTapped,
      ),
       );
  }
}