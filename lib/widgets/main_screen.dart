import 'package:flutter/material.dart';
import 'package:revier_pode/modles/responsive%20.dart';
import 'package:revier_pode/widgets/counterlist.dart';

class MainScreen extends StatelessWidget
{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Responsive
      (desktop: Container( child: const CounterList(),),
      tablet: Container
        (
          child: const CounterList(),

        ),

       mobile: Container
       (
        child: const CounterList(),

       ),
        )
    );
  }
  
}