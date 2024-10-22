///用户可以根据需求定制不同的旅游套餐。每个旅游套餐可能包括机票、酒店、观光活动、以及用餐选项等。
///使用建造者模式，你可以让用户灵活地选择他们想要的服务，最终生成一个个性化的旅游套餐。
// 任务：
// 创建一个旅游套餐的建造者，允许用户定制以下属性：
//
// 机票信息（如航班号、座位等级等）
// 酒店信息（如酒店名称、房间类型等）
// 观光活动（如旅游景点、导游服务等）
// 用餐选项（如早中晚餐的套餐）
// 你可以使用 Builder 模式让用户可以选择部分或全部属性来定制个性化旅游套餐，最后调用 build() 生成完整的套餐对象

class PlaneTicket {
  final int flightNumber;
  final String grade;

  const PlaneTicket({this.flightNumber = 11, this.grade = 'C'});
}

class Hotel {
  final String name;
  final String roomType;

  const Hotel({this.name = '大酒店', this.roomType = '单间'});
}

class Activity {
  final String eventName;
  final String service;

  const Activity({this.eventName = '黄金大道', this.service = '拍照服务'});
}

class Meal {
  final String mealType;

  const Meal({this.mealType = '特色中餐'});
}

class PackageTour {
  final PlaneTicket planeTicket;
  final Hotel hotel;
  final Activity activity;
  final Meal meal;

  PackageTour({
    this.planeTicket = const PlaneTicket(),
    this.hotel = const Hotel(),
    this.activity = const Activity(),
    this.meal = const Meal(),
  });

  PackageTour copyWith({
    PlaneTicket? planeTicket,
    Hotel? hotel,
    Activity? activity,
    Meal? meal,
  }) {
    return PackageTour(
      planeTicket: planeTicket ?? this.planeTicket,
      hotel: hotel ?? this.hotel,
      activity: activity ?? this.activity,
      meal: meal ?? this.meal,
    );
  }
}

class PackageTourPro {
  PlaneTicket _planeTicket = const PlaneTicket();
  Hotel _hotel = const Hotel();
  Activity _activity = const Activity();
  Meal _meal = const Meal();

  PackageTourPro setPlaneTicket(PlaneTicket planeTicket) {
    _planeTicket = planeTicket;
    return this; // 链式调用
  }

  PackageTourPro setHotel(Hotel hotel) {
    _hotel = hotel;
    return this; // 链式调用
  }

  PackageTourPro setActivity(Activity activity) {
    _activity = activity;
    return this; // 链式调用
  }

  PackageTourPro setMeal(Meal meal) {
    _meal = meal;
    return this; // 链式调用
  }

  @override
  String toString() {
    return '''
    Package Tour Details:
    Plane Ticket - Flight Number: ${_planeTicket.flightNumber}, Grade: ${_planeTicket.grade}
    Hotel - Name: ${_hotel.name}, Room Type: ${_hotel.roomType}
    Activity - Event: ${_activity.eventName}, Service: ${_activity.service}
    Meal - Type: ${_meal.mealType}
    ''';
  }
}

void main() {
  PackageTourPro tour = PackageTourPro()
      .setPlaneTicket(const PlaneTicket(flightNumber: 123, grade: 'A'))
      .setHotel(const Hotel(name: '海景酒店', roomType: '豪华套房'))
      .setActivity(const Activity(eventName: '长城一日游', service: '导游解说'))
      .setMeal(const Meal(mealType: '自助午餐'));

  print(tour);
}

