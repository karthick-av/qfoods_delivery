
class ApiServices{
  ApiServices._();  
    static  const BASEURL = "https://qfoods-server.onrender.com/";
     static const SOCKET_RECENT_ORDER_URL = "${BASEURL}recentorder";

   static const login = "${BASEURL}delivery/user/login";  

   static const restaurant_recent_orders = "${BASEURL}delivery/orders/restaurant/recent";

   static const get_order = "${BASEURL}user/order/getorder/";
  
   static const get_grocery_order = "${BASEURL}user/order/grocery/getorder/";
   static const accept_restaurant_order = "${BASEURL}delivery/orders/restaurant/accept";

 static const update_status_order = "${BASEURL}delivery/orders/restaurant/updateorder";

 static const get_orders_by_status_id = "${BASEURL}delivery/orders/restaurant/order";
static const cancel_order = "${BASEURL}delivery/orders/restaurant/cancelorder";
static const delivered_orders = "${BASEURL}delivery/orders/restaurant/deliveredorder";


static const grocery_recent_orders = "${BASEURL}delivery/orders/grocery/recent";

   static const accept_grocery_order = "${BASEURL}delivery/orders/grocery/accept";

 static const update_status_grocery_order = "${BASEURL}delivery/orders/grocery/updateorder";

 static const get_grocery_orders_by_status_id = "${BASEURL}delivery/orders/grocery/order";
static const grocery_cancel_order = "${BASEURL}delivery/orders/grocery/cancelorder";
static const grocery_delivered_orders = "${BASEURL}delivery/orders/grocery/deliveredorder";

static const profile = "${BASEURL}delivery/user/profile/";

static const update_fcmtoken = "${BASEURL}delivery/user/updatefcmtoken";  

   }