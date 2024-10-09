// lib/views/audio_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/audio_list_cubit/audio_list_cubit.dart';
import '../controllers/audio_list_cubit/audio_list_state.dart';
import 'audio_detail_page.dart';
import '../controllers/audio_player_cubit/audio_player_cubit.dart';

class AudioListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Audio'),
      ),
      body: BlocBuilder<AudioListCubit, AudioListState>(
        builder: (context, state) {
          if (state is AudioListInitial) {
            context.read<AudioListCubit>().fetchAudios();
            return Center(child: CircularProgressIndicator());
          } else if (state is AudioListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AudioListLoaded) {
            final audios = state.audios;
            return ListView.builder(
              itemCount: audios.length,
              itemBuilder: (context, index) {
                final audio = audios[index];
                return ListTile(
                  title: Text(audio.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioDetailPage(audio: audio),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is AudioListError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
