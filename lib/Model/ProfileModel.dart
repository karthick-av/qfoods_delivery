class ProfileModel {
  int? personId;
  String? name;
  String? image;
  int? phoneNumber;
  String? gender;
  int? totalDeliveredOrders;
  int? totalGroceryDeliveredOrders;
  int? todayTotalDeliveredOrders;
  int? todayTotalGroceryDeliveredOrders;

  ProfileModel(
      {this.personId,
      this.name,
      this.image,
      this.phoneNumber,
      this.gender,
      this.totalDeliveredOrders,
      this.totalGroceryDeliveredOrders,
      this.todayTotalDeliveredOrders,
      this.todayTotalGroceryDeliveredOrders});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    name = json['name'];
    image = json['image'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    totalDeliveredOrders = json['total_delivered_orders'];
    totalGroceryDeliveredOrders = json['total_grocery_delivered_orders'];
    todayTotalDeliveredOrders = json['today_total_delivered_orders'];
    todayTotalGroceryDeliveredOrders =
        json['today_total_grocery_delivered_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['total_delivered_orders'] = this.totalDeliveredOrders;
    data['total_grocery_delivered_orders'] = this.totalGroceryDeliveredOrders;
    data['today_total_delivered_orders'] = this.todayTotalDeliveredOrders;
    data['today_total_grocery_delivered_orders'] =
        this.todayTotalGroceryDeliveredOrders;
    return data;
  }
}
