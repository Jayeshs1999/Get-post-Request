import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mplushsoftproject/user_model.dart';
main(){
  runApp(
new MyApp()
  );
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: "Hello",
     home: MyExampleClass(),
   );
  }

}

class MyExampleClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("AgroPost"),
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: getUsers(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<UserModel>? user=snapshot.data;
              return ListView(
                children: user!.map((user) => Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left:12.0,right: 12),
                    child: ListTile(

                      title: Text(user.category_name,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Anitha",style: TextStyle(color: Colors.black),),
                          Row(
                            children: const [
                              Icon(Icons.location_on,color: Colors.green,),
                              Text("Tisgaon,Maharashtra"),
                            ],
                          )
                        ],
                      ),

                      trailing: Column(
                        children: const [
                          Icon(Icons.favorite_border,color: Colors.black,),
                          Text("\n\u{20B9} 34524")
                        ],
                      ),
                      leading: Image.network("https:\/\/agropost.in\/admin\/${user.img}"),
                    ),
                  ),
                )).toList(),
              );
              // return Text("Id: ${user!.id}\nName : ${user.name}");

            }else if(snapshot.hasError){

            return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }

}

Future<List<UserModel>> getUsers() async{
  http.Response response=await http.get( Uri.parse("http://www.agropost.in/admin/android/get-product-category"));
  if(response.statusCode==200){
    var user=jsonDecode(response.body);
    return (user['product_category_list'] as List).map((e) => UserModel.fromJson(e)).toList();
  }else{
    throw Exception();
  }
}