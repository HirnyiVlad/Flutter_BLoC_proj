import 'package:flutter/material.dart';
import 'package:space_scutum_task/tasks/bloc/task_bloc.dart';
import 'package:space_scutum_task/tasks/ui/task_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum_task/weather/ui/weather_screen.dart';

import 'data/network_provider/weather_api_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc()..add(LoadTaskCounter()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Screen',
        home: TaskScreen(),
      ),
    );
  }
}
