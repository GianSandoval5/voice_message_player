//ignore_for_file: no_wildcard_variable_uses, avoid_print, must_be_immutable, library_prefixes, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as jsAudio;
import 'package:voice_message_package/src/contact_noises.dart';
import 'package:voice_message_package/src/helpers/utils.dart';
import 'package:voice_message_package/src/helpers/widgets.dart';
import 'package:voice_message_package/src/noises.dart';

import 'helpers/colors.dart';

// class VoiceMessage extends StatefulWidget {
//   VoiceMessage({
//     super.key,
//     required this.me,
//     this.audioSrc,
//     this.audioFile,
//     this.duration,
//     this.formatDuration,
//     this.showDuration = false,
//     this.waveForm,
//     this.noiseCount = 27,
//     this.meBgColor = AppColors.mar,
//     this.contactBgColor = AppColors.mar,
//     this.contactFgColor = AppColors.marOscure,
//     this.contactCircleColor = Colors.red,
//     this.mePlayIconColor = AppColors.marOscure,
//     this.contactPlayIconColor = Colors.black26,
//     this.radius = 12,
//     this.contactPlayIconBgColor = AppColors.marOscure,
//     this.meFgColor = AppColors.headerColor,
//     this.played = false,
//     this.onPlay,
//   });

//   final String? audioSrc;
//   Future<File>? audioFile;
//   final Duration? duration;
//   final bool showDuration;
//   final List<double>? waveForm;
//   final double radius;

//   final int noiseCount;
//   final Color meBgColor,
//       meFgColor,
//       contactBgColor,
//       contactFgColor,
//       contactCircleColor,
//       mePlayIconColor,
//       contactPlayIconColor,
//       contactPlayIconBgColor;
//   final bool played, me;
//   Function()? onPlay;
//   String Function(Duration duration)? formatDuration;

//   @override
//   _VoiceMessageState createState() => _VoiceMessageState();
// }

// class _VoiceMessageState extends State<VoiceMessage>
//     with SingleTickerProviderStateMixin {
//   static AudioPlayer? _currentlyPlaying;
//   late StreamSubscription stream;
//   final AudioPlayer _player = AudioPlayer();
//   final double maxNoiseHeight = 6.w(), noiseWidth = 29.w();
//   Duration? _audioDuration;
//   double maxDurationForSlider = .0000001;
//   bool _isPlaying = false, _audioConfigurationDone = false;
//   int duration = 0;
//   String _remainingTime = '';
//   AnimationController? _controller;
//   double _playbackSpeed = 1.0;

//   @override
//   void initState() {
//     widget.formatDuration ??= (Duration duration) {
//       return duration.toString().substring(2, 7);
//     };

//     _setDuration();
//     super.initState();
//     stream = _player.onPlayerStateChanged.listen((event) {
//       switch (event) {
//         case PlayerState.stopped:
//           break;
//         case PlayerState.playing:
//           setState(() => _isPlaying = true);
//           break;
//         case PlayerState.paused:
//           setState(() => _isPlaying = false);
//           break;
//         case PlayerState.completed:
//           _player.seek(const Duration(milliseconds: 0));
//           setState(() {
//             duration = _audioDuration!.inMilliseconds;
//             _remainingTime = widget.formatDuration!(_audioDuration!);
//             _isPlaying = false;
//           });
//           _controller?.reset();
//           break;
//         default:
//           break;
//       }
//     });
//     _player.onPositionChanged.listen(
//       (Duration p) => setState(
//         () => _remainingTime = widget.formatDuration!(_audioDuration! - p),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => _sizerChild(context);

//   Container _sizerChild(BuildContext context) => Container(
//         padding: EdgeInsets.symmetric(horizontal: .4.w()),
//         constraints: BoxConstraints(maxWidth: 100.w() * .8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(widget.radius),
//           color: widget.me ? widget.meBgColor : widget.contactBgColor,
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 2.w(), vertical: 2.8.w()),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _playButton(context),
//               SizedBox(width: 3.w()),
//               _durationWithNoise(context),
//               SizedBox(width: 2.2.w()),
//               _speed(context),
//             ],
//           ),
//         ),
//       );

