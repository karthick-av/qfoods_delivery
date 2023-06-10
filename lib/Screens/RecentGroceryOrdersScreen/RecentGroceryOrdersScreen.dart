import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qfoods_delivery/Components/OrderCard.dart';
import 'package:qfoods_delivery/Model/GroceryOrderModel.dart';
import 'package:qfoods_delivery/Provider/OrdersProvider.dart';

import 'package:http/http.dart' as http;
import 'package:qfoods_delivery/constants/api_services.dart';
import 'package:qfoods_delivery/constants/colors.dart';

class RecentGroceryOrdersScreen extends StatefulWidget {
  const RecentGroceryOrdersScreen({super.key});

  @override
  State<RecentGroceryOrdersScreen> createState() => _RecentGroceryOrdersScreenState();
}

class _RecentGroceryOrdersScreenState extends State<RecentGroceryOrdersScreen> {

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
       if(!ApiCallDone){
        getOrdersByBottomStatusHandler();
       }
    }
     });
  super.initState();
  }

 Future<void> getOrdersByStatusHandler() async{
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
  
  List<GroceryOrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
    var response = await http.get(Uri.parse("${ApiServices.grocery_recent_orders}?page=${current_page}&per_page=${per_page}"));
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
     
      _orders.add(GroceryOrderModel.fromJson(json));
       }

 current_page = current_page + 1;
    ApiCallDone = false;
 
 ordersProvider.AddRecentGroceryOrders(_orders);
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

  List<GroceryOrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
  
    var response = await http.get(Uri.parse("${ApiServices.grocery_recent_orders}?page=${current_page}&per_page=${per_page}"));
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
     
      _orders.add(GroceryOrderModel.fromJson(json));
       }

 current_page = current_page + 1;
    ApiCallDone = false;
 
 ordersProvider.AddRecentGroceryOrders([...ordersProvider.RecentGroceryOrders, ..._orders]);
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
     final orders = Provider.of<OrdersProvider>(context, listen: true).RecentGroceryOrders;
   
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: RefreshIndicator(
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
            child: Column(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
           physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                                  itemCount: orders?.length ?? 0,
                                  itemBuilder:(context, index) {
                                    return GroceryOrderCard(order: orders?[index]);
                                  }
                ),
                SizedBox(
                        height: MediaQuery.of(context).size.height,
                      )
              ],
            ),
          ),
        ),
    );
  }
}