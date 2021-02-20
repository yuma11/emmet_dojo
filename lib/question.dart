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

  List questions2 = [
    ['<div></div>', 'div'],
    ['<a href=""></a>', 'a'],
    ['<div class="item"></div>', '.item'],
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
    ['<div>\n  <p>hello</p>\n</div>', 'div>p{hello}'],
    ['<a href="#"></a>', 'a[href="#"]'],
    ['<div>\n  <p><span></span></p>\n</div>', 'div>p>span'],
    ['<ul>\n  <li><a href=""></a></li>\n</ul>', 'ul>li>a'],
    ['<img src="a.png" alt="a">', 'img[src="a.png" alt="a"]'],
  ];

  List questions = [
    [
      '<header></header>\n<main></main>\n<footer></footer>',
      'header+main+footer'
    ],
    [
      '<header></header>\n<main>\n  <div></div>\n</main>\n<footer></footer>',
      'header+main>div^footer'
    ],
    ['<div class="item1"></div>\n<div class="item2"></div>', 'div.item\$*2'],
    [
      '<div class="item01"></div>\n<div class="item02"></div>',
      'div.item\$\$*2'
    ],
    [
      '<ul>\n  <li><a href=""></a></li>\n  <li><a href=""></a></li>\n  <li><a href=""></a></li>\n</ul>',
      'ul>(li>a)*3'
    ],
    ['<div>\n  <p><span></span></p>\n  <p></p>\n</div>', 'div>p>span^p'],
    [
      '<div>\n  <p><span></span></p>\n</div>\n<ul>\n  <li><a href=""></a></li>\n</ul>',
      'div>p>span^^ul>li>a'
    ],
    [
      '<div class="item1">\n  <p></p>\n</div>\n<div class="item1">\n  <p></p>\n</div>',
      '(div.item\$>p)*2'
    ],
    ['<div></div>\n<ul></ul>\n<div></div>', 'div+ul+div'],
    ['<div>\n  <p>hello</p>\n  <p>world</p>\n</div>', 'div>p{hello}+p{world}'],
    [
      '<h1 class="item1">header1</h1>\n<h2 class="item2">header2</h2>\n<h3 class="item3">header3</h3>',
      'h\$[class="item\$"]{header\$}*3'
    ],
    ['<div class="item1 item2 item3"></div>', '.item1.item2.item3'],
    [
      '<div class="item1 item2 item3">\n  <p id="item4" class="item5"></p>\n</div>',
      '.item1.item2.item3>p#item4.item5'
    ],
    [
      '<div class="item1">\n  <p></p>\n  <a href=""></a>\n</div>\n<div class="item2">\n  <p></p>\n  <a href=""></a>\n</div>',
      '(.item\$>p+a)*2'
    ],
    [
      '<table>\n  <tr>\n    <th>a</th>\n    <th>b</th>\n  <tr>\n</table>',
      'table>tr>th{a}+th{b}'
    ],
  ];
}
