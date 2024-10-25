// 订单状态抽象类
abstract class OrderState {
  void confirmPayment(Order order);
  void ship(Order order);
  void deliver(Order order);
  void cancel(Order order);
  String getName();
}

// 新创建订单状态
class NewOrderState implements OrderState {
  @override
  void confirmPayment(Order order) {
    print('确认订单支付');
    order.changeState(PaidState());
  }

  @override
  void ship(Order order) {
    print('错误: 订单尚未支付，不能发货');
  }

  @override
  void deliver(Order order) {
    print('错误: 订单尚未发货，不能确认收货');
  }

  @override
  void cancel(Order order) {
    print('取消未支付订单');
    order.changeState(CancelledState());
  }

  @override
  String getName() => '待支付';
}

// 已支付状态
class PaidState implements OrderState {
  @override
  void confirmPayment(Order order) {
    print('错误: 订单已支付');
  }

  @override
  void ship(Order order) {
    print('订单已发货');
    order.changeState(ShippedState());
  }

  @override
  void deliver(Order order) {
    print('错误: 订单尚未发货，不能确认收货');
  }

  @override
  void cancel(Order order) {
    print('取消已支付订单，退款处理中');
    order.changeState(CancelledState());
  }

  @override
  String getName() => '已支付';
}

// 已发货状态
class ShippedState implements OrderState {
  @override
  void confirmPayment(Order order) {
    print('错误: 订单已支付');
  }

  @override
  void ship(Order order) {
    print('错误: 订单已发货');
  }

  @override
  void deliver(Order order) {
    print('确认收货');
    order.changeState(DeliveredState());
  }

  @override
  void cancel(Order order) {
    print('错误: 已发货订单不能取消');
  }

  @override
  String getName() => '已发货';
}

// 已收货状态
class DeliveredState implements OrderState {
  @override
  void confirmPayment(Order order) {
    print('错误: 订单已支付');
  }

  @override
  void ship(Order order) {
    print('错误: 订单已发货');
  }

  @override
  void deliver(Order order) {
    print('错误: 订单已确认收货');
  }

  @override
  void cancel(Order order) {
    print('错误: 已收货订单不能取消');
  }

  @override
  String getName() => '已收货';
}

// 已取消状态
class CancelledState implements OrderState {
  @override
  void confirmPayment(Order order) {
    print('错误: 已取消订单不能支付');
  }

  @override
  void ship(Order order) {
    print('错误: 已取消订单不能发货');
  }

  @override
  void deliver(Order order) {
    print('错误: 已取消订单不能确认收货');
  }

  @override
  void cancel(Order order) {
    print('错误: 订单已经取消');
  }

  @override
  String getName() => '已取消';
}

// 订单类
class Order {
  late OrderState _state;
  final String orderNumber;
  final double amount;

  Order(this.orderNumber, this.amount) {
    // 初始状态为新订单
    _state = NewOrderState();
  }

  void changeState(OrderState state) {
    _state = state;
  }

  void confirmPayment() {
    _state.confirmPayment(this);
  }

  void ship() {
    _state.ship(this);
  }

  void deliver() {
    _state.deliver(this);
  }

  void cancel() {
    _state.cancel(this);
  }

  String getCurrentState() {
    return _state.getName();
  }

  void printOrderDetails() {
    print('\n订单详情:');
    print('订单号: $orderNumber');
    print('金额: ￥$amount');
    print('状态: ${getCurrentState()}\n');
  }
}
