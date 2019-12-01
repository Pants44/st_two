import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:st_two/data/processtickets.dart';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

///        Bloc        ///

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final http.Client httpClient;
  final String mode;

  ResourceBloc({@required this.httpClient, @required this.mode});

  @override
  // TODO: implement initialState
  ResourceState get initialState => ResourceUninitialized();

  @override
  Stream<ResourceState> mapEventToState(ResourceEvent event) async* {
    // TODO: implement mapEventToState
    final currentState = state;

    if(event is Load){
      try{
        if(currentState is ResourceUninitialized){
          final eventmode = event.mode.toString();
          print('resource initialized');
          yield ResourceLoaded(mode: eventmode);
        }
      } catch (_) {
        yield ResourceError();
      }
    } else if(event is SwitchMode){
      try{
        if(currentState is ResourceLoaded){
          final eventmode = event.mode.toString();
          print('mode changed');
          yield ResourceLoaded(mode: eventmode);
        }
      } catch(_){
        yield ResourceError();
      }

    }

  }



  Future<ResourcesList> _fetchResources() async {
    var jsonString = await httpClient.get("http://192.168.0.110:8888/resources");
    final jsonResponse = json.decode(jsonString.body.toString());
    ResourcesList resourceslist = new ResourcesList.fromJson(jsonResponse);
    if(jsonString.statusCode == 200){
      return resourceslist;
    }else{
      throw Exception('error fetching resources');
    }

  }
}

///        States        ///
abstract class ResourceState extends Equatable {

  const ResourceState();

  @override
  List<Object> get props => [];
}

class ResourceUninitialized extends ResourceState {

}

class ResourceError extends ResourceState {}

class ResourceLoaded extends ResourceState{
  final String mode;

  const ResourceLoaded({this.mode});

  @override
  List<Object> get props => [mode];
}

///old
//class ResourceLoaded extends ResourceState{
//  final ResourcesList resourcesList;
//
//  const ResourceLoaded({this.resourcesList});
//
//  @override
//  List<Object> get props => [resourcesList];
//}

///        Events        ///
abstract class ResourceEvent extends Equatable {

  const ResourceEvent();

  @override
  List<Object> get props => [];
}

class Load extends ResourceEvent {
  final String mode;

  const Load({@required this.mode}) : assert(mode !=null);

  @override
  List<Object> get props => [mode];
}

class SwitchMode extends ResourceEvent {
  final String mode;

  const SwitchMode({@required this.mode}) : assert(mode !=null);

  @override
  List<Object> get props => [mode];
}



///old
class Fetch extends ResourceEvent {}



class FilterList extends ResourceEvent {
  final String filtervalue;

  const FilterList({@required this.filtervalue}) : assert(filtervalue != null);

  @override
  List<Object> get props => [filtervalue];

} 