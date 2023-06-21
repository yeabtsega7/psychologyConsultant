// ignore_for_file: camel_case_types, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:psychological_consultation/src/component/videoPlayer.dart';
import 'dart:convert';

import 'package:psychological_consultation/src/conn/apicon.dart';
import 'package:psychological_consultation/src/model/appColors.dart';
import 'package:psychological_consultation/src/screen/ResourcesDetailPage.dart';
class resourcesTabVideo extends StatefulWidget {
  final String search;

  const resourcesTabVideo({
    required this.search,
    super.key,
  });

  @override
  State<resourcesTabVideo> createState() => _resourcesTabVideoState();
}

class _resourcesTabVideoState extends State<resourcesTabVideo> {

  @override
  Widget build(BuildContext context) {
    getResourcesList() async {
      String apiUrl =apiCon.apiGetListData;
      var response = await http.post(Uri.parse(apiUrl), body: {
        'table': "resource",
        'search': widget.search,
        'searchBy': "name",
        'where': "type",
        'whereValue': "video"
      });

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        return jsondata['message'];
      }
      return null;
    }

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.runtimeType.toString() ==
              "String") {
            return const Text("no resource found");
          }
          List discussionData = snapshot.data;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(context, screen: ResourcesDetailPage(discussionData[index]),withNavBar: false);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 130,
                    decoration:  BoxDecoration(
                      border: Border.all(color: appColors.textP,width: 1)
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: videoPlayer(Url: discussionData[index]['resource_url'],),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: const Color(0xF44A4B48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text( discussionData[index]['name'],style: const TextStyle(color: Colors.white,fontSize: 14),),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(softWrap: false,
                                              maxLines: 1,
                                              "by: "+discussionData[index]['uploader'],overflow: TextOverflow.fade,style: const TextStyle(color: Colors.white,fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text( discussionData[index]['description'],style: const TextStyle(color: Colors.white,fontSize: 12),
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                        ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: discussionData.length,
          );
        }
        return const Text("data");
      },
      future: getResourcesList(),
    );
  }
}
