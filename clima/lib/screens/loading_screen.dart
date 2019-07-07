import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const APIKEY = 'YOUR_API_KEY';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Location location = Location();
    await location.getCurrentLocation();

    double lon = location.longitude;
    double lat = location.latitude;

    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$APIKEY');

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decoded_data = jsonDecode(data);

      // temperature, condition id, City name
      double temp = decoded_data['main']['temp'];
      int condition_id = decoded_data['weather'][0]['id'];
      String city = decoded_data['name'];

      print('Temp = $temp');
      print('Condition ID: $condition_id');
      print('City: $city');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            //print(location.latitude);
            //print(location.longitude);
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
