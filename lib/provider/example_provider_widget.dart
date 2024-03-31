import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CounterNotifier extends ChangeNotifier {
  int _count1 = 0;

  int get count1 => _count1;

  int _count2 = 0;

  int get count2 => _count2;

  void increment1() {
    _count1++; // Modifying the internal mutable state
    notifyListeners(); // Notifying listeners about the state change
  }

  void increment2() {
    _count2++;
    notifyListeners(); // Notifying listeners about the state change
  }
}

class ProviderDemoApp extends StatefulWidget {
  const ProviderDemoApp({super.key});

  @override
  State<ProviderDemoApp> createState() => _ProviderDemoAppState();
}

class _ProviderDemoAppState extends State<ProviderDemoApp> {
  ValueNotifier<int> _counterValue3 = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _counterValue3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider.value(
      value: _counterValue3,
      child: ChangeNotifierProvider(
        create: (context) => CounterNotifier(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ProviderDemoApp'),
          ),
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Provider_Example1(),
              _Provider_Example2(),
              _Provider_Example3(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _counterValue3.value = _counterValue3.value + 1;
            },
          ),
        ),
      ),
    );
  }
}

class _Provider_Example1 extends StatelessWidget {
  const _Provider_Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final counterValue =
          context.select<CounterNotifier, int>((model) => model.count1);

      print('Example1 - build - value1: ${counterValue}');
      return ElevatedButton(
        onPressed: () {
          context.read<CounterNotifier>().increment2();
        },
        child: Text('Example1 btn - ${counterValue}'),
      );
    });
  }
}

class _Provider_Example2 extends StatelessWidget {
  const _Provider_Example2({super.key});

  @override
  Widget build(BuildContext context) {
    final counterValue =
        context.select<CounterNotifier, int>((model) => model.count2);

    print('Example2 - build - value2: ${counterValue}');
    return ElevatedButton(
      onPressed: () {
        context.read<CounterNotifier>().increment1();
      },
      child: Text('Example2 btn - $counterValue'),
    );
  }
}

class _Provider_Example3 extends StatelessWidget {
  const _Provider_Example3({super.key});

  @override
  Widget build(BuildContext context) {
    final counterValue = context.watch<int>();
    print('Example3 - build - value3: ${counterValue}');
    return ElevatedButton(
      onPressed: () {},
      child: Text('Example3 btn - $counterValue'),
    );
  }
}