//   Widget _playButton(BuildContext context) => InkWell(
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: widget.me ? widget.meFgColor : widget.contactPlayIconBgColor,
//           ),
//           width: 10.w(),
//           height: 10.w(),
//           child: InkWell(
//             onTap: () =>
//                 !_audioConfigurationDone ? null : _changePlayingStatus(),
//             child: !_audioConfigurationDone
//                 ? Container(
//                     padding: const EdgeInsets.all(8),
//                     width: 10,
//                     height: 0,
//                     child: const CircularProgressIndicator(
//                         strokeWidth: 1, color: AppColors.marOscure),
//                   )
//                 : Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: widget.me
//                         ? widget.mePlayIconColor
//                         : widget.contactPlayIconColor,
//                     size: 5.w(),
//                   ),
//           ),
//         ),
//       );

//   Widget _durationWithNoise(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _noise(context),
//           SizedBox(height: .3.w()),
//           Row(
//             children: [
//               if (!widget.played)
//                 Widgets.circle(context, 1.5.w(), AppColors.headerColor),
//               if (widget.showDuration)
//                 Padding(
//                   padding: EdgeInsets.only(left: 1.2.w()),
//                   child: Text(
//                     widget.formatDuration!(widget.duration!),
//                     style: const TextStyle(
//                         fontSize: 10, color: AppColors.headerColor),
//                   ),
//                 ),
//               SizedBox(width: 1.5.w()),
//               SizedBox(
//                 width: 50,
//                 child: Text(
//                   _remainingTime,
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: widget.me ? widget.meFgColor : widget.contactFgColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );

//   Widget _noise(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final newTheme = theme.copyWith(
//       sliderTheme: SliderThemeData(
//         trackShape: CustomTrackShape(),
//         thumbShape: SliderComponentShape.noThumb,
//         minThumbSeparation: 0,
//       ),
//     );

//     return Theme(
//       data: newTheme,
//       child: SizedBox(
//         height: 6.5.w(),
//         width: noiseWidth,
//         child: Stack(
//           clipBehavior: Clip.hardEdge,
//           children: [
//             widget.me ? const Noises() : const ContactNoise(),
//             if (_audioConfigurationDone)
//               AnimatedBuilder(
//                 animation:
//                     CurvedAnimation(parent: _controller!, curve: Curves.ease),
//                 builder: (context, child) {
//                   return Positioned(
//                     left: _controller!.value,
//                     child: Container(
//                       width: noiseWidth,
//                       height: 6.w(),
//                       color: widget.me
//                           ? widget.meBgColor.withOpacity(.4)
//                           : widget.contactBgColor.withOpacity(.35),
//                     ),
//                   );
//                 },
//               ),
//             Opacity(
//               opacity: .0,
//               child: Container(
//                 width: noiseWidth,
//                 color: Colors.amber.withOpacity(0),
//                 child: Slider(
//                   min: 0.0,
//                   max: maxDurationForSlider,
//                   onChangeStart: (__) => _stopPlaying(),
//                   onChanged: (_) => _onChangeSlider(_),
//                   value: duration + .0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _speed(BuildContext context) => InkWell(
//         onTap: () => _toggleSpeed(),
//         child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: 2.w(), vertical: 1.6.w()),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(2.8.w()),
//             color: widget.meFgColor.withOpacity(.28),
//           ),
//           width: 10.w(),
//           child: Text(
//             '${_playbackSpeed}x',
//             style: const TextStyle(fontSize: 9.8, color: AppColors.headerColor),
//           ),
//         ),
//       );

//   void _startPlaying() async {
//     await _stopPlaying();
//     //detiene la animacion de las ondas

//     await Future.delayed(const Duration(milliseconds: 100));

