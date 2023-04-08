import 'package:flutter/material.dart';
import 'dart:async';
import 'package:untitled1/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Time Counter'),
        '/new': (context) => const CountdownPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _onTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  void _onStart() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
  }

  void _onPause() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
    });
  }

  void _onReset() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_stopwatch.elapsed),
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isRunning
                    ? IconButton(
                  onPressed: _onPause,
                  icon: Icon(Icons.pause),
                )
                    : IconButton(
                  onPressed: _onStart,
                  icon: Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: _onReset,
                  icon: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}