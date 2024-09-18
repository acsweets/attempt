enum NumType {
  arab,
  chinese,
  english;
}

class MathUntil {
  static dynamic number(NumType numType) {
    switch (numType) {
      case NumType.arab:
        return arab;
      case NumType.chinese:
        return chinese;
      case NumType.english:
        return english;
    }
  }

  static List<int> arab = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  static List<String> chinese = [
    '零',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
    '七',
    '八',
    '九',
    '十'
  ];

  static List<String> english = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten'
  ];
}
