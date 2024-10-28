// 抽象中介者
abstract class ExamMediator {
  void registerStudent(Student student);
  void registerQuestion(Question question);
  void submitAnswer(Student student, int questionId, String answer);
  void startExam();
  void endExam();
  Question? getNextQuestion(Student student);
  void notifyTimeRemaining(int minutes);
}

// 具体中介者 - 考试管理器
class ExamController implements ExamMediator {
  final Map<int, Student> _students = {};
  final Map<int, Question> _questions = {};
  bool _examInProgress = false;
  final Map<int, Map<int, String>> _studentAnswers = {}; // studentId -> {questionId -> answer}

  @override
  void registerStudent(Student student) {
    _students[student.id] = student;
    _studentAnswers[student.id] = {};
    print('考生已注册: ${student.name} (ID: ${student.id})');
  }

  @override
  void registerQuestion(Question question) {
    _questions[question.id] = question;
  }

  @override
  void startExam() {
    if (_students.isEmpty || _questions.isEmpty) {
      print('错误：无法开始考试。确保有考生和试题注册。');
      return;
    }

    _examInProgress = true;
    print('\n考试开始！');
    _students.values.forEach((student) {
      student.notifyExamStarted();
    });
  }

  @override
  void endExam() {
    _examInProgress = false;
    print('\n考试结束！');
    _students.values.forEach((student) {
      calculateScore(student);
    });
  }

  @override
  Question? getNextQuestion(Student student) {
    if (!_examInProgress) return null;

    // 获取学生当前未回答的第一个题目
    for (var question in _questions.values) {
      if (!_studentAnswers[student.id]!.containsKey(question.id)) {
        return question;
      }
    }
    return null;
  }

  @override
  void submitAnswer(Student student, int questionId, String answer) {
    if (!_examInProgress) {
      print('错误：考试未在进行中');
      return;
    }

    _studentAnswers[student.id]![questionId] = answer;
    print('${student.name} 提交了问题 $questionId 的答案');

    // 检查是否所有题目都已答完
    if (_studentAnswers[student.id]!.length == _questions.length) {
      student.notifyComplete();
    }
  }

  @override
  void notifyTimeRemaining(int minutes) {
    if (_examInProgress) {
      print('\n系统通知：还剩 $minutes 分钟');
      _students.values.forEach((student) {
        student.notifyTimeRemaining(minutes);
      });
    }
  }

  void calculateScore(Student student) {
    var score = 0;
    var studentAnswers = _studentAnswers[student.id]!;

    for (var entry in studentAnswers.entries) {
      var question = _questions[entry.key]!;
      if (question.checkAnswer(entry.value)) {
        score += question.points;
      }
    }

    student.notifyScore(score);
  }
}

// 考生类
class Student {
  final int id;
  final String name;
  final ExamMediator _mediator;

  Student(this.id, this.name, this._mediator) {
    _mediator.registerStudent(this);
  }

  void startAnswering() {
    var question = _mediator.getNextQuestion(this);
    if (question != null) {
      answerQuestion(question);
    }
  }

  void answerQuestion(Question question) {
    // 模拟考生思考和作答过程
    print('$name 正在答题：${question.content}');
    // 模拟随机答案
    final answers = ['A', 'B', 'C', 'D'];
    final answer = answers[DateTime.now().millisecond % 4];
    _mediator.submitAnswer(this, question.id, answer);

    // 继续答下一题
    var nextQuestion = _mediator.getNextQuestion(this);
    if (nextQuestion != null) {
      Future.delayed(Duration(seconds: 2), () => answerQuestion(nextQuestion));
    }
  }

  void notifyExamStarted() {
    print('$name 开始答题');
    startAnswering();
  }

  void notifyComplete() {
    print('$name 已完成所有题目');
  }

  void notifyTimeRemaining(int minutes) {
    print('$name 收到通知：还剩 $minutes 分钟');
  }

  void notifyScore(int score) {
    print('$name 的考试得分：$score');
  }
}

// 试题类
class Question {
  final int id;
  final String content;
  final String correctAnswer;
  final int points;

  Question(this.id, this.content, this.correctAnswer, this.points);

  bool checkAnswer(String answer) {
    return answer.toUpperCase() == correctAnswer.toUpperCase();
  }
}

// 使用示例
void main() async {
  // 创建考试管理器（中介者）
  final examController = ExamController();

  // 注册试题
  final questions = [
    Question(1, '1+1=?', 'A', 20),
    Question(2, '2+2=?', 'B', 20),
    Question(3, '3+3=?', 'C', 30),
    Question(4, '4+4=?', 'D', 30),
  ];

  questions.forEach((question) {
    examController.registerQuestion(question);
  });

  // 注册考生
  final student1 = Student(1, '张三', examController);
  final student2 = Student(2, '李四', examController);
  final student3 = Student(3, '王五', examController);

  print('\n=== 开始模拟在线考试 ===\n');

  // 开始考试
  examController.startExam();

  // 模拟考试时间提醒
  await Future.delayed(Duration(seconds: 3));
  examController.notifyTimeRemaining(30);

  await Future.delayed(Duration(seconds: 3));
  examController.notifyTimeRemaining(10);

  // 等待所有考生完成答题
  await Future.delayed(Duration(seconds: 10));

  // 结束考试
  examController.endExam();
}