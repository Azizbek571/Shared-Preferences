import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_prefs/models/theme_settings.dart';
import 'package:shared_prefs/pages/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeSettings())],
      child: Consumer<ThemeSettings>(builder: (context, value, child) {
        return value.doneLoading
            ? MaterialApp(
                theme: value.darkTheme ? darkTheme : lightTheme,
                home: const Settings(),
              )
            : LoadingScreen(context: context);
      }),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, required this.context});
  final BuildContext context;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await Future.delayed(Duration(seconds: 4));
    widget.context.read<ThemeSettings>().doneLoading = true;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/go.jpg'),
              Text('Getting the magic ready.....please wait.....'),
            ],
          ),
        ),
      ),
    );
  }
}
