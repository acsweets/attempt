/// 飞机塔台调度系统。每架飞机在起飞、降落和巡航时，
/// 都需要与机场的塔台进行通信，塔台负责协调飞机的动作，
/// 避免空中或地面发生碰撞。如果每架飞机都相互通信，系统会变得非常复杂。
//
// 你可以使用中介者模式，设计一个 塔台控制中心，让每架飞机通过塔台进行通信，而不是直接与其他飞机通信。
//
// 需要实现的部分：
// TowerMediator：塔台中介者接口，负责协调飞机之间的通信。
// ConcreteTower：塔台的具体实现，协调多架飞机的动作。
// Airplane：飞机类，飞机通过塔台请求起飞、降落等操作。
// 具体行为：飞机请求塔台起飞，塔台检查是否安全起飞；飞机请求降落，塔台检查跑道是否空闲等。



// 抽象中介者
abstract class ControlTowerMediator {
  void registerAircraft(Aircraft aircraft);
  void sendMessage(String message, Aircraft sender);
  bool requestLanding(Aircraft aircraft);
  bool requestTakeoff(Aircraft aircraft);
}

// 具体中介者 - 控制塔
class AirportControlTower implements ControlTowerMediator {
  List<Aircraft> registeredAircraft = [];
  bool runwayOccupied = false;

  @override
  void registerAircraft(Aircraft aircraft) {
    registeredAircraft.add(aircraft);
    print('${aircraft.code} 已在控制塔注册');
  }

  @override
  void sendMessage(String message, Aircraft sender) {
    for (var aircraft in registeredAircraft) {
      if (aircraft != sender) {
        aircraft.receiveMessage('来自 ${sender.code} 的广播: $message');
      }
    }
  }

  @override
  bool requestLanding(Aircraft aircraft) {
    if (!runwayOccupied) {
      runwayOccupied = true;
      notifyAll('跑道已被 ${aircraft.code} 占用，准备降落');
      return true;
    }
    return false;
  }

  @override
  bool requestTakeoff(Aircraft aircraft) {
    if (!runwayOccupied) {
      runwayOccupied = true;
      notifyAll('跑道已被 ${aircraft.code} 占用，准备起飞');
      return true;
    }
    return false;
  }

  void notifyAll(String message) {
    for (var aircraft in registeredAircraft) {
      aircraft.receiveMessage('控制塔通知: $message');
    }
  }

  void releaseRunway() {
    runwayOccupied = false;
    notifyAll('跑道已空闲');
  }
}

// 抽象同事类
abstract class Aircraft {
  String code;
  ControlTowerMediator controlTower;

  Aircraft(this.code, this.controlTower) {
    controlTower.registerAircraft(this);
  }

  void sendMessage(String message);
  void receiveMessage(String message);
  void requestLanding();
  void requestTakeoff();
}

// 具体同事类 - 飞机
class CommercialAircraft extends Aircraft {
  CommercialAircraft(String code, ControlTowerMediator controlTower)
      : super(code, controlTower);

  @override
  void sendMessage(String message) {
    print('$code 发送消息: $message');
    controlTower.sendMessage(message, this);
  }

  @override
  void receiveMessage(String message) {
    print('$code 收到消息: $message');
  }

  @override
  void requestLanding() {
    print('$code 请求降落');
    if (controlTower.requestLanding(this)) {
      print('$code 已获得降落许可');
      // 模拟降落过程
      Future.delayed(Duration(seconds: 2), () {
        print('$code 已成功降落');
        (controlTower as AirportControlTower).releaseRunway();
      });
    } else {
      print('$code 降落请求被拒绝：跑道被占用');
    }
  }

  @override
  void requestTakeoff() {
    print('$code 请求起飞');
    if (controlTower.requestTakeoff(this)) {
      print('$code 已获得起飞许可');
      // 模拟起飞过程
      Future.delayed(Duration(seconds: 2), () {
        print('$code 已成功起飞');
        (controlTower as AirportControlTower).releaseRunway();
      });
    } else {
      print('$code 起飞请求被拒绝：跑道被占用');
    }
  }
}

// 使用示例
void main() async {
  // 创建控制塔（中介者）
  final tower = AirportControlTower();

  // 创建多架飞机
  final flight1 = CommercialAircraft('CA101', tower);
  final flight2 = CommercialAircraft('MU202', tower);
  final flight3 = CommercialAircraft('CZ303', tower);

  print('\n=== 开始模拟航空通信 ===\n');

  // 模拟通信场景
  flight1.sendMessage('现在高度10000米，准备降落');
  await Future.delayed(Duration(seconds: 1));

  // 模拟起降场景
  flight1.requestLanding();
  await Future.delayed(Duration(seconds: 1));

  // 当flight1正在降落时，flight2请求起飞
  flight2.requestTakeoff();
  await Future.delayed(Duration(seconds: 2));

  // flight1降落完成后，flight2再次请求起飞
  flight2.requestTakeoff();
  await Future.delayed(Duration(seconds: 3));

  // flight3发送广播消息
  flight3.sendMessage('请求确认当前天气情况');
}