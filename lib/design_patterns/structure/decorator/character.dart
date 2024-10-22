// 定义角色接口
abstract class Character {
  String getDescription();
  int getAttackPower();
}

// 基础角色类（如战士）
class Warrior implements Character {
  @override
  String getDescription() {
    return "Warrior";
  }

  @override
  int getAttackPower() {
    return 10;  // 基础攻击力
  }
}

// 抽象装饰器类，继承自Character
abstract class CharacterDecorator implements Character {
  final Character _character;

  CharacterDecorator(this._character);

  @override
  String getDescription() {
    return _character.getDescription();
  }

  @override
  int getAttackPower() {
    return _character.getAttackPower();
  }
}

// 装备剑的装饰器，增加攻击力
class SwordDecorator extends CharacterDecorator {
  SwordDecorator(super.character);

  @override
  String getDescription() {
    return "${super.getDescription()} with Sword";
  }

  @override
  int getAttackPower() {
    return super.getAttackPower() + 15;  // 剑增加15点攻击力
  }
}

// 装备盾的装饰器，增加防御力（在这里我们简单地用它增加攻击力来演示）
class ShieldDecorator extends CharacterDecorator {
  ShieldDecorator(super.character);

  @override
  String getDescription() {
    return "${super.getDescription()} with Shield";
  }

  @override
  int getAttackPower() {
    return super.getAttackPower() + 5;  // 盾增加5点攻击力
  }
}
