

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qfoods_delivery/Components/OrderCard.dart';
import 'package:qfoods_delivery/Model/GroceryOrderModel.dart';

import 'package:http/http.dart' as http;
import 'package:qfoods_delivery/constants/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GroceryDeliveredScreen extends StatefulWidget {
  const GroceryDeliveredScreen({super.key});

  @override
  State<GroceryDeliveredScreen> createState() => _GroceryDeliveredScreenState();
}

class _GroceryDeliveredScreenState extends State<GroceryDeliveredScreen> {
 
  ScrollController scrollController = ScrollController();
bool ApiCallDone = false;
int current_page = 1;
bool CompleteAPI = false;
int per_page = 7;
bool loading = false;
List<GroceryOrderModel> orders = [];


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
     getDeliveredOrdersHandler();
  super.initState();
  }

 Future<void> getDeliveredOrdersHandler() async{
  
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
  List<GroceryOrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
  
    var response = await http.get(Uri.parse("${ApiServices.grocery_delivered_orders}?person_id=${person_id}&page=${current_page}&per_page=${per_page}"));
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
 orders = _orders;
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
    
 if(CompleteAPI) return;

 final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
  List<GroceryOrderModel> _orders= [];
  setState(() {
    ApiCallDone = true;
  });
try{
  
    var response = await http.get(Uri.parse("${ApiServices.grocery_delivered_orders}?person_id=${person_id}&page=${current_page}&per_page=${per_page}"));
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
 
orders=  [...orders, ..._orders];
 
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
    return RefreshIndicator(
      onRefresh: () async{
         ApiCallDone = false;
 current_page = 1;
 CompleteAPI = false;
 per_page = 7;
 loading = false;
 orders = [];
 setState(() {});
         await getDeliveredOrdersHandler();
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
                                    return GroceryOrderCard(order: orders?[index]);
                                  }
                ),
                
                SizedBox(
                        height: MediaQuery.of(context).size.height,
                      )
    
        ]),
      ),
    );
  }
}