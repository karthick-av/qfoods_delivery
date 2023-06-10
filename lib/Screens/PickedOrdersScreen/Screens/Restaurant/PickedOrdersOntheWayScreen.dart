

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:qfoods_delivery/Components/OrderCard.dart';
import 'package:qfoods_delivery/Model/OrderModel.dart';

import 'package:http/http.dart' as http;
import 'package:qfoods_delivery/Provider/OrdersProvider.dart';
import 'package:qfoods_delivery/constants/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PickedOrdersOntheWayScreen extends StatefulWidget {
  final int status_id;
  const PickedOrdersOntheWayScreen({super.key, required this.status_id});

  @override
  State<PickedOrdersOntheWayScreen> createState() => _PickedOrdersOntheWayScreenState();
}

class _PickedOrdersOntheWayScreenState extends State<PickedOrdersOntheWayScreen> {
 
  ScrollController scrollController = ScrollController();
bool ApiCallDone = false;
int current_page = 1;
bool CompleteAPI = false;
int per_page = 7;
bool loading = false;

  @override
  void initState() {
  //  getOrdersByStatusHandler();
     scrollController.addListener(() { 
      if(scrollController.position.maxScrollExtent == scrollController.offset){
      print("object");
       if(!ApiCallDone){
        getOrdersByBottomStatusHandler();
       }
    }
     });
  super.initState();
  }

 Future<void> getOrdersByStatusHandler() async{
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
  
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
  List<OrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
  
    var response = await http.get(Uri.parse("${ApiServices.get_orders_by_status_id}?person_id=${person_id}&status=${widget?.status_id}&page=${current_page}&per_page=${per_page}"));
    print(response.statusCode);
    
    if(response.statusCode == 200){
       var response_body = json.decode(response.body);

       if(response_body!.length == 0){
        setState(() {
          CompleteAPI = true;
        });
       }
    print(response_body);   
       for(var json in response_body){
     
      _orders.add(OrderModel.fromJson(json));
       }

 current_page = current_page + 1;
    ApiCallDone = false;
 
 ordersProvider.AddRestaurantOntheWayOrders(_orders);
       //  orders=  [...orders, ..._orders];
 
       setState(() {
       });
    }else{
      setState(() {
    ApiCallDone = false;
  });
    }
  }
  catch(err){
 setState(() {
    ApiCallDone = false;
  });
  }
  
  }


  Future<void> getOrdersByBottomStatusHandler() async{
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    
 if(CompleteAPI) return;

 final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
  List<OrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
  
    var response = await http.get(Uri.parse("${ApiServices.get_orders_by_status_id}?person_id=${person_id}&status=${widget?.status_id}&page=${current_page}&per_page=${per_page}"));
    print(response.statusCode);
    
    if(response.statusCode == 200){
       var response_body = json.decode(response.body);

       if(response_body!.length == 0){
        setState(() {
          CompleteAPI = true;
        });
       }
    print(response_body);   
       for(var json in response_body){
     
      _orders.add(OrderModel.fromJson(json));
       }

 current_page = current_page + 1;
    ApiCallDone = false;
 
 ordersProvider.AddRestaurantOntheWayOrders([...ordersProvider.OntheWayRestaurantOrders, ..._orders]);
       //  orders=  [...orders, ..._orders];
 
       setState(() {
       });
    }else{
      setState(() {
    ApiCallDone = false;
  });
    }
  }
  catch(err){
 setState(() {
    ApiCallDone = false;
  });
  }
  
  }

@override  
void dispose(){

  scrollController.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
   final orders = Provider.of<OrdersProvider>(context, listen: true).OntheWayRestaurantOrders;
    return RefreshIndicator(
      onRefresh: () async{
         ApiCallDone = false;
 current_page = 1;
 CompleteAPI = false;
 per_page = 7;
 loading = false;
 setState(() {});
         await getOrdersByStatusHandler();
      },
      child: SingleChildScrollView(
      controller: scrollController,
      child: Column(children: [
       ListView.builder(
                padding: const EdgeInsets.all(8),
         physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                                itemCount: orders?.length ?? 0,
                                itemBuilder:(context, index) {
                                  return OrderCard(order: orders?[index]);
                                }
              ),
              SizedBox(
                      height: MediaQuery.of(context).size.height,
                    )

      ]),
    ));
  }
}