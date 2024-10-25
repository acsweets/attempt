///它允许对象在其内部状态发生改变时，改变其行为。
///使用状态模式可以将对象的状态和行为解耦合，使得状态转换更加清晰和可维护。
//
// 场景描述：
// 假设你在开发一个 电梯控制系统。电梯在运行过程中有多个状态，比如 空闲、上升、下降、
// 停在某楼层 等电梯的行为（如按下按钮、到达某层）会根据当前状态而有所不同。
// 通过使用状态模式，可以将电梯的每种状态封装到独立的状态类中，
// 并通过电梯对象的状态切换，来改变其行为。

// enum ElevatorStatus {
//   free, //空闲
//   rise, //上升
//   decline, //下降
// }
//
// class Elevator {
//   ElevatorStatus status;
//   int floor;
//
//   Elevator(this.floor, this.status);
//
//   List<int> floorGroup = [];
//
//   //电梯行为
//   void pressTheButton(int floor) {
//
//   }
// }
//

// 电梯状态接口
abstract class ElevatorState {
  void handleRequest(Elevator elevator, Request request);

  String getStateName();
}

enum RequestType {
  INTERNAL, // 内部请求（电梯内部按钮）
  EXTERNAL_UP, // 外部向上请求
  EXTERNAL_DOWN // 外部向下请求
}

// 请求类，包含请求类型和目标楼层
class Request {
  RequestType type;
  int targetFloor;

  Request(this.type, this.targetFloor);

  RequestType getType() {
    return type;
  }

  int getTargetFloor() {
    return targetFloor;
  }
}

// 电梯类
class Elevator {
  ElevatorState currentState = const IdleState();

  int currentFloor = 0;

  List<int> destinationFloors = [];

  Elevator();

  void setState(ElevatorState state) {
    print("电梯从 ${currentState.getStateName()} 状态变为 ${state.getStateName()} 状态");
    currentState = state;
  }

  void handleRequest(Request request) {
    currentState.handleRequest(this, request);
  }

  int getCurrentFloor() {
    return currentFloor;
  }

  void setCurrentFloor(int floor) {
    currentFloor = floor;
  }

  List<int> getDestinationFloors() {
    return destinationFloors;
  }

  void addDestination(int floor) {
    if (!destinationFloors.contains(floor)) {
      destinationFloors.add(floor);
      destinationFloors.sort();
    }
  }

  void removeDestination(int floor) {
    destinationFloors.remove(floor);
  }
}

// 空闲状态
class IdleState implements ElevatorState {
  const IdleState();

  @override
  void handleRequest(Elevator elevator, Request request) {
    int targetFloor = request.getTargetFloor();
    elevator.addDestination(targetFloor);
    if (targetFloor > elevator.getCurrentFloor()) {
      elevator.setState(const MovingUpState());
    } else if (targetFloor < elevator.getCurrentFloor()) {
      elevator.setState(const MovingDownState());
    } else {
      elevator.setState(const StoppedState());
    }
  }

  @override
  String getStateName() {
    return "空闲";
  }
}

// 上升状态
class MovingUpState implements ElevatorState {
  const MovingUpState();

  @override
  void handleRequest(Elevator elevator, Request request) {
    int targetFloor = request.getTargetFloor();
    elevator.addDestination(targetFloor);

    // 模拟电梯运行
    while (elevator.getDestinationFloors().isNotEmpty) {
      int nextFloor = elevator.getDestinationFloors().first;
      if (nextFloor == elevator.getCurrentFloor()) {
        elevator.removeDestination(nextFloor);
        elevator.setState(const StoppedState());
        return;
      }
      elevator.setCurrentFloor(elevator.getCurrentFloor() + 1);
      print("电梯上升到 " + ' ${elevator.getCurrentFloor()}' + " 层");
    }

    elevator.setState(const IdleState());
  }

  @override
  String getStateName() {
    return "上升";
  }
}

// 下降状态
class MovingDownState implements ElevatorState {
  const MovingDownState();

  @override
  void handleRequest(Elevator elevator, Request request) {
    int targetFloor = request.getTargetFloor();
    elevator.addDestination(targetFloor);

    // 模拟电梯运行
    while (elevator.getDestinationFloors().isNotEmpty) {
      int nextFloor = elevator.getDestinationFloors().last;
      if (nextFloor == elevator.getCurrentFloor()) {
        elevator.removeDestination(nextFloor);
        elevator.setState(const StoppedState());
        return;
      }
      elevator.setCurrentFloor(elevator.getCurrentFloor() - 1);
      print("电梯下降到 " ' ${elevator.getCurrentFloor()}' " 层");
    }

    elevator.setState(const IdleState());
  }

  @override
  String getStateName() {
    return "下降";
  }
}

// 停止状态
class StoppedState implements ElevatorState {
  const StoppedState();

  @override
  void handleRequest(Elevator elevator, Request request) {
    print("电梯停在 " + ' ${elevator.getCurrentFloor()}' + " 层");
    // 模拟开门关门
    print("电梯门开启");
    try {
      Future.delayed(const Duration(microseconds: 1000)); // 等待1秒
    } catch (e) {}
    print("电梯门关闭");

    // 处理新请求
    int targetFloor = request.getTargetFloor();
    if (targetFloor > elevator.getCurrentFloor()) {
      elevator.setState(const MovingUpState());
    } else if (targetFloor < elevator.getCurrentFloor()) {
      elevator.setState(const MovingDownState());
    } else {
      elevator.setState(const IdleState());
    }
  }

  @override
  String getStateName() {
    return "停止";
  }
}

// 测试类

void main() {
  Elevator elevator = Elevator();

  // 测试场景
  print("=== 测试电梯控制系统 ===");

  // 电梯在1层，有人在3层按下向下按钮
  print("\n场景1: 3层有人按下向下按钮");
  elevator.handleRequest(Request(RequestType.EXTERNAL_DOWN, 3));

  // 电梯到达3层后，乘客要到1层
  print("\n场景2: 乘客要到1层");
  elevator.handleRequest(Request(RequestType.INTERNAL, 1));

  // 电梯在运行过程中，5层有新的请求
  print("\n场景3: 电梯运行中，5层有新请求");
  elevator.handleRequest(Request(RequestType.EXTERNAL_UP, 5));
}
