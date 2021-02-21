import 'dart:math' as math;

class Question {
  final String mode;
  Question(this.mode);

  int returnQuestionLength(String mode) {
    switch (mode) {
      case 'レベル１':
        return questions1.length;
        break;
      case 'レベル２':
        return questions2.length;
        break;
      case 'レベル３':
        return questions3.length;
        break;
      default:
        return 15;
        break;
    }
  }

  // Todo
  String printQuestion(String mode, int i) {
    switch (mode) {
      case 'レベル１':
        return questions1[i][0];
        break;
      case 'レベル２':
        return questions2[i][0];
        break;
      case 'レベル３':
        return questions3[i][0];
        break;
      default:
        break;
    }
  }

  // Todo
  String printAnswer(String mode, int i, int randIndex) {
    switch (mode) {
      case 'レベル１':
        return questions1[i][1];
        break;
      case 'レベル２':
        return questions2[i][1];
        break;
      case 'レベル３':
        return questions3[i][1];
        break;
      default:
        List sumQuestion = [...questions1, ...questions2, ...questions3];
        print(randIndex);
        return sumQuestion[randIndex][1];
        break;
    }
  }

  bool checkTheAnswer(String mode, int i, String emmet, int randIndex) {
    switch (mode) {
      case 'レベル１':
        if (emmet == questions1[i][1]) {
          return true;
        } else {
          return false;
        }
        break;
      case 'レベル２':
        if (emmet == questions2[i][1]) {
          return true;
        } else {
          return false;
        }
        break;
      case 'レベル３':
        if (emmet == questions3[i][1]) {
          return true;
        } else {
          return false;
        }
        break;
      default:
        List sumQuestion = [...questions1, ...questions2, ...questions3];
        if (emmet == sumQuestion[randIndex][1]) {
          return true;
        } else {
          return false;
        }
        break;
    }
  }

  String randomQuestion(int i, int randIndex) {
    List sumQuestion = [...questions1, ...questions2, ...questions3];
    if (i < 15 && randIndex == 0) {
      var rand = math.Random();
      int randIndex = rand.nextInt(40);
      return sumQuestion[randIndex][0];
    } else if (i < 15) {
      return sumQuestion[randIndex][0];
    }
  }

  List questions1 = [
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

  List questions2 = [
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

  List questions3 = [
    [
      '''
<div>
  <header>
    <ul>
      <li><a href=""></a></li>
      <li><a href=""></a></li>
    </ul>
  </header>
  <footer>
    <p></p>
  </footer>
</div>
      ''',
      'div>(header>ul>li*2>a)+footer>p'
    ],
    [
      '''
<div class="item1">
  <div class="item2">
    <img src="" alt="">
    <p></p>
    <img src="" alt="">
    <p></p>
  </div>
</div>
<footer>
  <p></p>
</footer>
      ''',
      '(.item1>.item2>(img+p)*2)+footer>p'
    ],
    [
      '''
<ul>
  <li class="item5"></li>
  <li class="item4"></li>
  <li class="item3"></li>
  <li class="item2"></li>
  <li class="item1"></li>
</ul>
      ''',
      'ul>li.item\$@-*5'
    ],
    [
      '''
<ul>
  <li class="item3"></li>
  <li class="item4"></li>
  <li class="item5"></li>
  <li class="item6"></li>
  <li class="item7"></li>
</ul>
      ''',
      'ul>li.item\$@3*5'
    ],
    [
      '''
<ul>
  <li class="item1" data-item3=""></li>
  <li class="item2" data-item2=""></li>
  <li class="item3" data-item1=""></li>
</ul>
      ''',
      'ul>li.item\$[data-item\$@-]*3'
    ],
    [
      '''
<table>
  <tr>
    <th>a</th>
    <th>b</th>
  </tr>
  <tr>
    <td>c</td>
    <td>d</td>
  </tr>
</table>
      ''',
      'table>(tr>th{a}+th{b})+tr>td{c}+td{d}'
    ],
    [
      '''
<div id="item">
  <p>Click<a href="#">ME</a></p>
</div>
      ''',
      '#item>p>{Click}a[href=#]{ME}'
    ],
    [
      '''
<div>
  <img src="" alt="">
  <p>I<span>Love</span><a href="">Program</a></p>
</div>
<p></p>
      ''',
      'div>img+p>{I}span{Love}+a{Program}^^p'
    ],
    [
      '''
<div class="item1">
  <ul>
    <li class="item2"></li>
    <li class="item1"></li>
  </ul>
  <div class="item2"></div>
</div>
      ''',
      '.item1>(ul>li.item\$@-*2>)+.item2'
    ],
    [
      '''
<div class="item1">
  <p id="item2" class="item3 item4"><a href="#">hello</a></p>
  <img src="a.png" alt="a">
</div>
      ''',
      '.item1>p#item2.item3.item4>a[href="#"]{hello}^img[src="a.png" alt="a"]'
    ],
  ];
}
