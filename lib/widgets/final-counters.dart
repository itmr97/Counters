import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/modles/counter.dart';
import 'package:revier_pode/provider/counterlist_provider.dart';
import 'package:revier_pode/widgets/counter_item.dart';

class FinalCounters extends ConsumerStatefulWidget {
  const FinalCounters({super.key, required this.counterlist});

  final List<Counter> counterlist;

  @override
  ConsumerState<FinalCounters> createState()
   {
    return FinalCountersState();
  }
}

class FinalCountersState extends ConsumerState<FinalCounters> 
{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.counterlist.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(widget.counterlist[index]),
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
            ),
            onDismissed: (dic) {
              ref.read(listprovider.notifier).removecounter(widget.counterlist[index]);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item Removed'),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterItem(counter: widget.counterlist[index]),
              ],
            ),
          );
        });
  }
}
