import 'package:flutter/material.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> selectedAnswers = List<int>.filled(7, -1); // Initialize with -1 (no selection)

  // Questions and answers with scores (translated to English)
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
      'question': 'Can you stop or control your worries?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Do you worry excessively about different things?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Do you find it difficult to relax?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Do you feel restless and unable to sit still?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Do you get irritated or frustrated easily?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
    {
      'question': 'Do you feel that something bad might happen?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Some days', 'score': 1},
        {'text': 'More than 7 days in the past 2 weeks', 'score': 2},
        {'text': 'Almost every day', 'score': 3},
      ]
    },
  ];

  void _submitAnswers() {
    // Calculate total score by summing the selected answers
    int totalScore = selectedAnswers.reduce((sum, element) => sum + element);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(totalScore: totalScore)),
    );
  }

  bool _isSubmitEnabled() {
    // Check if all questions have been answered
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
            'assets/image/Bg.png', // Ensure Bg.png is located inside the assets folder
            fit: BoxFit.cover,
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                // Title Text at the top (Centered)
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      'How have you been in the past 2 weeks?',
                      textAlign: TextAlign.center, // Center-align the text
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24446D),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // Add space before the questions

                // Questions and answers
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling here, use the parent ListView
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 19), // 19px space between each question
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question text
                          Text(
                            questions[index]['question'] as String,
                            style: TextStyle(
                              fontSize: 24, // Increased size
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24446D),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Answers
                          ...((questions[index]['answers'] as List<Map<String, Object>>)
                              .map((answer) {
                            int answerScore = answer['score'] as int;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAnswers[index] = answerScore;
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
                                              color: selectedAnswers[index] == answerScore
                                                  ? Color(0xFF24446D)
                                                  : Colors.black,
                                              width: 2),
                                        ),
                                        child: selectedAnswers[index] == answerScore
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
                                          fontSize: 18, // Increased size
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Add vertical space between answer options
                                  SizedBox(height: 20), // Increased space
                                ],
                              ),
                            );
                          }).toList())
                        ],
                      ),
                    );
                  },
                ),
                // Submit Button at the bottom
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 360,
                    height: 73,
                    child: ElevatedButton(
                      onPressed: _isSubmitEnabled() ? _submitAnswers : null, // Disable if not all answers are selected
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