//     if (widget.audioFile != null) {
//       String path = (await widget.audioFile!).path;
//       debugPrint("> _startPlaying path $path");
//       await _player.play(DeviceFileSource(path));
//     } else if (widget.audioSrc != null) {
//       await _player.play(UrlSource(widget.audioSrc!));
//     } else {
//       throw Exception("Audio source and file are");
//     }

//     _currentlyPlaying = _player;

//     await _player.setPlaybackRate(_playbackSpeed);
//     _controller!.forward();
//   }

//   _stopPlaying() async {
//     if (_currentlyPlaying != null &&
//         _currentlyPlaying!.state == PlayerState.playing) {
//       await _currentlyPlaying!.pause();
//       _controller!.stop();
//       _isPlaying = false;
//       setState(() {});
//     }
//   }

//   void _setDuration() async {
//     try {
//       if (widget.duration != null) {
//         _audioDuration = widget.duration;
//       } else if (widget.audioFile != null) {
//         String path = (await widget.audioFile!).path;
//         _audioDuration = await jsAudio.AudioPlayer().setFilePath(path);
//       } else if (widget.audioSrc != null) {
//         _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc!);
//       } else {
//         throw Exception("Audio source and file are both null");
//       }

//       if (_audioDuration == null) {
//         throw Exception("Failed to get audio duration");
//       }

//       duration = _audioDuration!.inMilliseconds;
//       maxDurationForSlider = duration + .0;

//       _controller = AnimationController(
//         vsync: this,
//         lowerBound: 0,
//         upperBound: noiseWidth,
//         duration: _audioDuration,
//       );

//       _controller!.addListener(() {
//         if (_controller!.isCompleted) {
//           _controller!.reset();
//           _isPlaying = false;
//           _playbackSpeed = 1.0;
//           setState(() {});
//         }
//       });
//       _setAnimationConfiguration(_audioDuration!);
//     } catch (e) {
//       print("Error in _setDuration: $e");
//     }
//   }

//   void _setAnimationConfiguration(Duration audioDuration) async {
//     if (widget.formatDuration != null) {
//       setState(() {
//         _remainingTime = widget.formatDuration!(audioDuration);
//       });
//     }
//     _completeAnimationConfiguration();
//   }

//   void _completeAnimationConfiguration() =>
//       setState(() => _audioConfigurationDone = true);

//   void _toggleSpeed() {
//     setState(() {
//       if (_playbackSpeed == 1.0) {
//         _playbackSpeed = 1.5;
//       } else if (_playbackSpeed == 1.5) {
//         _playbackSpeed = 2.0;
//       } else {
//         _playbackSpeed = 1.0;
//       }
//       _player.setPlaybackRate(_playbackSpeed);
//     });
//   }

//   void _changePlayingStatus() async {
//     if (widget.onPlay != null) widget.onPlay!();
//     _isPlaying ? _stopPlaying() : _startPlaying();
//     setState(() => _isPlaying = !_isPlaying);
//   }

//   @override
//   void dispose() {
//     stream.cancel();
//     _player.dispose();
//     _controller?.dispose();
//     super.dispose();
//   }

//   _onChangeSlider(double d) async {
//     if (_isPlaying) _changePlayingStatus();
//     duration = d.round();
//     _controller?.value = (noiseWidth) * duration / maxDurationForSlider;
//     _remainingTime = widget
//         .formatDuration!(_audioDuration! - Duration(milliseconds: duration));
//     await _player.seek(Duration(milliseconds: duration));
//     setState(() {});
//   }
// }

// class CustomTrackShape extends RoundedRectSliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     const double trackHeight = 10;
//     final double trackLeft = offset.dx,
//         trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final double trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
// }

