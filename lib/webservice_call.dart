import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ImageMetadata.dart';

///import 'package:async/async.dart';
Future<Image?> callWebservice() async {
  var url = Uri.parse('https://api.thecatapi.com/v1/images/search');
  var response = await http.get(url);

  debugPrint('Response status: ${response.statusCode}');
  debugPrint('Response body: ${response.body}');

  //flutter: Response status: 200
  //flutter: Response body: [{"breeds":[],"id":"d7q","url":"https://cdn2.thecatapi.com/images/d7q.jpg","width":612,"height":612}]
  //flutter: Response body: [{"breeds":[],"id":"7b1","url":"https://cdn2.thecatapi.com/images/7b1.jpg","width":500,"height":333}]
  //flutter: Response body: [{"breeds":[],"id":"c84","url":"https://cdn2.thecatapi.com/images/c84.jpg","width":900,"height":608}]
  //flutter: Response body: [{"breeds":[],"id":"3fo","url":"https://cdn2.thecatapi.com/images/3fo.jpg","width":500,"height":334}]

  if (response.statusCode == 200) {
    // the body it is a json array => parse it
    var jsonArray = jsonDecode(response.body) as List<
        dynamic>; //debugPrint('jsonArray.runtimeType: ${jsonArray.runtimeType}');

    var firstElement = jsonArray.first;  //debugPrint('firstElement.runtimeType: ${firstElement.runtimeType}');

    ImageMetadata imageMetadata = ImageMetadata.fromJson(firstElement);

    debugPrint('Loading image from : ${imageMetadata.url}');
    //flutter: Loading image from : https://cdn2.thecatapi.com/images/3fo.jpg
    return Image.network(imageMetadata.url);
  }
  // response code it is not 200
  return null;
}