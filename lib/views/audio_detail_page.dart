// lib/views/audio_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/audio_player_cubit/audio_player_cubit.dart';
import '../controllers/audio_player_cubit/audio_player_state.dart';
import '../models/audio_model.dart';

class AudioDetailPage extends StatelessWidget {
  final AudioModel audio;

  AudioDetailPage({required this.audio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(audio.title),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => AudioPlayerCubit(),
          child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
            builder: (context, state) {
              bool isPlaying = false;

              if (state is AudioPlayerPlaying) {
                isPlaying = true;
              } else if (state is AudioPlayerPaused || state is AudioPlayerInitial) {
                isPlaying = false;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    audio.title,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        context.read<AudioPlayerCubit>().pauseAudio();
                      } else {
                        context.read<AudioPlayerCubit>().playAudio('assets/audio/${audio.file}');
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  // Menampilkan pesan error jika ada
                  if (state is AudioPlayerError)
                    Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
