#import('dart:html');

List fromTextToWords(String text) {
  var textWithout = text.replaceAll(',', '').replaceAll(';', '').
      replaceAll('.', '').replaceAll('?', '').replaceAll('!', '').
      replaceAll('(', '').replaceAll(')', '').replaceAll('\$', '').
      replaceAll('"', '').replaceAll("'", '').replaceAll('\n', ' ');
  return textWithout.split(' ');
}

Map analyzeWordFrequency(List wordList) {
  var wordFrequencyMap = new Map();
  for (var w in wordList) {
    var word = w.trim();
    if (word != '') {
      if (!wordFrequencyMap.containsKey(word)) {
        wordFrequencyMap[word] = 0;
      }
      wordFrequencyMap[word] = wordFrequencyMap[word] + 1;
    }
  }
  return wordFrequencyMap;
}

List sortWords(Map wordFrequencyMap) {
  var wordWordFrequencyMap = new Map<String, String>();
  wordFrequencyMap.forEach((k, v) =>
      wordWordFrequencyMap[k] = '${k}: ${v.toString()}');
  List sortedWordList = wordWordFrequencyMap.getValues();
  sortedWordList.sort((m,n) => m.compareTo(n));
  return sortedWordList;
}

void main() {
  TextAreaElement textArea = document.query('#text');
  TextAreaElement wordsArea = document.query('#words');
  ButtonElement wordsButton = document.query('#frequency');
  wordsButton.on.click.add((MouseEvent e) {
    wordsArea.value = 'Word: frequency \n';
    var text = textArea.value.trim();
    if (text != '') {
      var wordsList = fromTextToWords(textArea.value);
      var wordsMap = analyzeWordFrequency(wordsList);
      var sortedWordsList = sortWords(wordsMap);
      sortedWordsList.forEach((word) =>
          wordsArea.value = '${wordsArea.value} \n${word}');
    }
  });
}


