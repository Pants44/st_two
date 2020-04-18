import 'package:flutter/material.dart';

import 'package:st_two/data/connect.dart';
import 'package:st_two/data/skill.dart';

import 'package:st_two/screens/skill.dart';

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
      body: FutureBuilder<int>(
        future: Session().getCompany(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              print(snapshot.error);
            }
            return snapshot.hasData ? FutureBuilder<SkillList>(
              future: SkillList().fetch(snapshot.data),
              builder: (context, snapshottwo) {
                if (snapshottwo.connectionState == ConnectionState.done) {
                  if (snapshottwo.hasError) {
                    print(snapshottwo.error);
                  }
                  return snapshottwo.hasData
                      ? ListView.builder(
                    itemCount: snapshottwo.data.skills.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                        onTap: () {
                          print('Open Skill ' +
                              snapshottwo.data.skills[index].skillid
                                  .toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkillPage(
                                mode: 'edit',
                                ronly: true,
                                title: 'View Skill',
                                skillid: snapshottwo.data.skills[index].skillid,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(snapshottwo
                                .data.skills[index].skillname
                                .toString()),
                          ),
                        ),
                      )
                          : snapshottwo.data.skills[index].skillname
                          .contains(filter.toLowerCase())
                          ? GestureDetector(
                        onTap: () {
                          print('Open Skill ' +
                              snapshottwo
                                  .data.skills[index].skillname
                                  .toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkillPage(
                                  mode: 'edit',
                                  ronly: true,
                                  title: 'Skill ' +
                                      snapshottwo.data.skills[index]
                                          .skillname
                                          .toString(),
                                  skillid:
                                  snapshottwo.data.skills[index].skillid),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(snapshottwo
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
            ) : Center(child: CircularProgressIndicator());
          }else{
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