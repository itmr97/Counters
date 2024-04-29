import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/modles/counter.dart';
import 'package:revier_pode/modles/responsive%20.dart';
import 'package:revier_pode/provider/counterlist_provider.dart';

class CounterItem extends ConsumerStatefulWidget
{
 const CounterItem({super.key, required this.counter});

  final Counter counter;
  
  ConsumerState<CounterItem> createState() {
   
    return CounterItemState();
  }
}

class CounterItemState extends ConsumerState<CounterItem>
{
    @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 90,
      child: Container(
        width:  Responsive.isDesktop(context)?700 : Responsive.isTablet(context)?600
                :Responsive.isMobile(context)?400:400,
        child: Card(
          elevation: 5,
            margin: const EdgeInsets.all(10),
          color: widget.counter.color,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                setState(() {
                  widget.counter.count-=1;
                  ref.read(listprovider.notifier).updatecounter(widget.counter, widget.counter.count);
                });
              }, 
              icon: const Icon(Icons.remove_circle,size: 35,)),
              const SizedBox(width: 50,),
              Column(
                children: [
                  Text(widget.counter.title,
                    style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
                  Text(widget.counter.count.toString(),
                    style:  TextStyle(
                    fontSize: Responsive.isMobile(context)? 20 :25 ,
                    fontWeight: FontWeight.w600
                  ),)
                ],
              ),
               const SizedBox(width: 50,),
              IconButton(onPressed: (){
                  setState(() {
                  widget.counter.count+=1;
                 ref.read(listprovider.notifier).updatecounter(widget.counter, widget.counter.count);
        
                });
              }, icon: const Icon(Icons.add_circle,size: 35)),
            ],
          ),
        ),
      ),
    );
  
}

}
 


