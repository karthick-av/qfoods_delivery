import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qfoods_delivery/Model/ProfileModel.dart';
import 'package:qfoods_delivery/Navigation/DrawerMenu.dart';
import 'package:qfoods_delivery/constants/api_services.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel? profile;

 void initState(){
ProfileHandler();
  super.initState();
 }

  Future<void> ProfileHandler() async{
  
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  final person_id = await prefs.getInt("person_id") ?? null;
  if(person_id == null) return;
  try{
    var response = await http.get(Uri.parse("${ApiServices.profile}${person_id}"));
    print(response.statusCode);
    
    if(response.statusCode == 200){
       var response_body = json.decode(response.body);
      ProfileModel _profile = ProfileModel.fromJson(response_body);
      if(_profile?.personId != null){
         profile = _profile;
         setState(() { });
      }
  }
  }
  catch(e){

  }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      drawer: DrawerMenu(),
      appBar: AppBar( 
         iconTheme: IconThemeData(color: AppColors.greyBlackcolor),
        elevation: 0.5,
        backgroundColor: AppColors.whitecolor,
        
         title: Text('Profile',style: TextStyle(color: AppColors.greyBlackcolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(16))),
         
      ),
      body: RefreshIndicator( 
        onRefresh: () async{
          await ProfileHandler;
        },
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
         Center(
           child: Container(
            margin: const EdgeInsets.only(top: 20),
              width: width * 0.95,
              padding: const EdgeInsets.all(10),
                                             decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 20,
                                        color: const Color(0xFFB0CCE1).withOpacity(0.29),
                                      ),
                                    ],
                                  ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        Container(
               width: ScreenUtil().setWidth(50),
               height: ScreenUtil().setHeight(50),
               decoration: BoxDecoration(
                 color: const Color(0xff7c94b6),
                 image: DecorationImage(
                   image: NetworkImage('${profile?.image ?? ''}'),
                   fit: BoxFit.cover,
                 ),
                 borderRadius: BorderRadius.all( Radius.circular(50.0)),
                
               ),
             ),

             Container(
              margin: const EdgeInsets.only(left: 10),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${profile?.name ?? ''}", style: TextStyle(color: AppColors.pricecolor, fontSize: ScreenUtil().setSp(14), fontFamily: FONT_FAMILY, fontWeight: FontWeight.w500),),
                 SizedBox(height: 3,),
                  Text("${profile?.phoneNumber ?? ''}", style: TextStyle(color: AppColors.pricecolor, fontSize: ScreenUtil().setSp(14), fontFamily: FONT_FAMILY),),
                ],
               ),
             )

                            ],
                          ),
                        ),
         ),
            
 Center(
           child: Container(
            margin: const EdgeInsets.only(top: 20),
              width: width * 0.95,
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 20,
                                        color: const Color(0xFFB0CCE1).withOpacity(0.29),
                                      ),
                                    ],
                                  ),
                          alignment: Alignment.centerLeft,
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Today Delivered Orders", style: TextStyle(color: AppColors.greyBlackcolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14.5), fontWeight: FontWeight.w600),),
                      SizedBox(height: 8,),
                        Center(
                          child: Container(
                            width: width * 0.70,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                    width: width * 0.30,
             
                                  decoration: BoxDecoration( 
                                    borderRadius: BorderRadius.circular(8),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFF8BC6EC)
                                          .withOpacity(0.6),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                   Color(0xFF8BC6EC),
                                 Color(0xFF9599E2) ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),

                                  ),
                                  child: Column(
                                    children: [
                                      Text("Restaurant", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                        ,SizedBox(height: 5,),
                                        
                                        Text("${profile?.todayTotalDeliveredOrders ?? 0}", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                  ],
                                  ),
                                ),


                                     Container(
                                  padding: const EdgeInsets.all(10),
                                    width: width * 0.30,
             
                                  decoration: BoxDecoration( 
                                    borderRadius: BorderRadius.circular(8),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFF5C5EDD)
                                          .withOpacity(0.6),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                   Color(0xFF738AE6),
                                 Color(0xFF5C5EDD) ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),

                                  ),
                                  child: Column(
                                    children: [
                                      Text("Grocery", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                        ,SizedBox(height: 5,),
                                        
                                        Text("${profile?.todayTotalGroceryDeliveredOrders}", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                  ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),    
           )
 ),

SizedBox(height: 10,),


 Center(
           child: Container(
            margin: const EdgeInsets.only(top: 20),
              width: width * 0.95,
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 20,
                                        color: const Color(0xFFB0CCE1).withOpacity(0.29),
                                      ),
                                    ],
                                  ),
                          alignment: Alignment.centerLeft,
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Total Delivered Orders", style: TextStyle(color: AppColors.greyBlackcolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14.5), fontWeight: FontWeight.w600),),
                      SizedBox(height: 8,),
                        Center(
                          child: Container(
                            width: width * 0.70,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                    width: width * 0.30,
             
                                  decoration: BoxDecoration( 
                                    borderRadius: BorderRadius.circular(8),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFFFFB295)
                                          .withOpacity(0.6),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                   Color(0xFFFA7D82),
                                 Color(0xFFFFB295) ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),

                                  ),
                                  child: Column(
                                    children: [
                                      Text("Restaurant", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                        ,SizedBox(height: 5,),
                                        
                                        Text("${profile?.todayTotalDeliveredOrders ?? 0}", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                  ],
                                  ),
                                ),


                                     Container(
                                  padding: const EdgeInsets.all(10),
                                    width: width * 0.30,
             
                                  decoration: BoxDecoration( 
                                    borderRadius: BorderRadius.circular(8),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFF5C5EDD)
                                          .withOpacity(0.6),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                   Color(0xFF738AE6),
                                 Color(0xFF5C5EDD) ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),

                                  ),
                                  child: Column(
                                    children: [
                                      Text("Grocery", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                        ,SizedBox(height: 5,),
                                        
                                        Text("${profile?.totalGroceryDeliveredOrders}", style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),)
                                  ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),    
           )
 ),

                SizedBox(height: height * 0.80,)
            ],
          ),
        ),
      ),
    );
  }
}