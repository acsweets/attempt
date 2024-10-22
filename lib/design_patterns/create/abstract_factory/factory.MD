### 设计模式之 工厂模式小案例 
抽象工厂模式 
工厂方法模式 
区别 ：一个产品 ** 各种类型的桌子 **   和一系列产品组  各种风格的家具包含各种风格的桌子板凳等。

#### 小案例

模拟电子商务平台开发支付系统。支持多种支付方式，以适应不同国家。
需求：
1. 系统需要支持多种支付方式，如信用卡支付、PayPal、银行转账等。
2. 每种支付方式有其独特的处理流程和验证步骤。
3. 系统应该能够根据用户选择的支付方式创建相应的支付处理器。
4. 系统需要具有良好的可扩展性，以便将来轻松添加新的支付方式。

 使用工厂方法模式实现这个支付系统。
1. 创建一个抽象的 PaymentProcessor 类，定义支付处理的通用接口。
2. 实现几个具体的支付处理器类，如 CreditCardProcessor、PayPalProcessor、BankTransferProcessor 等。
3. 创建一个抽象的 PaymentProcessorFactory 类。
4. 实现具体的工厂类来创建不同类型的支付处理器。
* 每个支付处理器应该有方法如 processPayment() 和 verifyPayment()。
* 考虑添加一些模拟的支付细节，如金额、货币等。
* 模拟选择不同的支付方式。
* 动态的支付处理器注册系统，在运行时能够添加新的支付方式。

抽象支付处理器类 PaymentProcessor：
这是一个抽象类，定义了处理支付和验证支付的通用接口。

具体支付处理器类：
比如 CreditCardProcessor、PayPalProcessor、BankTransferProcessor，每个支付处理器实现了 PaymentProcessor 的接口。

抽象工厂类 PaymentProcessorFactory：
抽象工厂类负责生成支付处理器。

具体工厂类：
比如 CreditCardProcessorFactory、PayPalProcessorFactory、BankTransferProcessorFactory，每个工厂负责创建相应的支付处理器。

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

CreditCardProcessor(String amount, String currency, this.cardNumber)
: super(amount, currency);

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

PayPalProcessor(String amount, String currency, this.email) : super(amount, currency);

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

BankTransferProcessor(String amount, String currency, this.bankAccount)
: super(amount, currency);

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
void main() {
// 模拟用户输入选择支付方式
print("选择支付方式: 1) 信用卡  2) PayPal  3) 银行转账");
String? option = '1'; // 可以替换成用户输入

PaymentProcessorFactory? factory;
PaymentProcessor? processor;

switch (option) {
case '1':
factory = CreditCardProcessorFactory();
processor = factory.createPaymentProcessor('100', 'USD', '1234-5678-9012');
break;
case '2':
factory = PayPalProcessorFactory();
processor = factory.createPaymentProcessor('100', 'USD', 'user@example.com');
break;
case '3':
factory = BankTransferProcessorFactory();
processor = factory.createPaymentProcessor('100', 'USD', 'Bank-Account-12345');
break;
default:
print("无效的选项");
return;
}

processor?.processPayment();
processor?.verifyPayment();
}
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

PaymentProcessorFactory? factory = PaymentProcessorRegistry.getProcessorFactory(option!);
if (factory != null) {
PaymentProcessor processor = factory.createPaymentProcessor('200', 'USD', 'user@example.com');
processor.processPayment();
processor.verifyPayment();
} else {
print("支付方式不可用");
}
}


