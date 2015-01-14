library roller;

import "dart:math" as Math;

Math.Random _random = new Math.Random(new DateTime.now().millisecondsSinceEpoch);

class Roller {
  static const String ERROR = "*Roll Error*";

  Roller();

  static int rollDie(int sides) {
    return _random.nextInt(sides) + 1;
  }

  static String roll(int qty, int sides, int mod, {bool htmlOutput: true}) {
    if (qty < 1 || sides < 1) {
      return ERROR;
    }

    StringBuffer sb = new StringBuffer();

    int total = 0;
    int rollsTotal = 0;
    List<int> rolls = new List<int>(qty);

    for (int i = 0; i < qty; i++) {
      rolls[i] = rollDie(sides);
      rollsTotal += rolls[i];
    }

    total = rollsTotal + mod;

    String modStr = (mod == 0) ? "" : " " + (mod > 0 ? "+" : "-") + " " + mod.abs().toString();

    sb.write("${qty}d${sides} $rolls$modStr = ");

    String totalStr = htmlOutput ? "<b>$total</b>" : "$total";

    sb.write(totalStr);

    return sb.toString();
  }

  static String rollFromFormula(str, {bool htmlOutput: true}) {
    int sides;
    int qty = 0;
    int mod = 0;

    // strip out all spaces and convert to lowercase
    str = str.replaceAll(' ', '').toLowerCase();

    /*
    // RegExp broken out
    String re1 = r'(\d+)*';      // multi-digit integer (optional)
    String re2 = r'd';           // "d" (required, but not remembered in the match array)
    String re3 = r'([1-9]\d*)';  // multi-digit integer greater than 0 (required)
    String re4 = r'([-+]\d+)*';  // +/- and multi-digit integer (optional)
    RegExp exp = new RegExp(re1+re2+re3+re4, multiLine: false, caseSensitive: false);
    */

    RegExp exp = new RegExp(r"(\d+)*d([1-9]\d*)([-+]\d+)*", multiLine: false, caseSensitive: false);
    Match matches = exp.firstMatch(str);

    // if there are no matches, the string is an invalid expression
    if (matches == null) {
      return ERROR;
    }

    // DEBUG
//    if (matches != null) {
//        print("Group Count: ${matches.groupCount}\n");
//        for (int i = 0; i <= matches.groupCount; i++) {
//          print("$i: ${matches[i]}");
//        }
//  	}
//    else {
//      print("No RegExp match!");
//    }

    // process qty (default to 1 if not included or not valid)
    if (matches[1] != null) {
      int qtyInt = int.parse(matches[1]);
      qty = qtyInt > 1 ? qtyInt : 1;
    }
    else {
      qty = 1;
    }

    // process die sides
    sides = int.parse(matches[2]);

    // process modifier
    if (matches[3] != null) {
      String match = matches[3];

      if (match.length > 1) {
        String sign = match[0];
        int modInt = int.parse(match.substring(1, match.length));

        if (sign == "-") {
          modInt *= -1;
        }

        mod = modInt;
      }
    }

    return roll(qty, sides, mod, htmlOutput: htmlOutput);
  }
}
