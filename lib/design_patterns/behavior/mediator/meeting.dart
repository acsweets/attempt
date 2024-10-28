// /我来给你一个智能会议室管理系统的需求场景，这是一个很适合使用中介者模式的实际应用场景。
// 需求背景：设计一个智能会议室管理系统，协调会议室内各种设备的自动化控制，提升会议体验。
// 主要组件：
//
// 门禁系统
//
// 控制会议室门的开关
// 记录进出人员
// 支持身份验证
//
// 照明系统
//
// 控制会议室灯光开关
// 调节亮度
// 支持不同场景模式（演讲、讨论、投影等）
//
// 投影设备
//
// 控制投影仪开关
// 自动调节投影幕布
// 支持屏幕镜像和无线投屏
//
// 空调系统
//
// 控制温度
// 调节风速
// 监测室内温度
//
// 会议预约系统  //中介者负责管理
//
// 管理会议室预约时间表
// 处理预约冲突
// 发送会议提醒
//
// 视频会议设备
//
// 摄像头控制
// 音频系统控制
// 远程连接管理
//
// 交互需求：
//
// 会议开始时：
//
// 根据预约时间自动开门
// 打开照明和空调
// 预热投影仪
// 调整到合适的会议场景模式
//
// 使用投影时：
//
// 自动调暗灯光
// 降下投影幕布
// 切换到演示模式
//
// 视频会议时：
//
// 自动调整灯光亮度
// 开启摄像头和音频系统
// 优化空调设置减少噪音
//
// 会议结束时：
//
// 关闭所有设备
// 恢复默认设置
// 锁定门禁
// 更新会议室状态
//
// 紧急情况处理：
//
// 火警时自动开启应急照明
// 解除门禁锁定
// 关闭所有可能的危险设备
//
// 特殊要求：
//
// 支持手动和自动两种控制模式
// 各系统状态实时同步
// 支持远程控制
// 需要记录所有设备的运行日志
// 系统要有故障自检和报警功能
// 支持不同权限级别的控制
//
// 提示实现思路：
//
// 设计中介者接口，定义各种通信方法
// 为每个子系统创建接口和具体实现
// 在中介者中实现复杂的协调逻辑
// 考虑状态模式来管理不同的会议场景    会议室的各种状态
// 实现观察者模式来处理实时状态更新
// 使用命令模式处理远程控制功能
//
// 通过这个系统，你可以练习：
//
// 如何设计清晰的接口
// 如何处理复杂的设备协调
// 如何管理不同的系统状态
// 如何处理异步操作
// 如何实现错误处理和恢复机制

// 门禁系统
//
// 控制会议室门的开关
// 记录进出人员
// 支持身份验证

// mixin class AccessControl {
//   bool doorState = false;
//   bool emergency = false;
//
//   //进出人员
//   List<String> member = [];
//   List<String> authorized = [];
//
//   //开关 会议室的门 校验权限
//
//   void switchDoor(String name) {
//     if (!authorized.contains(name) && !emergency) {
//       print('您没有权限');
//       return;
//     }
//
//     doorState = !doorState;
//     if (doorState) {
//       print('门已打开');
//     } else {
//       print('门已关闭');
//     }
//   }
//
//   void addMember(String name) {
//     if (!authorized.contains(name)) {
//       authorized.add(name);
//     }
//   }
//
//   void removeMember(String name) {
//     if (authorized.contains(name)) {
//       authorized.remove(name);
//     }
//   }
//
//   void addVisit(String name) {
//     member.add(name);
//   }
//
//   void printVisit() {
//     print(member.toString());
//   }
// }
// // 照明系统
// //
// // 控制会议室灯光开关
// // 调节亮度
// // 支持不同场景模式（演讲、讨论、投影等）
//
// enum LightingMode {
//   speech, // 演讲
//   discuss, // 讨论
//   projection, //投影
//   normal, //  正常
// }
//
// mixin class Lighting {
//   bool light = false;
//   int lightBrightness = 20;
//   LightingMode lightingMode = LightingMode.normal;
//
//   void switchLight(bool operation) {
//     light = operation;
//
//     if (light) {
//       print('灯光已开');
//     } else {
//       print('灯光已关');
//     }
//   }
//
//   void addBrightness() {
//     if (lightBrightness <= 100) {
//       print('已到最大亮度');
//     }
//     lightBrightness = lightBrightness++;
//     print('当前亮度为$lightBrightness');
//   }
//
//   void reduceBrightness() {
//     if (lightBrightness <= 1) {
//       print('已到最小亮度');
//     }
//     lightBrightness = lightBrightness--;
//     print('当前亮度为$lightBrightness');
//   }
//
//   void switchingModes(LightingMode mode) {
//     lightingMode = mode;
//   }
// }
//
// // 投影设备
// //
// // 控制投影仪开关
// // 自动调节投影幕布
// // 支持屏幕镜像和无线投屏
//
// mixin class Projection {
//   bool projector = false;
//
//   void switchProjector(bool operation) {
//     projector = operation;
//     if (projector) {
//       print('投影已经打开');
//     } else {
//       print('投影已经关闭');
//     }
//   }
// }
//
// // 空调系统
// //
// // 控制温度
// // 调节风速
// // 监测室内温度
//
// mixin class AirConditioning {
//   double indoorTemperature = 26.5;
//
//   void openAir() {}
//
//   void adjustTemperature() {}
//
//   void adjustWindSpeed() {}
//
//   void monitorIndoorTemperature() {}
// }
//
// class MeetingReservationSystem
//     with AirConditioning, Projection, Lighting, AccessControl {
//   // 根据预约时间自动开门
//   // 打开照明和空调
//   // 预热投影仪
//   // 调整到合适的会议场景模式
//   void startMeeting(String name) {
//     openAir();
//     switchLight(true);
//
//   }
// }


