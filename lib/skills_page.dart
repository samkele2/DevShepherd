import 'package:flutter/material.dart';
import 'package:dev_shepherd/technologies.dart';
import 'package:dev_shepherd/technology.dart';
import 'package:dev_shepherd/skill.dart';


class SkillsPage extends StatefulWidget {

  final Technology technology;

  const SkillsPage({
    super.key,
    required this.technology,
  });


  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class  _SkillsPageState extends State<SkillsPage> {
  Technologies technologies = Technologies();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.technology.name} Skills Page',
        style: TextStyle(
            fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children: [
      for (Skill skill in widget.technology.skills)
        ListTile(
        title: Text(skill.name),
        subtitle: Column(
          children: [
            Text(skill.level.name),
            LinearProgressIndicator(value: skill.progress,)
    ],
    ),

      trailing: IconButton(
        onPressed: () {
          setState(() {
            skill.advanceLevel();
        });
      },
    icon: const Icon(Icons.arrow_upward),
    ),
    ),
        ],),

      );


  }
}
