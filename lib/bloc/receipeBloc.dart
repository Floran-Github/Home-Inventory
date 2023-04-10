import 'dart:async';
import 'dart:ffi';

import 'package:home_inventory/model/receipe/receipeListModel.dart';
import 'package:home_inventory/repository/receipeRepository.dart';
import 'package:home_inventory/response/receipeResponse.dart';

class ReceipeBloc {
  late ReceipeRepository _receipeRepository;

  // controller
  late StreamController<ReceipeResponse<List<ReceipeModel>>> _controller;

  // sink
  StreamSink<ReceipeResponse<List<ReceipeModel>>> get receipeSink =>
      _controller.sink;

  // stream
  Stream<ReceipeResponse<List<ReceipeModel>>> get receipeStream =>
      _controller.stream;

  // constructor
  ReceipeBloc() {
    _controller = StreamController<ReceipeResponse<List<ReceipeModel>>>();

    _receipeRepository = ReceipeRepository();
  }

  // get receipe list

  getReceipe() async {
    receipeSink.add(ReceipeResponse.loading("Fetching data"));
    try {
      List<ReceipeModel> receipeList = await _receipeRepository.getReceipes();
      receipeSink.add(ReceipeResponse.completed(receipeList));
    } catch (e) {
      receipeSink.add(ReceipeResponse.error(e.toString()));
    }
  }
}