//这个实现展示了中介者模式的几个关键特点和最佳实践：
//
// 清晰的抽象层次：
//
// 抽象中介者（MeetingRoomMediator）定义了统一的接口
// 抽象设备类（Device）提供了基础功能
// 各具体设备类专注于自身特定功能
//
//
// 中介者的核心职责：
//
// 设备注册管理
// 状态同步
// 事件处理
// 场景协调
// 紧急情况处理
//
//
// 设备状态管理：
//
// 统一的状态更新机制
// 集中的状态存储
// 状态报告功能
//
//
// 事件处理机制：
//
// 设备间的间接通信
// 基于事件的场景联动
// 异步操作处理
//
//
// 错误处理：
//
// 会议ID验证
// 设备状态检查
// 紧急情况处理机制
//
//
// 可扩展性考虑：
//
// 易于添加新设备
// 易于添加新的事件处理
// 易于实现新的场景
//
//
//
// 你可以对比你的实现，重点关注以下几个方面：
//
// 接口设计：
//
// 中介者接口是否足够抽象和通用
// 设备接口是否清晰明确
//
//
// 通信机制：
//
// 设备间是否完全解耦
// 事件处理是否集中且清晰
//
//
// 状态管理：
//
// 状态更新是否统一
// 状态同步是否可靠
//
//
// 错误处理：
//
// 是否考虑了异常情况
// 错误处理是否完善
//
//
// 代码组织：
//
// 职责划分是否清晰
// 代码结构是否合理
//
//
// 扩展性：
//
// 添加新功能是否方便
// 修改现有功能是否容易

// 抽象中介者

// 抽象中介者，抽象设备，注册所有的设备，管理设备 更新所有设备的状态

abstract class MeetingRoomMediator {
  void registerDevice(Device device);
  void startMeeting(String meetingId);
  void endMeeting(String meetingId);
  void handleEmergency(String emergencyType);
  void notify(Device sender, String event, Map<String, dynamic> data);
  void syncDeviceStatus(Device device, Map<String, dynamic> status);
}

// 抽象设备类
abstract class Device {
  String name;
  MeetingRoomMediator mediator;
  bool _isOn = false;
  Map<String, dynamic> _status = {};

  Device(this.name, this.mediator) {
    mediator.registerDevice(this);
  }

  void turnOn() {
    _isOn = true;
    _updateStatus('power', true);
    print('$name 已开启');
  }

  void turnOff() {
    _isOn = false;
    _updateStatus('power', false);
    print('$name 已关闭');
  }

  void _updateStatus(String key, dynamic value) {
    _status[key] = value;
    mediator.syncDeviceStatus(this, _status);
  }

  bool get isOn => _isOn;
  Map<String, dynamic> get status => Map.from(_status);
}

// 具体中介者 - 会议室控制器
class MeetingRoomController implements MeetingRoomMediator {
  final Map<String, Device> _devices = {};
  final Map<String, Map<String, dynamic>> _deviceStatus = {};
  String? _currentMeetingId;
  bool _isEmergency = false;

  @override
  void registerDevice(Device device) {
    _devices[device.name] = device;
    print('设备已注册: ${device.name}');
  }

  @override
  void startMeeting(String meetingId) {
    if (_isEmergency) {
      print('警告：当前处于紧急状态，无法开始会议');
      return;
    }

    print('\n=== 开始会议：$meetingId ===');
    _currentMeetingId = meetingId;

    // 开启必要设备
    (_devices['Door'] as Door).unlock();
    (_devices['Lighting'] as Lighting).setScene('meeting');
    (_devices['AirConditioner'] as AirConditioner).setTemperature(24);
    (_devices['Projector'] as Projector).warmUp();
  }

  @override
  void endMeeting(String meetingId) {
    if (_currentMeetingId != meetingId) {
      print('错误：会议ID不匹配');
      return;
    }

    print('\n=== 结束会议：$meetingId ===');
    _currentMeetingId = null;

    // 关闭设备和清理
    _devices.values.forEach((device) => device.turnOff());
    (_devices['Door'] as Door).lock();

    // 重置所有状态
    _deviceStatus.clear();
  }

