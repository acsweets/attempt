///正在开发一个角色扮演游戏。在这个游戏中，玩家可以创建各种不同类型的角色，如战士、法师、弓箭手等。每种角色都有一些基本属性（如生命值、魔法值、攻击力等）和特殊能力。
// 需求：
//
// 游戏需要一个灵活的角色创建系统，允许快速创建不同类型的角色。
// 每种角色类型都有一些预设的属性和能力。
// 玩家可以基于这些基本角色模板创建自定义角色，并修改某些属性。
// 系统需要能够轻松地添加新的角色类型。
//
// 任务：
// 使用原型模式实现这个角色创建系统。你需要：
//
// 创建一个抽象的 Character 类，包含基本属性和 clone() 方法。
// 实现几个具体的角色类，如 Warrior、Mage、Archer 等。
// 每个具体角色类都应该实现 clone() 方法。
// 创建一个简单的角色管理系统，允许创建基本角色和自定义角色。
// 在 main() 函数中演示如何使用这个系统创建和自定义角色。
//
// 提示：
//
// 考虑使用 Dart 的工厂构造函数来实现克隆功能。
// 你可以添加一个方法来打印角色的属性，以便于演示。
// 尝试添加一些独特的属性或方法到不同的角色类中，以展示它们的特性。
//
// 这个场景将让你深入理解原型模式，并且在实现过程中可能会遇到一些有趣的挑战。完成后，你将有一个可以在实际游戏开发中使用的基础系统。

///copyWith方法通常用于创建一个对象的副本，同时允许修改某些属性。这种方法确实与原型模式有一些相似之处，但也有一些区别。让我们来详细探讨一下：
//
// 相似点：
//
// 都是用于创建对象的副本
// 都避免了完全重新构造对象的开销
// 都允许在复制过程中对对象进行一定的修改
//
//
// 区别：
//
// 原型模式通常涉及一个clone()方法，该方法创建对象的完整副本
// copyWith通常只复制部分属性，并允许在复制过程中修改这些属性
// 原型模式更强调对象的自我复制能力，而copyWith更像是一个辅助方法
//
//
// 实现方式：
//
// 原型模式通常需要实现一个clone()接口
// copyWith通常是作为对象的一个方法实现的，不需要特定的接口
//
//
//
// 虽然copyWith方法和原型模式有一些相似之处，但严格来说，它们并不完全相同。copyWith更像是原型模式思想的一种简化应用，而不是经典的原型模式实现。

/// 原型模式就是备份一个自己 相当于克隆一个自己再给自己整容，
/// copyWith 相当于基于自己复刻，在复刻时候就调整自己想要的属性
abstract class Role {
  String gender;
  String ability;
  String arms;

  Role({required this.ability, required this.arms, required this.gender});

  Role clone();
}

/// 法师
/// 法师类
class Master extends Role {
  Master({
    super.ability = '魔法攻击', // 给能力设置初始值
    super.arms = '魔杖', // 给武器设置初始值
    super.gender = '未知', // 给性别设置初始值
  });

  @override
  Master clone() {
    return Master(
      ability: ability,
      arms: arms,
      gender: gender,
    );
  }
}

/// 战士
class Warrior extends Role {
  Warrior({
    required super.ability,
    required super.arms,
    required super.gender,
  });

  @override
  Warrior clone() {
    return Warrior(
      ability: ability,
      arms: arms,
      gender: gender,
    );
  }
}

/// 射手

class Shooter extends Role {
  Shooter({
    required super.ability,
    required super.arms,
    required super.gender,
  });

  @override
  Shooter clone() {
    return Shooter(
      ability: ability,
      arms: arms,
      gender: gender,
    );
  }
}

/// 打野

class GoWild extends Role {
  GoWild({
    required super.ability,
    required super.arms,
    required super.gender,
  });

  @override
  GoWild clone() {
    return GoWild(
      ability: ability,
      arms: arms,
      gender: gender,
    );
  }
}

/// 辅助
class Auxiliary extends Role {
  Auxiliary({
    required super.ability,
    required super.arms,
    required super.gender,
  });

  @override
  Auxiliary clone() {
    return Auxiliary(
      ability: ability,
      arms: arms,
      gender: gender,
    );
  }
}

class RoleAdministration {

}


// 抽象的 Character 类
abstract class Character {
  String name;   // 角色名称
  String ability;  // 能力
  String weapon;   // 武器

  Character(this.name, this.ability, this.weapon);

  // 定义 clone 方法，返回克隆后的对象
  Character clone();

  // 打印角色属性
  void displayInfo() {
    print('角色: $name, 能力: $ability, 武器: $weapon');
  }
}


// Mage 角色类
class Mage extends Character {
  Mage({String name = 'Mage', String ability = '魔法攻击', String weapon = '法杖'})
      : super(name, ability, weapon);

  @override
  Mage clone() {
    return Mage(name: name, ability: ability, weapon: weapon);
  }
}

// Archer 角色类
class Archer extends Character {
  Archer({String name = 'Archer', String ability = '远程攻击', String weapon = '弓箭'})
      : super(name, ability, weapon);

  @override
  Archer clone() {
    return Archer(name: name, ability: ability, weapon: weapon);
  }
}

// 角色管理系统类
class CharacterManager {
  // 存储角色模板
  Map<String, Character> characterTemplates = {};

  // 添加角色模板
  void addTemplate(String key, Character character) {
    characterTemplates[key] = character;
  }

  // 基于模板创建角色
  Character? createCharacter(String key) {
    return characterTemplates[key]?.clone();
  }
}

void main() {
  // 创建角色管理系统
  CharacterManager manager = CharacterManager();

  // 添加角色模板
  manager.addTemplate('mage', Mage());
  manager.addTemplate('archer', Archer());

  // 创建基础的战士角色
  Character? warrior = manager.createCharacter('warrior');
  warrior?.displayInfo();

  // 创建基础的法师角色并自定义属性
  Character? customMage = manager.createCharacter('mage');
  customMage?.name = 'Custom Mage';  // 自定义角色名称
  customMage?.weapon = '魔法书';       // 自定义武器
  customMage?.displayInfo();

  // 创建基础的弓箭手角色
  Character? archer = manager.createCharacter('archer');
  archer?.displayInfo();
}
