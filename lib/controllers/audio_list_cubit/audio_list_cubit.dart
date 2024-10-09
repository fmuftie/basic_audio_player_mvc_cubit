// lib/controllers/audio_list_cubit/audio_list_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_list_state.dart';
import '../../services/audio_service.dart';
import '../../models/audio_model.dart';

class AudioListCubit extends Cubit<AudioListState> {
  final AudioService audioService;

  AudioListCubit({required this.audioService}) : super(AudioListInitial());

  Future<void> fetchAudios() async {
    emit(AudioListLoading());
    try {
      final List<AudioModel> audios = await audioService.fetchAudios();
      emit(AudioListLoaded(audios));
    } catch (e) {
      emit(AudioListError('Gagal memuat data audio.'));
    }
  }
}
