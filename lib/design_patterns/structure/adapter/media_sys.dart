// 假设我们有一个音乐播放器系统，它只能播放 .mp3 格式的音频文件，但我们现在有新的需求，需要支持 .mp4 和 .vlc 格式的文件播放。使用适配器模式来解决这个问题。

// 目标接口（播放器接口）——定义客户端所期待的接口
abstract class MediaPlayer {
  void play(String audioType, String fileName);
}

// 高级媒体播放器接口，支持更多格式
abstract class AdvancedMediaPlayer {
  void playVlc(String fileName);

  void playMp4(String fileName);
}

// VLC播放器的具体实现类
class VlcPlayer implements AdvancedMediaPlayer {
  @override
  void playVlc(String fileName) {
    print("Playing vlc file: $fileName");
  }

  @override
  void playMp4(String fileName) {
    // 不支持的操作
  }
}

// MP4播放器的具体实现类
class Mp4Player implements AdvancedMediaPlayer {
  @override
  void playVlc(String fileName) {
    // 不支持的操作
  }

  @override
  void playMp4(String fileName) {
    print("Playing mp4 file: $fileName");
  }
}

// 适配器类——适配高级播放器到基本播放器接口
class MediaAdapter implements MediaPlayer {
  late AdvancedMediaPlayer advancedMusicPlayer;

  MediaAdapter(String audioType) {
    if (audioType == 'vlc') {
      advancedMusicPlayer = VlcPlayer();
    } else if (audioType == 'mp4') {
      advancedMusicPlayer = Mp4Player();
    }
  }

  @override
  void play(String audioType, String fileName) {
    if (audioType == 'vlc') {
      advancedMusicPlayer.playVlc(fileName);
    } else if (audioType == 'mp4') {
      advancedMusicPlayer.playMp4(fileName);
    }
  }
}

// 原有的音频播放器类，只支持MP3格式
class AudioPlayer implements MediaPlayer {
  late MediaAdapter mediaAdapter;

  @override
  void play(String audioType, String fileName) {
    if (audioType == 'mp3') {
      print("Playing mp3 file: $fileName");
    } else if (audioType == 'vlc' || audioType == 'mp4') {
      mediaAdapter = MediaAdapter(audioType);
      mediaAdapter.play(audioType, fileName);
    } else {
      print("Invalid media. $audioType format not supported");
    }
  }
}
/// 128-108

// 测试代码
void main() {
  // AudioPlayer audioPlayer = AudioPlayer();
  // audioPlayer.play("mp3", "song.mp3");
  // audioPlayer.play("mp4", "video.mp4");
  // audioPlayer.play("vlc", "movie.vlc");
  // audioPlayer.play("avi", "random.avi");

  double a = 1600 * 7 - 7800;  // 14斤
  print(a);
}
