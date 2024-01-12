import '/backend/backend.dart';
import '/component/empty/empty_widget.dart';
import '/component/new_task/new_task_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'homepage_model.dart';
export 'homepage_model.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({Key? key}) : super(key: key);

  @override
  _HomepageWidgetState createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget>
    with TickerProviderStateMixin {
  late HomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasCheckboxListTileTriggered = false;
  final animationsMap = {
    'checkboxListTileOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1800.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'floatingActionButtonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 1010.ms,
          duration: 1690.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF2CE07),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Color(0xFBAA9906),
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: Container(
                      height: 350,
                      child: NewTaskWidget(),
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          backgroundColor: Color(0xA7FFEE2A),
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Color(0xDA4D2919),
            size: 34,
          ),
        ).animateOnActionTrigger(
          animationsMap['floatingActionButtonOnActionTriggerAnimation']!,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            backgroundColor: Color(0x91F8E508),
            automaticallyImplyLeading: false,
            title: GradientText(
              'To Do',
              style: FlutterFlowTheme.of(context).headlineLarge.override(
                    fontFamily: 'Outfit',
                    color: Color(0xDA4D2919),
                  ),
              colors: [Color(0x7A4D2919), Color(0xDA4D2919)],
              gradientDirection: GradientDirection.ltr,
              gradientType: GradientType.linear,
            ),
            actions: [],
            centerTitle: false,
            elevation: 6,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<List<ToDoRecord>>(
                stream: queryToDoRecord(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<ToDoRecord> listViewToDoRecordList = snapshot.data!;
                  if (listViewToDoRecordList.isEmpty) {
                    return Center(
                      child: Container(
                        height: 600,
                        child: EmptyWidget(),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewToDoRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewToDoRecord =
                          listViewToDoRecordList[listViewIndex];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.standard,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            unselectedWidgetColor: Color(0xDA4D2919),
                          ),
                          child: CheckboxListTile(
                            value: _model.checkboxListTileValueMap[
                                listViewToDoRecord] ??= false,
                            onChanged: (newValue) async {
                              setState(() => _model.checkboxListTileValueMap[
                                  listViewToDoRecord] = newValue!);
                              if (newValue!) {
                                await listViewToDoRecord.reference.delete();
                                if (animationsMap[
                                        'checkboxListTileOnActionTriggerAnimation'] !=
                                    null) {
                                  setState(() =>
                                      hasCheckboxListTileTriggered = true);
                                  SchedulerBinding.instance.addPostFrameCallback(
                                      (_) async => await animationsMap[
                                              'checkboxListTileOnActionTriggerAnimation']!
                                          .controller
                                          .forward(from: 0.0));
                                }
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Task Completed !',
                                      style: TextStyle(
                                        color: Color(0xD7E0E3E7),
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 5100),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                  ),
                                );
                              }
                            },
                            title: Text(
                              listViewToDoRecord.task,
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xDA4D2919),
                                  ),
                            ),
                            subtitle: Text(
                              listViewToDoRecord.date,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xDA4D2919),
                                  ),
                            ),
                            tileColor: Color(0xFBB7A622),
                            activeColor: Color(0xDA4D2919),
                            checkColor: Color(0xDA4D2919),
                            dense: false,
                            controlAffinity: ListTileControlAffinity.leading,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ).animateOnActionTrigger(
                            animationsMap[
                                'checkboxListTileOnActionTriggerAnimation']!,
                            hasBeenTriggered: hasCheckboxListTileTriggered),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
