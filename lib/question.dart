class Question {
  final String mode;
  Question(this.mode);

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

  List questions = [
    ['<div></div>', 'div'],
    ['<a href=""></a>', 'a'],
    ['<p><a href=""></a></p>', 'p>a'],
    ['<ul>\n  <li></li>\n</ul>', 'ul>li'],
    ['<h1 class="title"></h1>', 'h1.title'],
    ['<h1 id="title"></h1>', 'h1#title'],
    ['<img src="" alt="">', 'img'],
    ['<p>hello</p>', 'p{hello}'],
    ['<ul>\n  <li></li>\n  <li></li>\n  <li></li>\n</ul>', 'ul>li*3'],
    [
      '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  
</body>
</html>
    ''',
      '!'
    ],
  ];
}
