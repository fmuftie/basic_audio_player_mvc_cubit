// lib/controllers/audio_player_cubit/audio_player_state.dart

import 'package:equatable/equatable.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object> get props => [];
}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {}

class AudioPlayerPaused extends AudioPlayerState {}

class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(this.message);

  @override
  List<Object> get props => [message];
}
