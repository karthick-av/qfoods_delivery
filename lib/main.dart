import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qfoods_delivery/Navigation/Navigation.dart';
import 'package:qfoods_delivery/Provider/OrdersProvider.dart';
import 'package:qfoods_delivery/Screens/LoginScreen/LoginScreen.dart';
import 'package:qfoods_delivery/Services/Notification_Services.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message?.notification?.title}');
  if(message.notification != null){
  NotificationService.createNotification(message, "background");
}
}


void main() async{
 WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
NotificationService.initalize();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = ((prefs.getBool('isLogged') == null) ? false : prefs.getBool('isLogged')) ?? false;
 
 runApp(MultiProvider(
   providers: [
        ChangeNotifierProvider(create: ((context) => OrdersProvider())),
    
          ],
   child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        title: 'Qfoods Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        
          primarySwatch: Colors.red,
        ),
        home:  ScreenUtilInit(
           designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
              builder: ((context, child) {
                return SafeArea(child: isLoggedIn ? Navigation() : LoginScreen());
              }),
             )
      ),),
 ));
}
