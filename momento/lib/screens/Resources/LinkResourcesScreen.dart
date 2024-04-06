import 'package:enhanced_url_launcher/enhanced_url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class ResourcesLinksScreen extends StatelessWidget {
  const ResourcesLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),  
        title: Text(
          "Resources",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: brown2,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: resourcesData
              .map((data) => Container(
                margin:  EdgeInsets.only(bottom: 20),
                child: ListTile(
                  onTap: ()async{
                      Uri _uri = Uri.parse(data["link"]?? "google.com");
                            await launchUrl(_uri);
                  },
                  contentPadding: EdgeInsets.all(20),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: brown2,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              data["name"] ?? "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            data["desc"] ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(data["tag"] ?? "",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                          // trailing: 
                          // IconButton(
                          //   onPressed: () async {
                            
                          //   },
                          //   icon: Icon(
                          //     Icons.link,
                          //     color: Colors.white,
                          //   ),
                          // )
                    ),
              ))
              .toList()),
    );
  }
}
