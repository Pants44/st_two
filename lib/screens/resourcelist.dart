import 'package:flutter/material.dart';

import 'package:st_two/bloc/resourcelistbloc.dart';
import 'package:st_two/data/processtickets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ResourceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResourceBloc>(
      builder: (context) =>
          ResourceBloc(httpClient: http.Client())..add(Fetch()),
      child: RLPageBody(),
    );
  }
}

class RLPageBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final ResourceBloc resourceBloc = BlocProvider.of<ResourceBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Resources',
          ),
          onChanged: (text) {
            resourceBloc.add(FilterList(filtervalue: text));
          },
        ),
      ),
      body: BlocBuilder<ResourceBloc, ResourceState>(
        builder: (context, state) {
          if (state is ResourceUninitialized) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ResourceError) {
            return Center(
              child: Text('failed to fetch Resources'),
            );
          } else if (state is ResourceLoaded) {
            if (state.resourcesList.resources.isEmpty) {
              return Center(
                child: Text('no resources'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.resourcesList.resources.length
                    ? BottomLoader()
                    : ResourceWidget(
                    resource: state.resourcesList.resources[index]);
              },
              itemCount: state.resourcesList.resources.length,
              //controller: _scrollController,
            );
          } else {
            return Container(
              child: Center(
                child: Text('the abyss, nothing here'),
              ),
            );
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class ResourceWidget extends StatelessWidget {
  final Resource resource;

  const ResourceWidget({Key key, @required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${resource.resourceid}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(resource.resourcename),
      isThreeLine: true,
      subtitle: Text(resource.email),
      dense: true,
    );
  }
}
