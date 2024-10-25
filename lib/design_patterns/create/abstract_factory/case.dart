/// 抽象工厂的使用场景
///  创建的是一系列的对象
/// 方法工厂使用的场景
/// 创建的是同类型的对象
/// 对象自己内部的行为

/// 思考现实中案例
///下面给你一个复杂一点的工厂模式场景，它涉及多个产品类型和更丰富的逻辑。
///我们使用工厂方法模式来构建一个多级权限管理系统，
///该系统支持不同角色（如管理员、普通用户和访客）的权限操作
///每个角色有不同的操作权限，且可以动态扩展新角色和权限。
//
// 场景：多级权限管理系统
// 假设你正在开发一个大型系统，该系统有多种用户角色（如管理员、普通用户、访客），
// 每个角色能执行不同的操作。使用工厂方法模式来管理不同角色的权限，
// 并为每个角色动态生成相应的权限控制器。
//
// 系统要求：
// 不同用户角色：如管理员、普通用户、访客。
// 角色权限不同：管理员能进行添加、删除、修改操作，普通用户只能修改，访客只能查看。
// 支持动态扩展：能够在不修改现有系统的情况下，轻松添加新的用户角色和权限。
// 实现思路：
// 定义一个权限控制器接口，所有角色的权限控制器都必须实现该接口。
// 实现不同角色的权限控制器（如管理员权限控制器、普通用户权限控制器）。
// 定义一个工厂接口，负责生成不同角色的权限控制器。
// 使用具体工厂类为每个角色生成相应的权限控制器。
// 支持动态注册新角色和权限控制器

abstract class PermissionController {
  bool view();

  bool edit();

  bool delete();
}

class Admin implements PermissionController {
  @override
  bool delete() => true;

  @override
  bool edit() => true;

  @override
  bool view() => true;
}

class User implements PermissionController {
  @override
  bool delete() => false;

  @override
  bool edit() => true;

  @override
  bool view() => true;
}

class Visitor implements PermissionController {
  @override
  bool delete() => false;

  @override
  bool edit() => false;

  @override
  bool view() => true;
}

abstract class PermissionFactory {
  PermissionController create();
}

class VisitorFactory extends PermissionFactory {
  @override
  PermissionController create() => Visitor();
}

class UserFactory extends PermissionFactory {
  @override
  PermissionController create() => User();
}

class AdminFactory extends PermissionFactory {
  @override
  PermissionController create() => Admin();
}

class PermissionSystem {
  static final Map<String, PermissionFactory> _factoryRegistry = {};

  // 注册工厂
  void registerRole(String role, PermissionFactory factory) {
    _factoryRegistry[role] = factory;
  }

  // 获取权限控制器
  PermissionController? getPermissionController(String role) {
    if (_factoryRegistry.containsKey(role)) {
      return _factoryRegistry[role]!.create();
    }
    print("No permissions found for role: $role");
    return null;
  }
}
