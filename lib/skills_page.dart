import 'package:flutter/material.dart';
import 'package:dev_shepherd/technologies.dart';
import 'package:dev_shepherd/technology.dart';
import 'package:dev_shepherd/skill.dart';


class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});


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
            'Skills Page',
        style: TextStyle(
            fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children: [
          for (Technology tech in technologies.technologies)
            ExpansionTile(
              title: Text(tech.name),
              children: [
                for (Skill skill in tech.skills)
                  ListTile(
                    title: Text(skill.name),
                    subtitle: Text(skill.level.name),
                    trailing: IconButton(onPressed: () {
                      setState(() {
                        skill.advanceLevel();
                      });
                    },
                    icon: const Icon(Icons.arrow_upward),
                  ),
                  ) ],
            ),
        ],
      ),

        );
  }
}