class VoiceMessage extends StatefulWidget {
  VoiceMessage({
    super.key,
    required this.me,
    this.audioSrc,
    this.audioFile,
    this.duration,
    this.formatDuration,
    this.showDuration = false,
    this.waveForm,
    this.noiseCount = 27,
    this.meBgColor = AppColors.mar,
    this.contactBgColor = AppColors.mar,
    this.contactFgColor = AppColors.marOscure,
    this.contactCircleColor = Colors.red,
    this.mePlayIconColor = AppColors.marOscure,
    this.contactPlayIconColor = Colors.black26,
    this.radius = 12,
    this.contactPlayIconBgColor = AppColors.marOscure,
    this.meFgColor = AppColors.headerColor,
    this.played = false,
    this.onPlay,
  });

  final String? audioSrc;
  Future<File>? audioFile;
  final Duration? duration;
  final bool showDuration;
  final List<double>? waveForm;
  final double radius;

  final int noiseCount;
  final Color meBgColor,
      meFgColor,
      contactBgColor,
      contactFgColor,
      contactCircleColor,
      mePlayIconColor,
      contactPlayIconColor,
      contactPlayIconBgColor;
  final bool played, me;
  Function()? onPlay;
  String Function(Duration duration)? formatDuration;

  @override
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _player;
  late StreamSubscription<PlayerState> _stream;
  AnimationController? _controller;
  Duration? _audioDuration;
  double _playbackSpeed = 1.0;
  bool _isPlaying = false;
  bool _audioConfigurationDone = false;
  String _remainingTime = '';

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    widget.formatDuration ??= (Duration duration) {
      return duration.toString().substring(2, 7);
    };
    _stream = _player.onPlayerStateChanged.listen((event) {
      switch (event) {
        case PlayerState.stopped:
          break;
        case PlayerState.playing:
          setState(() => _isPlaying = true);
          break;
        case PlayerState.paused:
          setState(() => _isPlaying = false);
          break;
        case PlayerState.completed:
          _player.seek(const Duration(milliseconds: 0));
          setState(() {
            _remainingTime = widget.formatDuration!(_audioDuration!);
            _isPlaying = false;
          });
          _controller?.reset();
          break;
        default:
          break;
      }
    });
    _player.onPositionChanged.listen(
      (Duration p) => setState(
        () => _remainingTime = widget.formatDuration!(_audioDuration! - p),
      ),
    );
    _setDuration();
  }

  @override
  void dispose() {
    _stream.cancel();
    _player.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _audioConfigurationDone
        ? _buildVoiceMessage()
        : _buildLoadingIndicator();
  }

  Widget _buildLoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: const CircularProgressIndicator(
        strokeWidth: 1,
        color: AppColors.marOscure,
      ),
    );
  }

  Widget _buildVoiceMessage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: .4.w()),
      constraints: BoxConstraints(maxWidth: 100.w() * .8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        color: widget.me ? widget.meBgColor : widget.contactBgColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w(), vertical: 2.8.w()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPlayButton(),
            SizedBox(width: 3.w()),
            _buildDurationWithNoise(),
            SizedBox(width: 2.2.w()),
            _buildSpeed(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return InkWell(
      onTap: () => _audioConfigurationDone ? _changePlayingStatus() : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.me ? widget.meFgColor : widget.contactPlayIconBgColor,
        ),
        width: 10.w(),
        height: 10.w(),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: _isPlaying
              ? (widget.me
                  ? widget.mePlayIconColor
                  : widget.contactPlayIconColor)
              : Colors.grey,
          size: 5.w(),
        ),
      ),
    );
  }

  Widget _buildDurationWithNoise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNoise(),
        SizedBox(height: .3.w()),
        Row(
          children: [
            if (!widget.played)
              Widgets.circle(context, 1.5.w(), AppColors.headerColor),
            if (widget.showDuration)
              Padding(
                padding: EdgeInsets.only(left: 1.2.w()),
                child: Text(
                  widget.formatDuration!(widget.duration!),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.headerColor,
                  ),
                ),
              ),
            SizedBox(width: 1.5.w()),
            SizedBox(
              width: 50,
              child: Text(
                _remainingTime,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.me ? widget.meFgColor : widget.contactFgColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoise() {
    final ThemeData theme = Theme.of(context);
    final newTheme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
    );

    return Theme(
      data: newTheme,
      child: SizedBox(
        height: 6.5.w(),
        width: 29.w(),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            widget.me ? const Noises() : const ContactNoise(),
            if (_audioConfigurationDone)
              AnimatedBuilder(
                animation:
                    CurvedAnimation(parent: _controller!, curve: Curves.ease),
                builder: (context, child) {
                  return Positioned(
                    left: _controller!.value,
                    child: Container(
                      width: 29.w(),
                      height: 6.w(),
                      color: widget.me
                          ? widget.meBgColor.withOpacity(.4)
                          : widget.contactBgColor.withOpacity(.35),
                    ),
                  );
                },
              ),
            Opacity(
              opacity: .0,
              child: Container(
                width: 29.w(),
                color: Colors.amber.withOpacity(0),
                child: Slider(
                  min: 0.0,
                  max: _audioDuration!.inMilliseconds.toDouble(),
                  onChangeStart: (__) => _stopPlaying(),
                  onChanged: (_) => _onChangeSlider(_),
                  value: _audioDuration!.inMilliseconds.toDouble(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeed() {
    return InkWell(
      onTap: () => _toggleSpeed(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.w(), vertical: 1.6.w()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.8.w()),
          color: widget.meFgColor.withOpacity(.28),
        ),
        width: 10.w(),
        child: Text(
          '${_playbackSpeed}x',
          style: const TextStyle(
            fontSize: 9.8,
            color: AppColors.headerColor,
          ),
        ),
      ),
    );
  }

  void _startPlaying() async {
    await _stopPlaying();
    await Future.delayed(const Duration(milliseconds: 100));

    if (widget.audioFile != null) {
      String path = (await widget.audioFile!).path;
      await _player.play(DeviceFileSource(path));
    } else if (widget.audioSrc != null) {
      await _player.play(UrlSource(widget.audioSrc!));
    } else {
      throw Exception("Audio source and file are both null");
    }

    await _player.setPlaybackRate(_playbackSpeed);
    _audioConfigurationDone = true;
    _controller!.forward();
  }

  Future<void> _stopPlaying() async {
    if (_player.state == PlayerState.playing) {
      await _player.pause();
      _controller!.stop();
      _isPlaying = false;
      setState(() {});
    }
  }

  void _setDuration() async {
    try {
      if (widget.duration != null) {
        _audioDuration = widget.duration;
      } else if (widget.audioFile != null) {
        String path = (await widget.audioFile!).path;
        _audioDuration = await jsAudio.AudioPlayer().setFilePath(path);
      } else if (widget.audioSrc != null) {
        _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc!);
      } else {
        throw Exception("Audio source and file are both null");
      }

      if (_audioDuration == null) {
        throw Exception("Failed to get audio duration");
      }

      _controller = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 29.w(),
        duration: _audioDuration!,
      );

      _controller!.addListener(() {
        if (_controller!.isCompleted) {
          _controller!.reset();
          _isPlaying = false;
          _playbackSpeed = 1.0;
          setState(() {});
        }
      });

      _remainingTime = widget.formatDuration!(_audioDuration!);
    } catch (e) {
      print("Error in _setDuration: $e");
    }
  }

  void _changePlayingStatus() {
    if (_isPlaying) {
      _stopPlaying();
    } else {
      _startPlaying();
    }
    _isPlaying = !_isPlaying;
    setState(() {});
  }

  void _onChangeSlider(double value) async {
    if (_player.state == PlayerState.playing) {
      _stopPlaying();
    }
    await _player.seek(Duration(milliseconds: value.round()));
    setState(() {});
  }

  void _toggleSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
      _player.setPlaybackRate(_playbackSpeed);
    });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 10;
    final double trackLeft = offset.dx,
        trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
