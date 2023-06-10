import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qfoods_delivery/Model/OrderModel.dart';
import 'package:qfoods_delivery/constants/api_services.dart';

class DeliveryOrdersServices{

Future<List<OrderModel>> RecentRestaurantOrders() async{
List<OrderModel> orders = [];

final response = await http.get(Uri.parse(ApiServices.restaurant_recent_orders));
    if (response.statusCode == 200) {
     var response_body = json.decode(response.body);
       
       for(var json in response_body){
     
      orders.add(OrderModel.fromJson(json));
       }
    }

return orders;

}



}