  @override
  void handleEmergency(String emergencyType) {
    print('\n!!! 紧急情况：$emergencyType !!!');
    _isEmergency = true;

    switch (emergencyType) {
      case 'fire':
      // 火警处理
        (_devices['Door'] as Door).unlock();
        (_devices['Lighting'] as Lighting).setScene('emergency');
        _devices.values.forEach((device) {
          if (device is! Door && device is! Lighting) {
            device.turnOff();
          }
        });
        break;
      case 'power_outage':
      // 断电处理
        (_devices['Door'] as Door).unlock();
        _devices.values.forEach((device) => device.turnOff());
        break;
    }
  }

  @override
  void notify(Device sender, String event, Map<String, dynamic> data) {
    print('\n收到来自 ${sender.name} 的事件: $event');

    switch (event) {
      case 'projection_started':
        (_devices['Lighting'] as Lighting).setScene('presentation');
        break;
      case 'video_conference_started':
        (_devices['Lighting'] as Lighting).setScene('video');
        (_devices['AirConditioner'] as AirConditioner).setFanSpeed('low');
        break;
      case 'motion_detected':
        if (_currentMeetingId == null) {
          (_devices['Lighting'] as Lighting).turnOn();
        }
        break;
    }
  }

  @override
  void syncDeviceStatus(Device device, Map<String, dynamic> status) {
    _deviceStatus[device.name] = status;
    print('${device.name} 状态更新: $status');
  }

  // 获取设备状态报告
  Map<String, Map<String, dynamic>> getStatusReport() {
    return Map.from(_deviceStatus);
  }
}

// 具体设备类 - 门禁
class Door extends Device {
  bool _isLocked = true;

  Door(super.name, super.mediator);

  void lock() {
    _isLocked = true;
    _updateStatus('locked', true);
    print('$name: 已锁定');
  }

  void unlock() {
    _isLocked = false;
    _updateStatus('locked', false);
    print('$name: 已解锁');
  }
}

// 具体设备类 - 照明
class Lighting extends Device {
  int _brightness = 100;
  String _scene = 'default';

  Lighting(String name, MeetingRoomMediator mediator) : super(name, mediator);

  void setBrightness(int level) {
    _brightness = level;
    _updateStatus('brightness', level);
    print('$name: 亮度设置为 $_brightness%');
  }

  void setScene(String scene) {
    _scene = scene;
    switch (scene) {
      case 'meeting':
        setBrightness(80);
        break;
      case 'presentation':
        setBrightness(30);
        break;
      case 'video':
        setBrightness(50);
        break;
      case 'emergency':
        setBrightness(100);
        turnOn();
        break;
    }
    _updateStatus('scene', scene);
    print('$name: 场景切换为 $_scene');
  }
}

// 具体设备类 - 投影仪
class Projector extends Device {
  bool _isWarmedUp = false;

  Projector(String name, MeetingRoomMediator mediator) : super(name, mediator);

  void warmUp() {
    turnOn();
    _isWarmedUp = true;
    _updateStatus('warmedUp', true);
    print('$name: 预热完成');
  }

  void startProjection() {
    if (!_isWarmedUp) {
      print('$name: 错误 - 需要先预热');
      return;
    }
    print('$name: 开始投影');
    mediator.notify(this, 'projection_started', {'status': 'active'});
  }
}

// 具体设备类 - 空调
class AirConditioner extends Device {
  int _temperature = 25;
  String _fanSpeed = 'medium';

  AirConditioner(String name, MeetingRoomMediator mediator) : super(name, mediator);

  void setTemperature(int temp) {
    _temperature = temp;
    _updateStatus('temperature', temp);
    print('$name: 温度设置为 $_temperature°C');
  }

  void setFanSpeed(String speed) {
    _fanSpeed = speed;
    _updateStatus('fanSpeed', speed);
    print('$name: 风速设置为 $_fanSpeed');
  }
}

// 使用示例
void main() async {
  // 创建会议室控制器（中介者）
  final controller = MeetingRoomController();

  // 创建设备
  final door = Door('Door', controller);
  final lighting = Lighting('Lighting', controller);
  final projector = Projector('Projector', controller);
  final airConditioner = AirConditioner('AirConditioner', controller);

  print('\n=== 会议室系统测试 ===\n');

  // 测试场景1：正常会议流程
  print('场景1：开始常规会议');
  controller.startMeeting('M001');
  await Future.delayed(Duration(seconds: 2));

  print('\n切换到演示模式');
  projector.startProjection();
  await Future.delayed(Duration(seconds: 2));

  print('\n结束会议');
  controller.endMeeting('M001');
  await Future.delayed(Duration(seconds: 2));

  // 测试场景2：紧急情况
  print('\n场景2：处理紧急情况');
  controller.startMeeting('M002');
  await Future.delayed(Duration(seconds: 2));

  print('\n触发火警');
  controller.handleEmergency('fire');

  // 打印状态报告
  print('\n=== 设备状态报告 ===');
  final statusReport = controller.getStatusReport();
  statusReport.forEach((deviceName, status) {
    print('$deviceName: $status');
  });
}