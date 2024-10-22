// 支付处理器的抽象类
abstract class PaymentProcessor {
  String amount;
  String currency;

  PaymentProcessor(this.amount, this.currency);

  // 支付处理方法
  void processPayment();
  // 支付验证方法
  void verifyPayment();
}

// 信用卡支付处理器
class CreditCardProcessor extends PaymentProcessor {
  String cardNumber;

  CreditCardProcessor(super.amount, super.currency, this.cardNumber);

  @override
  void processPayment() {
    print('Processing credit card payment of $amount $currency using card $cardNumber.');
  }

  @override
  void verifyPayment() {
    print('Verifying credit card payment for card $cardNumber.');
  }
}

// PayPal支付处理器
class PayPalProcessor extends PaymentProcessor {
  String email;

  PayPalProcessor(super.amount, super.currency, this.email);

  @override
  void processPayment() {
    print('Processing PayPal payment of $amount $currency for account $email.');
  }

  @override
  void verifyPayment() {
    print('Verifying PayPal payment for account $email.');
  }
}

// 银行转账处理器
class BankTransferProcessor extends PaymentProcessor {
  String bankAccount;

  BankTransferProcessor(super.amount, super.currency, this.bankAccount);

  @override
  void processPayment() {
    print('Processing bank transfer of $amount $currency to account $bankAccount.');
  }

  @override
  void verifyPayment() {
    print('Verifying bank transfer for account $bankAccount.');
  }
}

// 抽象支付处理器工厂
abstract class PaymentProcessorFactory {
  PaymentProcessor createPaymentProcessor(String amount, String currency, String detail);
}

// 信用卡支付处理器工厂
class CreditCardProcessorFactory extends PaymentProcessorFactory {
  @override
  PaymentProcessor createPaymentProcessor(String amount, String currency, String cardNumber) {
    return CreditCardProcessor(amount, currency, cardNumber);
  }
}

// PayPal支付处理器工厂
class PayPalProcessorFactory extends PaymentProcessorFactory {
  @override
  PaymentProcessor createPaymentProcessor(String amount, String currency, String email) {
    return PayPalProcessor(amount, currency, email);
  }
}

// 银行转账支付处理器工厂
class BankTransferProcessorFactory extends PaymentProcessorFactory {
  @override
  PaymentProcessor createPaymentProcessor(String amount, String currency, String bankAccount) {
    return BankTransferProcessor(amount, currency, bankAccount);
  }
}

// 主函数展示如何处理不同支付方式

class PaymentProcessorRegistry {
  static final Map<String, PaymentProcessorFactory> _registry = {};

  // 注册支付处理器
  static void registerProcessor(String name, PaymentProcessorFactory factory) {
    _registry[name] = factory;
  }

  // 获取支付处理器工厂
  static PaymentProcessorFactory? getProcessorFactory(String name) {
    return _registry[name];
  }
}

void main() {
  // 注册支付方式
  PaymentProcessorRegistry.registerProcessor('credit_card', CreditCardProcessorFactory());
  PaymentProcessorRegistry.registerProcessor('paypal', PayPalProcessorFactory());
  PaymentProcessorRegistry.registerProcessor('bank_transfer', BankTransferProcessorFactory());

  // 模拟用户选择支付方式
  String? option = 'credit_card';

  PaymentProcessorFactory? factory = PaymentProcessorRegistry.getProcessorFactory(option);
  if (factory != null) {
    PaymentProcessor processor = factory.createPaymentProcessor('200', 'USD', 'user@example.com');
    processor.processPayment();
    processor.verifyPayment();
  } else {
    print("支付方式不可用");
  }
}
