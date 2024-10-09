// lib/controllers/audio_player_cubit/audio_player_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerCubit() : super(AudioPlayerInitial());

  Future<void> playAudio(String filePath) async {
    emit(AudioPlayerLoading());
    try {
      await _audioPlayer.setAsset(filePath);
      _audioPlayer.play();
      emit(AudioPlayerPlaying());

      _audioPlayer.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          emit(AudioPlayerPaused());
        }
      });
    } catch (e) {
      emit(AudioPlayerError('Gagal memutar audio.'));
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    emit(AudioPlayerPaused());
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
