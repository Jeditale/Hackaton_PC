import 'package:flutter/material.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> selectedAnswers = List<int>.filled(7, -1); // Initialize with -1 (no selection)

  // Questions and answers with scores
  final List<Map<String, Object>> questions = [
    {
      'question': 'Have you been feeling tense, anxious, or restless?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you experienced trouble sleeping?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you been feeling low, sad, or down?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you been experiencing physical pain or fatigue?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you had trouble concentrating?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you felt unable to enjoy the things you used to?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Have you had difficulty controlling your emotions?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
  ];

  void _submitAnswers() {
    int totalScore = selectedAnswers.reduce((sum, element) => sum + element);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(totalScore: totalScore)),
    );
  }

  bool _isSubmitEnabled() {
    return !selectedAnswers.contains(-1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/image/Bg.png',
            fit: BoxFit.cover,
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                // Title Text at the top
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      'How have you been in the past 2 weeks?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24446D),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // Add space before questions

                // Questions and answers
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, questionIndex) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question text
                          Semantics(
                            label: 'Question $questionIndex',
                            child: Text(
                              questions[questionIndex]['question'] as String,
                              key: Key('question_$questionIndex'),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF24446D),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Answers
                          ...((questions[questionIndex]['answers'] as List<Map<String, Object>>)
                              .asMap()
                              .entries
                              .map((entry) {
                            int answerIndex = entry.key;
                            Map<String, Object> answer = entry.value;
                            int answerScore = answer['score'] as int;

                            return Semantics(
                              label:
                                  'Answer $answerIndex for question $questionIndex',
                              child: GestureDetector(
                                key: Key(
                                    'answer_${questionIndex}_$answerIndex'), // Unique key for each answer
                                onTap: () {
                                  setState(() {
                                    selectedAnswers[questionIndex] = answerScore;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Circle checkbox
                                        Container(
                                          margin: EdgeInsets.only(right: 15),
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: selectedAnswers[
                                                            questionIndex] ==
                                                        answerScore
                                                    ? Color(0xFF24446D)
                                                    : Colors.black,
                                                width: 2),
                                          ),
                                          child: selectedAnswers[questionIndex] ==
                                                  answerScore
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFF24446D),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        // Answer text
                                        Text(
                                          answer['text'] as String,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20), // Add space
                                  ],
                                ),
                              ),
                            );
                          }).toList())
                        ],
                      ),
                    );
                  },
                ),
                // Submit Button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 360,
                    height: 73,
                    child: ElevatedButton(
                      key: Key('submit_button'),
                      onPressed: _isSubmitEnabled() ? _submitAnswers : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
