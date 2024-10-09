// lib/controllers/audio_list_cubit/audio_list_state.dart

import 'package:equatable/equatable.dart';
import '../../models/audio_model.dart';

abstract class AudioListState extends Equatable {
  const AudioListState();

  @override
  List<Object> get props => [];
}

class AudioListInitial extends AudioListState {}

class AudioListLoading extends AudioListState {}

class AudioListLoaded extends AudioListState {
  final List<AudioModel> audios;

  const AudioListLoaded(this.audios);

  @override
  List<Object> get props => [audios];
}

class AudioListError extends AudioListState {
  final String message;

  const AudioListError(this.message);

  @override
  List<Object> get props => [message];
}
