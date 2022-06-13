import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _correct = 0;

  final List<Question> _questionList = [
    Question('Graphical representation of Algorithm is a Flowchart.', true),
    Question('C++ is an Object Oriented Language.', true),
    Question('Python is a Strongly typed language.', false),
    Question('Octal number system contains digits from 0 - 7.', true),
    Question('CPU controls only input data of computer.', false),
    Question('CPU stands for Central Performance Unit.', false),
    Question(
        'The hexadecimal number system contains digits from 1 - 15.', false),
    Question(
        'The Language that the computer can understand is called Machine Language.',
        true),
    Question('GNU / Linux is a open source operating system.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionList[_questionNumber].questionText;
  }

  bool quizEnd() {
    return _questionNumber == _questionList.length - 1;
  }

  bool getQuestionAns() {
    return _questionList[_questionNumber].questionAns;
  }

  void reset() {
    _questionNumber = 0;
    _correct = 0;
  }

  int getTotalQuestions() {
    return _questionList.length;
  }

  int getScore() {
    return _correct;
  }

  void incrementScore() {
    _correct++;
  }
}
