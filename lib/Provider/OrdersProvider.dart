


import 'package:flutter/cupertino.dart';
import 'package:qfoods_delivery/Model/GroceryOrderModel.dart';
import 'package:qfoods_delivery/Model/OrderModel.dart';
import 'package:qfoods_delivery/Services/Orders_helpers.dart';

class OrdersProvider extends ChangeNotifier{
final _service = DeliveryOrdersServices();


  List<OrderModel> RecentRestaurantOrders = [];
  bool RecentRestaurantOrdersLoading = false;
   List<OrderModel> ConfirmedRestaurantOrders = [];
 List<OrderModel> OntheWayRestaurantOrders = [];
 List<OrderModel> DeliveredRestaurantOrders = [];


List<GroceryOrderModel> RecentGroceryOrders = [];
  bool RecentGroceryOrdersLoading = false;
   List<GroceryOrderModel> ConfirmedGroceryOrders = [];
 List<GroceryOrderModel> OntheWayGroceryOrders = [];
 List<GroceryOrderModel> DeliveredGroceryOrders = [];


//   Future<void> getRecentRestaurantOrders() async{
//    RecentRestaurantOrdersLoading = true;
//     notifyListeners();

//  try{
//      List<OrderModel> response = await _service.RecentRestaurantOrders();
   
//    RecentRestaurantOrders = response;
//     RecentRestaurantOrdersLoading = false;
//     notifyListeners();
//  }
//  catch(e){
//     print(e);
//  }

//   }

void AddRecentRestaurantOrders(List<OrderModel> orders){

    RecentRestaurantOrders = orders;
    notifyListeners();

 }  

  void AddRestaurantOrder(OrderModel order){
    print(order.grandTotal);
    final isExist = RecentRestaurantOrders.where((element) => element.orderId == order.orderId);
    print(isExist);
    if(isExist?.length == 0){
      RecentRestaurantOrders = [order,...RecentRestaurantOrders];
      notifyListeners();
    }    

  }
  




 void AddRestaurantConfirmedOrders(List<OrderModel> orders){
    ConfirmedRestaurantOrders = orders;
    notifyListeners();

 }   
 
 void AddRestaurantOntheWayOrders(List<OrderModel> orders){
    OntheWayRestaurantOrders = orders;
    notifyListeners();

 }   
 
 void AddRestaurantDeliveredOrders(List<OrderModel> orders){
    DeliveredRestaurantOrders = orders;
    notifyListeners();

 }  


 void RestaurantOrderStatusChanger(OrderModel order){
 
 if(order?.status == 2){
 RecentRestaurantOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 print(RecentRestaurantOrders.length);
 final check = ConfirmedRestaurantOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  ConfirmedRestaurantOrders = [order, ...ConfirmedRestaurantOrders];
 }
 
  notifyListeners();
 }
 if(order?.status == 3){
 ConfirmedRestaurantOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 final check = OntheWayRestaurantOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  OntheWayRestaurantOrders = [order, ...OntheWayRestaurantOrders];
 }
 
  notifyListeners();
 }
 if(order?.status == 4){
 OntheWayRestaurantOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 final check = DeliveredRestaurantOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  DeliveredRestaurantOrders = [order, ...DeliveredRestaurantOrders];

 }

  notifyListeners(); 
 }

 } 



//grocery

void AddRecentGroceryOrders(List<GroceryOrderModel> orders){

    RecentGroceryOrders = orders;
    notifyListeners();

 }  
  void AddGroceryOrder(GroceryOrderModel order){
    final isExist = RecentGroceryOrders.where((element) => element.orderId == order.orderId);
    print(isExist);
    if(isExist?.length == 0){
      RecentGroceryOrders = [order,...RecentGroceryOrders];
      notifyListeners();
    }    

  }
  


 void AddGroceryConfirmedOrders(List<GroceryOrderModel> orders){
    ConfirmedGroceryOrders = orders;
    notifyListeners();

 }   
 
 void AddGroceryOntheWayOrders(List<GroceryOrderModel> orders){
    OntheWayGroceryOrders = orders;
    notifyListeners();

 }   
 
 void AddGroceryDeliveredOrders(List<GroceryOrderModel> orders){
    DeliveredGroceryOrders = orders;
    notifyListeners();

 }  





 void GroceryOrderStatusChanger(GroceryOrderModel order){
 
 if(order?.status == 2){
 RecentGroceryOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 final check = ConfirmedGroceryOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  ConfirmedGroceryOrders = [order, ...ConfirmedGroceryOrders];
 }
 
  notifyListeners();
 }
 if(order?.status == 3){
 ConfirmedGroceryOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 final check = OntheWayGroceryOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  OntheWayGroceryOrders = [order, ...OntheWayGroceryOrders];
 }
 
  notifyListeners();
 }
 if(order?.status == 4){
 OntheWayGroceryOrders?.removeWhere((element) => element?.orderId == order?.orderId);
 final check = DeliveredGroceryOrders.where((element) => element?.orderId == order?.orderId);
 if(check.length == 0){
  DeliveredGroceryOrders = [order, ...DeliveredGroceryOrders];

 }

  notifyListeners(); 
 }

 } 
}