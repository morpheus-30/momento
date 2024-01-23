class Music {
  String? artistName;
  String trackId;
  String? songName;
  Duration? duration;
  Music(
      {this.artistName,
      this.songName,
      this.duration,
      required this.trackId});
}
