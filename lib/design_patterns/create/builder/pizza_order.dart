///假设您正在为一家披萨连锁店开发一个订单系统。
///这个系统应该能够灵活地创建不同类型的披萨，
///而不需要使用复杂的构造函数或者在Pizza类中设置大量的参数。

// 创建一个 Pizza 类来表示最终的产品。
// 设计一个 PizzaBuilder 抽象类或接口，定义构建披萨各部分的方法。
// 实现一个具体的Builder类，比如 CustomPizzaBuilder。
// 可以考虑创建一个 PizzaDirector 类来封装使用Builder构建披萨的过程。
// 尺寸（小号、中号、大号）
// 面饼类型（薄底、厚底、芝士边）
// 酱料类型（番茄酱、BBQ酱、大蒜酱）
// 奶酪类型（马苏里拉、切达、帕玛森）
// 配料（可以有多种：火腿、蘑菇、青椒、洋葱、香肠等）
//
//Pizza pizza = PizzaBuilder()
//     .setSize('Large')
//     .setCrust('Cheese Burst')
//     .setSauce('BBQ Sauce')
//     .setCheese('Cheddar')
//     .addTopping('Ham')
//     .addTopping('Mushrooms')
//     .build();

class Pizza {
  final String size;
  final String crust;
  final String sauce;
  final String cheese;
  final List<String> toppings;

  Pizza({
    required this.size,
    required this.crust,
    required this.sauce,
    required this.cheese,
    required this.toppings,
  });

  @override
  String toString() {
    return '''
Pizza Details:
  Size: $size
  Crust: $crust
  Sauce: $sauce
  Cheese: $cheese
  Toppings: ${toppings.join(', ')}
''';
  }
}

abstract class PizzaBuilder {
  void setSize(String size);
  void setCrust(String crust);
  void setSauce(String sauce);
  void setCheese(String cheese);
  void setToppings(List<String> toppings);
  Pizza build();
}


class CustomPizzaBuilder implements PizzaBuilder {
  late String _size;
  late String _crust;
  late String _sauce;
  late String _cheese;
  List<String> _toppings = [];

  @override
  void setSize(String size) {
    _size = size;
  }

  @override
  void setCrust(String crust) {
    _crust = crust;
  }

  @override
  void setSauce(String sauce) {
    _sauce = sauce;
  }

  @override
  void setCheese(String cheese) {
    _cheese = cheese;
  }

  @override
  void setToppings(List<String> toppings) {
    _toppings = toppings;
  }

  @override
  Pizza build() {
    return Pizza(
      size: _size,
      crust: _crust,
      sauce: _sauce,
      cheese: _cheese,
      toppings: _toppings,
    );
  }
}

class PizzaDirector {
  final PizzaBuilder _builder;

  PizzaDirector(this._builder);

  Pizza createMargherita() {
    _builder.setSize('Medium');
    _builder.setCrust('Thin Crust');
    _builder.setSauce('Tomato Sauce');
    _builder.setCheese('Mozzarella');
    _builder.setToppings(['Basil']);
    return _builder.build();
  }

  Pizza createCustomPizza({
    required String size,
    required String crust,
    required String sauce,
    required String cheese,
    required List<String> toppings,
  }) {
    _builder.setSize(size);
    _builder.setCrust(crust);
    _builder.setSauce(sauce);
    _builder.setCheese(cheese);
    _builder.setToppings(toppings);
    return _builder.build();
  }
}
