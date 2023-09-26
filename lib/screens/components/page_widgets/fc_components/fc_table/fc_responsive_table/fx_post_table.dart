import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_label/fx_content_label.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_table/fx_responsive_table.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/components/fx_search_text_field.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../../../../../../app/models/post_model.dart';
import '../../../../../../../app/server/blocs/post_bloc.dart';

class FxPostTable extends StatefulWidget {
  const FxPostTable({Key? key}) : super(key: key);

  @override
  State<FxPostTable> createState() => _FxPostTableState();
}

class _FxPostTableState extends State<FxPostTable> {
  late List<DatatableHeader> _headers;

  late int _total;
  late int? _currentPerPage;
  List<bool>? _expanded;

  int _currentPage = 1;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];

  final TextEditingController _ctrlSearch = TextEditingController();

  final bool _sortAscending = true;
  bool _isLoading = true;

  /// set headers

  @override
  void initState() {
    super.initState();

    getData(_currentPage);

    _headers = [
      DatatableHeader(
          text: "id",
          value: "id",
          sourceBuilder: (value, row) {
            return FxText(
              value.toString(),
              align: TextAlign.center,
            );
          },
          show: true,
          sortable: true,
          flex: 1,
          textAlign: TextAlign.start),
      DatatableHeader(
          text: "title",
          value: "title",
          sourceBuilder: (value, row) {
            return FxText(value.toString());
          },
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.start),
      DatatableHeader(
          text: "description",
          value: "description",
          sourceBuilder: (value, row) {
            return FxText(value.toString());
          },
          show: true,
          flex: 7,
          sortable: true,
          editable: true,
          textAlign: TextAlign.start),
      DatatableHeader(
          text: "status",
          value: "status",
          sourceBuilder: (value, row) {
            return _convertStatuse(value.toString());
          },
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.start),
      DatatableHeader(
          text: "created_at",
          value: "created_at",
          sourceBuilder: (value, row) {
            return FxText(
              value.toString(),
              align: TextAlign.start,
            );
          },
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.start),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: InitialStyle.cardColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.all(InitialDims.space2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxSearchTextField(
                    controller: _ctrlSearch,
                    onChanged: (String value) {
                      setState(() {
                        _currentPage = 1;
                      });

                      getData(_currentPage);
                    },
                  ),
                  const FxVSpacer(
                    factor: 3,
                  ),
                  StreamBuilder<PostPaginateModel?>(
                    stream: postBlocShow.actions,
                    builder:
                        (context, AsyncSnapshot<PostPaginateModel?> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.source.length <
                            int.parse(snapshot.data!.perPage??"0")) {
                          _currentPerPage = snapshot.data!.source.length;
                        } else {
                          _currentPerPage = int.parse(snapshot.data!.perPage??"0");
                        }

                        _expanded = List.generate(
                            _currentPerPage ?? 0, (index) => false);

                        _sourceOriginal =
                            snapshot.data?.source as List<Map<String, dynamic>>;
                        _sourceFiltered = _sourceOriginal;
                        _total = int.parse(snapshot.data!.total??"0");
                        _source = _sourceFiltered
                            .getRange(0, _currentPerPage ?? 0)
                            .toList();

                        return Container(
                          constraints: BoxConstraints(
                              minHeight: InitialDims.space25 * 5),
                          child: FxResponsiveTable(
                            headers: _headers,
                            source: _source,
                            lastPage: int.parse(snapshot.data?.lastPage??"0"),
                            currentPage: _currentPage,
                            currentPerPage: _currentPerPage,
                            total: _total,
                            expanded: _expanded,
                            sortAscending: _sortAscending,
                            isLoading: _isLoading,
                            onPreviousPressed: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                            onNextPressed: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                            onPageSelected: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                              getData(_currentPage);
                            },
                          ),
                        );
                      }

                      return SizedBox(
                        height: InitialDims.space25 * 5,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: InitialStyle.icon,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  void getData(int page) async {
    setState(() {
      _isLoading = true;
      _sourceOriginal.clear();
    });
    postBlocShow.fetchShow(
        apiAddress: 'dummy/table-data',
        body: {"search": _ctrlSearch.text, "page": page.toString()},
        directResult: (res) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  Widget _convertStatuse(String value) {
    PostStatus status = PostStatus.draft;
    if (value == "1") {
      status = PostStatus.draft;
    }
    if (value == "2") {
      status = PostStatus.scheduled;
    }
    if (value == "3") {
      status = PostStatus.scheduled;
    }

    String statusString = "Draft";
    if (status == PostStatus.draft) {
      statusString = "Draft";
    }
    if (status == PostStatus.scheduled) {
      statusString = "Scheduled";
    }
    if (status == PostStatus.published) {
      statusString = "Published";
    }

    Color statusColor = InitialStyle.warningColorLight;
    if (status == PostStatus.draft) {
      statusColor = InitialStyle.warningColorLight;
    }
    if (status == PostStatus.scheduled) {
      statusColor = InitialStyle.informationColorLight;
    }
    if (status == PostStatus.published) {
      statusColor = InitialStyle.successColorLight;
    }

    Color statusTextColor = InitialStyle.warningColorDark;
    if (status == PostStatus.draft) {
      statusTextColor = InitialStyle.warningColorDark;
    }
    if (status == PostStatus.scheduled) {
      statusTextColor = InitialStyle.informationColorDark;
    }
    if (status == PostStatus.published) {
      statusTextColor = InitialStyle.successColorDark;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: InitialDims.space3),
      child: FxContentLabel(
        text: statusString,
        size: InitialDims.icon3,
        textColor: statusTextColor,
        color: statusColor,
      ),
    );
  }
}

enum PostStatus { draft, published, scheduled }
