import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedimage = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ui Demo'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('SellerProduct').doc('Torch').snapshots(),
          builder: (context,imagesnapshot){
            if(imagesnapshot.hasData)
              {
               return  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('Order').doc('+919512676561-12').snapshots(),
                    builder: (context,orderSnapshot){
                      if(orderSnapshot.hasData)
                      {
                        return Column(
                          children: [
                            Container(
                                width: width,
                                height: height / 3,
                                //decoration: BoxDecoration(color: Colors.grey[100]),
                                child: Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (selectedimage > 0) {
                                                selectedimage = selectedimage - 1;
                                              }
                                            });
                                          },
                                          icon: selectedimage > 0
                                              ? Icon(Icons.arrow_back)
                                              : Icon(
                                            Icons.repeat,
                                            color: Colors.transparent,
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Image(
                                          image: NetworkImage(imagesnapshot
                                              .data['Images'][selectedimage]),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (selectedimage <
                                                imagesnapshot.data['Images'].length -
                                                    1) {
                                              setState(() {
                                                selectedimage = selectedimage + 1;
                                              });
                                            }
                                          },
                                          icon: selectedimage <
                                              imagesnapshot.data['Images'].length - 1
                                              ? Icon(Icons.arrow_forward)
                                              : Icon(
                                            Icons.repeat,
                                            color: Colors.transparent,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        );

                      }
                      else{
                        return CircularProgressIndicator(
                            semanticsLabel:'Loading' ,
                            valueColor:AlwaysStoppedAnimation<Color>(Colors.red),

                            backgroundColor: Colors.red
                        );
                      }
                    }
                );
              }
            else{
              return CircularProgressIndicator(
                  semanticsLabel:'Loading' ,
                  valueColor:AlwaysStoppedAnimation<Color>(Colors.red),

                  backgroundColor: Colors.red
              );
            }
          }
        ),
      ),
    );
  }
}
