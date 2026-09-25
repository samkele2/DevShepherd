import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dev_shepherd/models/technology.dart';
import 'package:dev_shepherd/models/technologies.dart';
import 'package:dev_shepherd/pages/learning_goals_page.dart';
import 'package:dev_shepherd/pages/skills_page.dart';
import 'package:dev_shepherd/data/learning_goal_data.dart';
import 'package:dev_shepherd/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dev_shepherd/services/firebase_auth_service.dart';
import 'package:dev_shepherd/services/firebase_learning_goal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //run app on whatever platform
  );
  print(FirebaseAuth.instance.currentUser);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dev Shepherd',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
        home: FirebaseAuth.instance.currentUser == null
            ? AuthPage(
          authService: FirebaseAuthService(FirebaseAuth.instance),
        )
            : const MyHomePage(
          title: 'Dev Shepherd Home Page',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Technologies technologies = Technologies();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
          const Text('Welcome to DevShepherd.'),
          const Text('Your journey from learner to developer starts here.'),

          // const Text('Learning goals',
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         decoration: TextDecoration.underline)),
          Card(
            child:  Padding(padding: const EdgeInsets.all(6),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LearningGoalsPage(
                        learningGoalService: FirebaseLearningGoalService(
                          FirebaseFirestore.instance,
                        ),
                      ),
                ),
                ).then((_) {
                  setState(() {

                  });
                });
              },
            child: Column(
              children: [
              Text('Learning goals',
                style: TextStyle(
                    fontWeight: FontWeight.bold,),
          ),
              if (learningGoals.length == 1)
                Text('${learningGoals.length} goal',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)
              else
                Text(
                  '${learningGoals.length} goals',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),)

              ],)
            ),
            ),
          ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Text('Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    Text('$completedGoals / $totalGoals goals completed'),
                    Text('${(progress*100).round()}% Complete'),

                    LinearProgressIndicator(
                        value: progress,
                        backgroundColor:
                        Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent,)),
                  ],

                ),
              ),
            ),
            SizedBox(height: 10),


          Card(
            child:  Padding(padding: const EdgeInsets.all(6),

                child: Column(
                  children: [
                    Text('Skills',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                    for (Technology tech in technologies.technologies)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                            builder: (context) => SkillsPage(technology: tech),
                          )
                          );
                        },
                        child: ListTile(
                          title: Text(tech.name),
                          subtitle: Text('${tech.skills.length} topics'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),),
                  ],
              ),
            ),
          ),
          ],
          ),
    ),),);
  }
}
