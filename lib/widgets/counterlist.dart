import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/modles/counter.dart';
import 'package:revier_pode/provider/counterlist_provider.dart';
import 'package:revier_pode/widgets/add_new_item.dart';
import 'package:revier_pode/widgets/final-counters.dart';

class CounterList extends ConsumerStatefulWidget {
  const CounterList({super.key});

  @override
  ConsumerState<CounterList> createState() {
    return CounterListState();
  }
}

class CounterListState extends ConsumerState<CounterList> {
  List<Counter> counterlist = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // Await the asynchronous operation
        await ref.read(listprovider.notifier).getcounters();
        // setState to trigger a rebuild if necessary
        setState(() {});
      } catch (error) {
        // Handle any errors that occur during the async operation
        print('Error fetching counters: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    counterlist = ref.watch(listprovider);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Text(
            'Counters',
            style: TextStyle(color: Colors.white),
          ),
      backgroundColor: const Color.fromARGB(255, 4, 50, 88)),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.deepPurple,
          onPressed: () async {
            final item = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddNewItem(),
              ),
            );
            if (true) {
              setState(() async {
                ref.read(listprovider.notifier).addcounter(item as Counter);
              });
            }
          },
          child: const Icon(Icons.add_circle_outline_sharp, size: 40)),
      body: FinalCounters(counterlist: counterlist),
    ));
  }
}
