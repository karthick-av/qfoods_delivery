

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qfoods_delivery/Model/GroceryOrderModel.dart';
import 'package:qfoods_delivery/Model/OrderModel.dart';
import 'package:qfoods_delivery/constants/colors.dart';
import 'package:qfoods_delivery/constants/font_family.dart';

Future<void> StatusBottomSheet(BuildContext context, OrderModel? order, Function APIHandler) async{
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  int? selected_status = order?.status == 0 ?  0 : order?.status;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
     shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0)
     ),
  ),
    builder: (context) {
   
 return StatefulBuilder(
                              builder: (BuildContext ctx, StateSetter mystate) {
                                            return DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.6,
                expand: false,
                builder: (context, controller) {
                
                    return Container(
                        height: height * 0.60,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                              Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status", style: TextStyle(color: AppColors.blackcolor, fontSize: ScreenUtil().setSp(18), fontFamily: FONT_FAMILY, fontWeight: FontWeight.bold),)
                               
                                  ,
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                    child: Icon(Icons.close, color: AppColors.blackcolor, size: ScreenUtil().setSp(20),),
                                      ),
                                  ),
                                  
                                  
                                ],
                               ),
                             ),
                             Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    ListView.builder(
                                      padding:  const EdgeInsets.all(10),
                                      shrinkWrap: true,
                                      itemCount: order?.orderStatus?.length,
                                      itemBuilder: ((context, index) {
                                     print("${order?.status}  ${order?.orderStatus?[index]?.statusId}");
                                      return InkWell(
                                        onTap: (){
                                          selected_status = order?.orderStatus?[index]?.statusId;
                                          mystate(() {});
                                        },
                                        child: Container(
                                             padding:  const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(top: 13),
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0XFFe9e9eb)))
                                        ),
                                          child: Row(
                                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                            children: [
                                             Text(order?.orderStatus?[index]?.status ?? '',
                                             style: TextStyle(color: AppColors.pricecolor, fontSize: ScreenUtil().setSp(14), fontFamily: FONT_FAMILY, fontWeight: FontWeight.w500),
                                            
                                             ),
                                      
                                             order?.orderStatus?[index]?.statusId == selected_status
                                             ?
                                             Container(
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                      color: AppColors.primaryColor
                                                ),
                                                child: Icon(Icons.done, color: AppColors.whitecolor, size: ScreenUtil().setSp(18),),
                                              )
                                      
                                           :                                             Container(
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                  border: Border.all(color: AppColors.pricecolor.withOpacity(0.5))
                                                ),
                                              )
                                      
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                                    
                                   Container(
                                    width: width,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        APIHandler(selected_status);
                                      },
                                      child: Container(
                                        width: width * 0.90,
                                        margin: EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Text("Change Status",
                                        style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                   )
                                  ],
                                ))   
                               
                          ],
                        ),
                    );
                });

                              });
    }
  );
}


Future<void> GroceryStatusBottomSheet(BuildContext context, GroceryOrderModel? order, Function APIHandler) async{
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  int? selected_status = order?.status == 0 ?  0 : order?.status;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
     shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0)
     ),
  ),
    builder: (context) {
   
 return StatefulBuilder(
                              builder: (BuildContext ctx, StateSetter mystate) {
                                            return DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.6,
                expand: false,
                builder: (context, controller) {
                
                    return Container(
                        height: height * 0.60,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                              Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status", style: TextStyle(color: AppColors.blackcolor, fontSize: ScreenUtil().setSp(18), fontFamily: FONT_FAMILY, fontWeight: FontWeight.bold),)
                               
                                  ,
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                    child: Icon(Icons.close, color: AppColors.blackcolor, size: ScreenUtil().setSp(20),),
                                      ),
                                  ),
                                  
                                  
                                ],
                               ),
                             ),
                             Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    ListView.builder(
                                      padding:  const EdgeInsets.all(10),
                                      shrinkWrap: true,
                                      itemCount: order?.orderStatus?.length,
                                      itemBuilder: ((context, index) {
                                     print("${order?.status}  ${order?.orderStatus?[index]?.statusId}");
                                      return InkWell(
                                        onTap: (){
                                          selected_status = order?.orderStatus?[index]?.statusId;
                                          mystate(() {});
                                        },
                                        child: Container(
                                             padding:  const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(top: 13),
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0XFFe9e9eb)))
                                        ),
                                          child: Row(
                                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                            children: [
                                             Text(order?.orderStatus?[index]?.status ?? '',
                                             style: TextStyle(color: AppColors.pricecolor, fontSize: ScreenUtil().setSp(14), fontFamily: FONT_FAMILY, fontWeight: FontWeight.w500),
                                            
                                             ),
                                      
                                             order?.orderStatus?[index]?.statusId == selected_status
                                             ?
                                             Container(
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                      color: AppColors.primaryColor
                                                ),
                                                child: Icon(Icons.done, color: AppColors.whitecolor, size: ScreenUtil().setSp(18),),
                                              )
                                      
                                           :                                             Container(
                                                height: ScreenUtil().setHeight(17),
                                                width: ScreenUtil().setHeight(17),
                                                decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                  border: Border.all(color: AppColors.pricecolor.withOpacity(0.5))
                                                ),
                                              )
                                      
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                                    
                                   Container(
                                    width: width,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        APIHandler(selected_status);
                                      },
                                      child: Container(
                                        width: width * 0.90,
                                        margin: EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Text("Change Status",
                                        style: TextStyle(color: AppColors.whitecolor, fontFamily: FONT_FAMILY, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                   )
                                  ],
                                ))   
                               
                          ],
                        ),
                    );
                });

                              });
    }
  );
}