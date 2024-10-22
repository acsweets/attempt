abstract class People {
  List<String> introduce();
}

class Americans extends People {
  @override
  List<String> introduce() {
    return ['白色皮肤', '居住在北边'];
  }
}

abstract class PeopleDecorator implements People {
  People people;

  PeopleDecorator(this.people);
}


class EducationDecorator extends PeopleDecorator {
  EducationDecorator(super.people);


 // 避免递归调用自身的 introduce() 方法。
  @override
  List<String> introduce() {
    List<String> baseIntroduction = people.introduce();
    baseIntroduction.add("青藤大学");
    return baseIntroduction;
  }
}

class MarriageDecorator extends PeopleDecorator {
  MarriageDecorator(super.people);

  @override
  List<String> introduce() {
    List<String> baseIntroduction = people.introduce();
    baseIntroduction.add("已经结婚");
    return baseIntroduction;
  }
}


void main() {
  People people = Americans();

  print(people.introduce());

  people = MarriageDecorator(people);
  print(people.introduce());
}
