//我来给你一个音乐应用使用中介者模式的需求场景。
// 需求背景：设计一个音乐应用的播放控制系统，需要协调多个组件之间的交互。
// 主要组件包括：
//
// 音乐播放器：负责实际的音乐播放、暂停、上一首、下一首等操作
// 播放列表：管理当前的音乐队列
// 音量控制器：控制音量大小
// 均衡器：控制音频效果
// 显示界面：显示当前播放状态、歌曲信息等
// 歌词显示：同步显示歌词
//
// 交互需求：
//
// 当播放新歌曲时：
//
// 播放器需要开始播放
// 显示界面需要更新歌曲信息
// 歌词显示需要加载并同步新歌词
// 播放列表需要更新当前播放位置
//
//
// 当调整音量时：
//
// 播放器需要改变音量
// 显示界面需要更新音量显示
// 如果音量为0，显示界面需要显示静音图标
//
//
// 当调整均衡器时：
//
// 播放器需要应用新的音频效果
// 显示界面需要更新均衡器状态
//
//
// 播放列表变化时：
//
// 显示界面需要更新列表显示
// 如果当前歌曲在列表中的位置变化，需要更新相应显示
//
//
// 当歌曲播放进度变化时：
//
// 显示界面需要更新进度条
// 歌词显示需要同步到当前时间点
//
//
//
// 特殊要求：
//
// 各组件之间不能直接通信，必须通过中介者协调
// 系统要能方便地添加新的组件
// 播放状态变化时要能通知到所有相关组件
// 支持播放模式切换（单曲循环、列表循环、随机播放）
// 支持播放状态的保存和恢复
//
// 提示：
//
// 考虑设计一个抽象的中介者接口
// 为每个组件设计合适的接口和实现
// 考虑如何在中介者中协调各组件的状态
// 思考如何处理异步操作（如歌曲加载）
// 考虑如何处理错误情况（如歌曲无法播放）
class Song {
  String lyrics;

  Song(this.lyrics);
}

class EqualizerSettings {}

abstract class IMusicMediator {
  void playNewSong(Song song);

  void updateVolume(int volume);

  void updateEqualizer(EqualizerSettings settings);

  void updatePlaylist(Playlist playlist);

  void updateProgress(Duration progress);

  void savePlaybackState();

  void restorePlaybackState();
}

class MusicPlayer {
  late IMusicMediator mediator;

  void play(Song song) {
    // 播放歌曲逻辑
  }

  void pause() {
    // 暂停播放
  }

  void next() {
    // 播放下一首歌
  }

  void previous() {
    // 播放上一首歌
  }

  void setVolume(int volume) {
    // 设置音量
  }

  void applyEqualizer(EqualizerSettings settings) {
    // 应用均衡器设置
  }
}

class Playlist {
  late IMusicMediator mediator;
  List<Song> songs = [];

  void updateCurrentSong(Song song) {
    // 更新当前播放歌曲
  }

  void updatePlaylist(Playlist playlist) {
    // 更新播放列表
  }
}

class Display {
  late IMusicMediator mediator;

  void updateSongInfo(Song song) {
    // 更新歌曲信息显示
  }

  void updateVolume(int volume) {
    // 更新音量显示
  }

  void showMuteIcon() {
    // 显示静音图标
  }

  void updateEqualizerSettings(EqualizerSettings settings) {
    // 更新均衡器状态显示
  }

  void updateProgress(Duration progress) {
    // 更新进度条显示
  }

  void updatePlaylist(Playlist playlist) {
    // 更新播放列表显示
  }
}

class VolumeController {
  late IMusicMediator mediator;

  void setVolume(int volume) {
    mediator.updateVolume(volume);
  }
}

class Equalizer {
  late IMusicMediator mediator;

  void setSettings(EqualizerSettings settings) {
    mediator.updateEqualizer(settings);
  }
}

class LyricsDisplay {
  late IMusicMediator mediator;

  void loadLyrics(String lyrics) {
    // 加载新歌词
  }

  void syncLyrics(Duration progress) {
    // 根据播放进度同步歌词
  }
}

enum PlaybackMode { repeatOne, repeatAll, shuffle }

class MusicMediator implements IMusicMediator {
  final MusicPlayer _player;
  final Display _display;
  final Playlist _playlist;
  final VolumeController _volumeController;
  final Equalizer _equalizer;
  final LyricsDisplay _lyricsDisplay;

  MusicMediator(
    this._player,
    this._display,
    this._playlist,
    this._volumeController,
    this._equalizer,
    this._lyricsDisplay,
  ) {
    // 初始化时，设置各组件的中介者引用
    _player.mediator = this;
    _display.mediator = this;
    _playlist.mediator = this;
    _volumeController.mediator = this;
    _equalizer.mediator = this;
    _lyricsDisplay.mediator = this;
  }

  @override
  void playNewSong(Song song) {
    _player.play(song);
    _display.updateSongInfo(song);
    _lyricsDisplay.loadLyrics(song.lyrics);
    _playlist.updateCurrentSong(song);
  }

  @override
  void updateVolume(int volume) {
    _player.setVolume(volume);
    _display.updateVolume(volume);
    if (volume == 0) {
      _display.showMuteIcon();
    }
  }

  @override
  void updateEqualizer(EqualizerSettings settings) {
    _player.applyEqualizer(settings);
    _display.updateEqualizerSettings(settings);
  }

  @override
  void updatePlaylist(Playlist playlist) {
    _display.updatePlaylist(playlist);
    _playlist.updatePlaylist(playlist);
  }

  @override
  void updateProgress(Duration progress) {
    _display.updateProgress(progress);
    _lyricsDisplay.syncLyrics(progress);
  }

  @override
  void savePlaybackState() {
    // 保存当前播放状态到数据库或本地存储
  }

  @override
  void restorePlaybackState() {
    // 恢复播放状态
  }

  PlaybackMode _mode = PlaybackMode.repeatAll;

  void switchPlaybackMode(PlaybackMode mode) {
    _mode = mode;
    // 通知显示组件更新播放模式
  }

  PlaybackMode get playbackMode => _mode;
}



///  中介者 管理各个分散的部分
///  在中介里注册让中介管理 就像中介管理房子一样 就像外卖平台一样大家都在里注册 骑手商家用户，但是外卖平台负责调度
///
