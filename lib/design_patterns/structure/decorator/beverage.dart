// 定义饮料接口
abstract class Beverage {
  String getDescription();
  double cost();
}

// 实现基础饮料类（如咖啡）
class Coffee implements Beverage {
  @override
  String getDescription() {
    return "Coffee";
  }

  @override
  double cost() {
    return 2.0;
  }
}

// 抽象装饰器类，继承自Beverage
abstract class BeverageDecorator implements Beverage {
  final Beverage _beverage;

  BeverageDecorator(this._beverage);

  @override
  String getDescription() {
    return _beverage.getDescription();
  }

  @override
  double cost() {
    return _beverage.cost();
  }
}


// 添加糖的装饰器
class SugarDecorator extends BeverageDecorator {
  SugarDecorator(super.beverage);

  @override
  String getDescription() {
    return "${super.getDescription()} + Sugar";
  }

  @override
  double cost() {
    return super.cost() + 0.5;  // 加糖的价格
  }
}
// 添加牛奶的装饰器
class MilkDecorator extends BeverageDecorator {
  MilkDecorator(Beverage beverage) : super(beverage);

  @override
  String getDescription() {
    return "${super.getDescription()} + Milk";
  }

  @override
  double cost() {
    return super.cost() + 1.0;  // 加牛奶的价格
  }
}


// 创建基础饮料（咖啡）
Beverage beverage = Coffee();

//装饰完了还是这个对象 所以装饰器接口这个对象

// 加糖
// beverage = SugarDecorator(beverage);

// 加牛奶
// beverage = MilkDecorator(beverage);