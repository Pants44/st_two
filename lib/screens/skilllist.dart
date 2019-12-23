import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/screens/skill.dart';
import 'package:st_two/data/processtickets.dart';

import 'package:http/http.dart' as http;

class SkillListPage extends StatefulWidget {
  SkillListPage({Key key, this.title}) : super(key: key);

  final title;

  @override
  _SkillListPageState createState() => _SkillListPageState();
}

class _SkillListPageState extends State<SkillListPage> {
  TextEditingController tecSearch = TextEditingController();

  String filter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecSearch.addListener(() {
      setState(() {
        filter = tecSearch.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    filter = null;
    tecSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: TextField(
          controller: tecSearch,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Skills',
          ),
          onChanged: (text) {},
        ),
      ),
      body: FutureBuilder<SkillList>(
        future: fetchSkills(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.skills.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                print('Open Skill ' +
                                    snapshot.data.skills[index].skillid
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SkillPage(
                                      mode: 'edit',
                                      ronly: true,
                                      title: 'View Skill',
                                      skill: snapshot.data.skills[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(snapshot
                                      .data.skills[index].skillname
                                      .toString()),
                                ),
                              ),
                            )
                          : snapshot.data.skills[index].skillname
                                      .contains(filter.toLowerCase())
                              ? GestureDetector(
                                  onTap: () {
                                    print('Open Skill ' +
                                        snapshot
                                            .data.skills[index].skillname
                                            .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SkillPage(
                                            mode: 'edit',
                                            ronly: true,
                                            title: 'Skill ' +
                                                snapshot.data.skills[index]
                                                    .skillname
                                                    .toString(),
                                            skill:
                                                snapshot.data.skills[index]),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(snapshot
                                          .data.skills[index].skillname
                                          .toString()),
                                    ),
                                  ),
                                )
                              : Container();
                    },
                  )
                : Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SkillPage(
                mode: 'add',
                ronly: false,
                title: 'Add Skill',
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<SkillList> fetchSkills() async {
  var jsonString = await http.get(serverreqaddress + "/skills");
  final jsonResponse = json.decode(jsonString.body.toString());
  SkillList skilllist = new SkillList.fromJson(jsonResponse);
  return skilllist;
}
