class Question {
  final String mode;

  Question(this.mode);

  List questions = [
    ['<div></div>', 'div'],
    ['<a href=""></a>', 'a'],
    ['<p><a href=""></a></p>', 'p>a'],
    [
      '''
<ul>
  <li></li>
</ul>
    ''',
      'ul>li'
    ],
    [
      '''
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>
    ''',
      'ul>li*3'
    ],
  ];

  // Todo
  String printQuestion(int i) {
    return questions[i][0];
  }

  // Todo
  String printAnswer(int i) {
    return questions[i][1];
  }

  bool checkTheAnswer(int i, String emmet) {
    if (emmet == questions[i][1]) {
      return true;
    } else {
      return false;
    }
  }
}
