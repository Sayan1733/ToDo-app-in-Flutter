import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'empty_model.dart';
export 'empty_model.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  late EmptyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 301,
      decoration: BoxDecoration(
        color: Color(0xFFF2CE07),
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Text(
          'No Task today!',
          style: FlutterFlowTheme.of(context).labelLarge.override(
                fontFamily: 'Readex Pro',
                color: Color(0x4D4D2919),
                fontSize: 36,
              ),
        ),
      ),
    );
  }
}
