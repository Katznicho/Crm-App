import 'package:flutter/material.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:fx_flutterap_components/components/fx_api/fx_stream_paginate.dart';

import '../../../../../app/models/media_model.dart';
import '../../../../../app/server/blocs/media_bloc.dart';
import 'fx_image_card.dart';

class FxBlockApiSample extends StatefulWidget {
  const FxBlockApiSample({Key? key}) : super(key: key);

  @override
  State<FxBlockApiSample> createState() => _FxBlockApiSampleState();
}

class _FxBlockApiSampleState extends State<FxBlockApiSample> {

  bool _finishFlag = false;

  String _total = "0";

  List<MediaModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FxStreamPaginate<MediaPaginateModel>(
      stream: mediaBlocShow.actions,
      finishFlag: _finishFlag,
      getData: (currentPage) {return _getData(currentPage);},
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: (InitialDims.space5),
        runSpacing: InitialDims.space2,
        children:
            List.generate(_finishFlag ? list.length : list.length + 1, (index) {

          return index < list.length
              ? FxImageCard(
                  imagePath: list[index].url!,
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: InitialStyle.primaryColor,
                  ),
                );
        }),
      ),
    );
  }



  _getData(int currentPage) async {
    if (currentPage == 1) {
      list.clear();
    }
    MediaPaginateModel pageData = await mediaBlocShow.fetchShow(
      apiAddress: "dummy/images?page=$currentPage",
    );

    list.addAll(pageData.data!.list);

    if (pageData.total != null) {
      setState(() {
        _total = pageData.total!;
      });
    }



    if (_total == list.length.toString()) {
      _finishFlag = true;

    }
  }
}
