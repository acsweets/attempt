// 抽象状态类
abstract class PlayerState {
  void play(MusicPlayer player);
  void pause(MusicPlayer player);
  void stop(MusicPlayer player);
  String getName();
}

// 具体状态类：播放状态
class PlayingState implements PlayerState {
  @override
  void play(MusicPlayer player) {
    print('已经在播放中...');
  }

  @override
  void pause(MusicPlayer player) {
    print('暂停播放音乐');
    player.changeState(PausedState());
  }

  @override
  void stop(MusicPlayer player) {
    print('停止播放音乐');
    player.changeState(StoppedState());
  }

  @override
  String getName() => '播放中';
}

// 具体状态类：暂停状态
class PausedState implements PlayerState {
  @override
  void play(MusicPlayer player) {
    print('继续播放音乐');
    player.changeState(PlayingState());
  }

  @override
  void pause(MusicPlayer player) {
    print('已经处于暂停状态...');
  }

  @override
  void stop(MusicPlayer player) {
    print('停止播放音乐');
    player.changeState(StoppedState());
  }

  @override
  String getName() => '已暂停';
}

// 具体状态类：停止状态
class StoppedState implements PlayerState {
  @override
  void play(MusicPlayer player) {
    print('开始播放音乐');
    player.changeState(PlayingState());
  }

  @override
  void pause(MusicPlayer player) {
    print('停止状态不能暂停');
  }

  @override
  void stop(MusicPlayer player) {
    print('已经处于停止状态...');
  }

  @override
  String getName() => '已停止';
}

// 上下文类：音乐播放器
class MusicPlayer {
  late PlayerState _state;
  String? _currentTrack;

  MusicPlayer() {
    // 初始状态为停止
    _state = StoppedState();
  }

  void changeState(PlayerState state) {
    _state = state;
  }

  void play() {
    _state.play(this);
  }

  void pause() {
    _state.pause(this);
  }

  void stop() {
    _state.stop(this);
  }

  void setTrack(String trackName) {
    _currentTrack = trackName;
    print('设置当前歌曲: $trackName');
  }

  String getCurrentState() {
    return _state.getName();
  }
}

// 使用示例
void main() {
  var player = MusicPlayer();

  // 设置要播放的歌曲
  player.setTrack('Beautiful Day');

  print('当前状态: ${player.getCurrentState()}');

  // 播放音乐
  player.play();
  print('当前状态: ${player.getCurrentState()}');

  // 暂停
  player.pause();
  print('当前状态: ${player.getCurrentState()}');

  // 继续播放
  player.play();
  print('当前状态: ${player.getCurrentState()}');

  // 停止
  player.stop();
  print('当前状态: ${player.getCurrentState()}');
}