import 'dart:async';
import 'package:books/geolocation.dart';
import 'package:books/navigation_dialog.dart';
import 'package:books/navigation_first.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const NavigationDialogScreen(),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

int appCounter = 0;

class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
  }

  Future deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;
    await prefs.setInt('appCounter', appCounter);
    setState(() {
      appCounter = appCounter;
    });
  }

  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  void returnFG() {
    // FutureGroup<int> futureGroup = FutureGroup<int>();
    // futureGroup.add(returnOneAsync());
    // futureGroup.add(returnTwoAsync());
    // futureGroup.add(returnThreeAsync());
    // futureGroup.close();
    // futureGroup.future.then((List<int> value) {
    //   int total = 0;
    //   for (var element in value) {
    //     total += element;
    //   }
    //   setState(() {
    //     result = total.toString();
    //   });
    // });

    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);
    futures.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (_) {
      completer.completeError({});
    }
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/OmLeEAAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Back from the Future (Lukman)'),
        title: const Text('Shared Preferences'),
      ),
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('You have opened the app $appCounter times.'),
            ElevatedButton(
              onPressed: () {
                deletePreference();
              },
              child: const Text('Reset counter'),
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       const Spacer(),
      //       ElevatedButton(
      //         child: const Text('GO!'),
      //         onPressed: () {
      //           // setState(() {});
      //           // getData().then((value) {
      //           //   result = value.body.toString().substring(0, 450);
      //           //   setState(() {});
      //           // }).catchError((_) {
      //           //   result = 'An error occurred';
      //           //   setState(() {});
      //           // });
      //
      //           // count();
      //
      //           // getNumber().then((value) {
      //           //   setState(() {
      //           //     result = value.toString();
      //           //   });
      //           // }).catchError((e) {
      //           //   result = 'An error occurred';
      //           // });
      //
      //           // returnFG();
      //
      //           // returnError().then((value) {
      //           //   setState(() {
      //           //     result = "Success";
      //           //   });
      //           // }).catchError((onError) {
      //           //   setState(() {
      //           //     result = onError.toString();
      //           //   });
      //           // }).whenComplete(() => print('Complete'));
      //
      //           handleError();
      //         },
      //       ),
      //       const Spacer(),
      //       Text(result),
      //       const Spacer(),
      //       const CircularProgressIndicator(),
      //       const Spacer(),
      //     ],
      //   ),
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
