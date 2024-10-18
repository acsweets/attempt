///你正在为一个国际电子商务平台开发支付系统。这个平台需要支持多种支付方式，以适应不同国家和地区的用户偏好。
// 需求：
//
// 系统需要支持多种支付方式，如信用卡支付、PayPal、银行转账等。
// 每种支付方式有其独特的处理流程和验证步骤。
// 系统应该能够根据用户选择的支付方式创建相应的支付处理器。
// 系统需要具有良好的可扩展性，以便将来轻松添加新的支付方式。
//
// 任务：
// 使用工厂方法模式实现这个支付系统。你需要：
//
// 创建一个抽象的 PaymentProcessor 类，定义支付处理的通用接口。
// 实现几个具体的支付处理器类，如 CreditCardProcessor、PayPalProcessor、BankTransferProcessor 等。
// 创建一个抽象的 PaymentProcessorFactory 类。
// 实现具体的工厂类来创建不同类型的支付处理器。
// 在 main() 函数中演示如何使用这个系统处理不同类型的支付。
// 提示：
// 每个支付处理器应该有方法如 processPayment() 和 verifyPayment()。
// 考虑添加一些模拟的支付细节，如金额、货币等。
// 你可以添加一个简单的用户界面模拟（通过控制台输入）来选择支付方式。
// 思考如何处理不同支付方式可能需要的不同信息（例如，信用卡号码 vs PayPal 邮箱）。
//
// 挑战（可选）：
//
// 尝试实现一个动态的支付处理器注册系统，允许在运行时添加新的支付方式。
// 考虑如何处理国际化，例如根据用户的地区提供不同的支付选项。

//
// 这个场景将让你深入理解工厂方法模式，并且在实现过程中可能会遇到一些有趣的设计决策。完成后，你将有一个可以在实际电子商务项目中扩展使用的基础系统。

abstract class PaymentProcessor {
  //处理流程
  processPayment();

//验证
  verifyPayment();
}

class CreditCardProcessor extends PaymentProcessor {
  @override
  processPayment() {
    print('');
  }

  @override
  verifyPayment() {
    print('');
  }
}

class PayPalProcessor extends PaymentProcessor {
  @override
  processPayment() {
    print('');
  }

  @override
  verifyPayment() {
    print('');
  }
}

class BankTransferProcessor extends PaymentProcessor {
  @override
  processPayment() {
    print('');
  }

  @override
  verifyPayment() {
    print('');
  }
}

enum PayType {
  bank,
  card,
  paypal,
}

class PaymentProcessorFactory {
  static PaymentProcessor processingPayments(PayType payType) {
    switch (payType) {
      case PayType.bank:
        return BankTransferProcessor();
      case PayType.card:
        return CreditCardProcessor();
      case PayType.paypal:
        return PayPalProcessor();
      default:
        return throw ('没有这个类型');
    }
  }
}

///  我的缺陷 少了一层 当然简单的创建是可以少这一层的， 但是以后如果拓展的话比较困难

///动态的支付处理器注册系统，允许在运行时添加新的支付方式


