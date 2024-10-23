class HelloWord {
  String sayHello(DateTime now, String user) {
    DateTime c;
    int h;
    String? s;
    c = DateTime.now();
    h = c.hour;
    if (h >= 5 && h < 12) {
      s = 'morning';
    } else if (h >= 12 && h < 19) {
      s = 'afternoon';
    } else {
      s = 'night';
    }
    s = user + s;
    return s;
  }

  String sayHelloOptimization( String user) {
    DateTime nowTime = DateTime.now();
    int nowHour = nowTime.hour;
    String? word ;
    if (nowHour >= 5 && nowHour < 12) {
      word = 'morning';
    } else if (nowHour >= 12 && nowHour < 19) {
      word = 'afternoon';
    } else {
      word = 'night';
    }
    word = user + word;
    return word;
  }
}
