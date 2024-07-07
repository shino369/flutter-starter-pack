class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final List<String> shuffleList = List.of(answers);
    shuffleList.shuffle();
    return shuffleList;
  }
}
