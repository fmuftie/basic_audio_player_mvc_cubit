// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/audio_list_cubit/audio_list_cubit.dart';
import 'services/audio_service.dart';
import 'views/audio_list_page.dart';

void main() {
  // Setup dependencies
  final audioService = AudioService(jsonPath: 'assets/data/audio_data.json');

  runApp(MyApp(audioService: audioService));
}

class MyApp extends StatelessWidget {
  final AudioService audioService;

  MyApp({required this.audioService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioListCubit(audioService: audioService),
      child: MaterialApp(
        title: 'Audio Player MVC & Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AudioListPage(),
      ),
    );
  }
}
