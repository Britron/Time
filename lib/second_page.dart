import 'package:flutter/material.dart';
import 'dart:async';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _timer;
  int _countdown = 0;

  final _countdownController = TextEditingController();

  @override
  void dispose() {
    _timer.cancel();
    _countdownController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = int.parse(_countdownController.text);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    if (_countdown == 0) {
      timer.cancel();
    } else {
      setState(() {
        _countdown--;
      });
    }
  }

  String _formatTime(int time) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitSeconds = twoDigits(time.remainder(60));
    return "${twoDigits(time ~/ 60)}:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _countdownController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter countdown duration in seconds',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startCountdown,
              child: const Text('Start Countdown'),
            ),
            const SizedBox(height: 20),
            Text(
              _formatTime(_countdown),
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
