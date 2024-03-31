import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InheritedDemoApp extends StatelessWidget {
  const InheritedDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedDemoApp'),
      ),
      body: const Column(
        children: [
          IH_Example1(),
          IH_Example2(),
        ],
      ),
    );
  }
}

class IH_Example1 extends StatefulWidget {
  const IH_Example1({super.key});

  @override
  State<IH_Example1> createState() => _IH_Example1State();
}

class _IH_Example1State extends State<IH_Example1> {
  @override
  Widget build(BuildContext context) {
    print(
        'Example1 - build - value1: ${IH_ExampleInheritedWidget.ofData(context, IH_ExampleAspect.value1)?.value1}');
    return Container(
      child: ElevatedButton(
        onPressed: () {
          IH_ExampleInheritedWidget.of(context)?.increment1();
        },
        child: const Text('Example1 btn'),
      ),
    );
  }
}

class IH_Example2 extends StatefulWidget {
  const IH_Example2({super.key});

  @override
  State<IH_Example2> createState() => _IH_Example2State();
}

class _IH_Example2State extends State<IH_Example2> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Example2 - didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Example2 - build - value2: ${IH_ExampleInheritedWidget.ofData(context, IH_ExampleAspect.value2)?.value2}');
    return Container(
      child: ElevatedButton(
        onPressed: () {
          IH_ExampleInheritedWidget.of(context)?.increment2();
        },
        child: const Text('Example2 btn'),
      ),
    );
  }
}

enum IH_ExampleAspect {
  value1,
  value2,
}

class IH_ExampleInheritedWidgetData {
  final int value1;
  final int value2;

  IH_ExampleInheritedWidgetData({
    required this.value1,
    required this.value2,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IH_ExampleInheritedWidgetData &&
        other.value1 == value1 &&
        other.value2 == value2;
  }

  @override
  int get hashCode => value1.hashCode ^ value2.hashCode;
}

class IH_ExampleInheritedWidget extends InheritedModel<IH_ExampleAspect> {
  final IH_ExampleInheritedWidgetData data;
  final VoidCallback increment1;
  final VoidCallback increment2;

  const IH_ExampleInheritedWidget({
    required this.increment1,
    required this.increment2,
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(covariant IH_ExampleInheritedWidget oldWidget) {
    return oldWidget.data != data;
  }

  static IH_ExampleInheritedWidgetData? ofData(BuildContext context,
      [IH_ExampleAspect? aspect]) {
    return of(context, aspect)?.data;
  }

  static IH_ExampleInheritedWidget? of(
    BuildContext context, [
    IH_ExampleAspect? aspect,
  ]) {
    return InheritedModel.inheritFrom<IH_ExampleInheritedWidget>(
      context,
      aspect: aspect,
    );
    final IH_ExampleInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<IH_ExampleInheritedWidget>();
    return result!;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant IH_ExampleInheritedWidget oldWidget,
      Set<IH_ExampleAspect> dependencies) {
    for (var element in dependencies) {
      switch (element) {
        case IH_ExampleAspect.value1:
          return data.value1 != oldWidget.data.value1;
        case IH_ExampleAspect.value2:
          return data.value2 != oldWidget.data.value2;
      }
    }
    return false;
  }
}

class IH_ExampleInheritedDataWidget extends StatefulWidget {
  final Widget child;
  const IH_ExampleInheritedDataWidget({
    super.key,
    required this.child,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<IH_ExampleInheritedDataWidget> createState() =>
      _IH_ExampleInheritedDataWidgetState();
}

class _IH_ExampleInheritedDataWidgetState
    extends State<IH_ExampleInheritedDataWidget> {
  int _counter1 = 0;
  int _counter2 = 0;

  void increment1() {
    setState(() {
      _counter1++;
    });
  }

  void increment2() {
    setState(() {
      _counter2++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return IH_ExampleInheritedWidget(
      data: IH_ExampleInheritedWidgetData(
        value1: _counter1,
        value2: _counter2,
      ),
      increment1: increment1,
      increment2: increment2,
      child: widget.child,
    );
  }
}
