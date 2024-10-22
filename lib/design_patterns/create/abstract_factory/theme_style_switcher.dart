///你可以设计一个主题工厂，它可以生产适用于不同平台的按钮和对话框。
///
/// 创建一个抽象工厂来生产以下两个抽象产品：
// 按钮（Button）
// 对话框（Dialog）

// 并实现针对以下三个平台的具体工厂：
// 安卓风格的按钮和对话框
// iOS 风格的按钮和对话框
// 桌面应用风格的按钮和对话框

abstract class Button {}

class AndroidButton extends Button {}

class IosButton extends Button {}

class WindowsButton extends Button {}

abstract class Dialog {}

class AndroidDialog extends Dialog {}

class IosDialog extends Dialog {}

class WindowsDialog extends Dialog {}

abstract class Theme {
  Button createButton();

  Dialog createDialog();
}

class AndroidTheme extends Theme {
  @override
  Button createButton() {
    return AndroidButton();
  }

  @override
  Dialog createDialog() {
    return AndroidDialog();
  }
}

class IosTheme extends Theme {
  @override
  Button createButton() {
    return IosButton();
  }

  @override
  Dialog createDialog() {
    return IosDialog();
  }
}

class WindowsTheme extends Theme {
  @override
  Button createButton() {
    return WindowsButton();
  }

  @override
  Dialog createDialog() {
    return WindowsDialog();
  }
}

///优化 + 一个工厂生成器 根据平台动态获取主题，而不需要手动选择具体的 Theme 实现类。

class ThemeFactory {
  static Theme createTheme(String platform) {
    switch (platform) {
      case 'android':
        return AndroidTheme();
      case 'ios':
        return IosTheme();
      case 'windows':
        return WindowsTheme();
      default:
        throw Exception('Unknown platform');
    }
  }
}