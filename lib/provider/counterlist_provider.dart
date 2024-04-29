import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/modles/counter.dart';

class counterlistProvider extends StateNotifier<List<Counter>>
{
  counterlistProvider(super.state);
  final url = Uri.https('your-firebase-project.firebaseio.com','counter_list.json');

   Color chnagetocolor(String colorstring)
  {
     Color send=Colors.black;
    final hexRegex = RegExp(r'0x[0-9a-fA-F]{8}');
     final hexMatch = hexRegex.firstMatch(colorstring);
        if (hexMatch != null) 
        {
          final hexColor = hexMatch.group(0)!;
          final colorInt = int.parse(hexColor.substring(2), radix: 16); // Convert hex to integer
          send= Color(colorInt);
          
        }
        return send;
  }

    Future getcounters() async
  {
    List<Counter> list=[];
    final response = await http.get(url);
    final Map<String,dynamic> listdata=json.decode(response.body);
  for(final item in listdata.entries)
  {       
     list.add(Counter(id: item.key, title:item.value['title'], 
      color: chnagetocolor(item.value['color']),count: item.value['count']));      
  }
  state=list ;
     
  }
 
  void addcounter(Counter item)
  {
      http.post(url, headers: {'Content-Type':'application/json'},
      body: json.encode({'title': item.title, 'color': item.color.toString(),'count':item.count}));
      Timer(const Duration(seconds: 1), () {
          getcounters();
     });
  }
     
  void removecounter(Counter item)
  {
     final url = Uri.https('your-firebase-project.firebaseio.com',
      'counter_list/${item.id}.json');
      state.removeAt(state.indexOf(item));
      http.delete(url);
  }

    
  void updatecounter(Counter item, int newCount) async
  {
     final url = Uri.https('your-firebase-project.firebaseio.com',
      'counter_list/${item.id}.json');
      final response = await http.get(url);
      final Map<String,dynamic> existingData =json.decode(response.body);
      existingData['count'] = newCount;
      http.put((url),
      body: json.encode(existingData),
    );
  }
  
}

final listprovider=StateNotifierProvider<counterlistProvider,List<Counter>>
((ref) => counterlistProvider([]));