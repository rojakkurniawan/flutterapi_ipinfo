import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  
  String apiToken = 'f233e8f29c8877';

  Future<Map<String, dynamic>> getIPData() async{
    final response = await http.get(Uri.parse('https://ipinfo.io/?token=$apiToken'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      throw Exception('Gagal Memuat IP data');
    }
  }

  Future<void> _refreshData() async{
    setState(() {
    });
  }

  Widget _buildInfoBox(String text){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Text(text),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('INFORMATION IP ADDRESS'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 87, 238, 82),
        ),
        body: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: getIPData(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
              if(snapshot.connectionState ==  ConnectionState.waiting){
                return CircularProgressIndicator();
              } else if (snapshot.hasError){
                return Text("Tidak Ada Koneksi Internet");
              } else {
                final data = snapshot.data!;
                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      _buildInfoBox('IP : ${data['ip']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('City : ${data['city']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('Region : ${data['region']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('Country : ${data['country']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('Location : ${data['loc']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('Organization : ${data['org']}'),
                      SizedBox(height: 10),
                      _buildInfoBox('TimeZone : ${data['timezone']}'),  
                    ],
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: _refreshData,
        child: Icon(Icons.refresh),
        backgroundColor: Color.fromARGB(255, 87, 238, 82),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}