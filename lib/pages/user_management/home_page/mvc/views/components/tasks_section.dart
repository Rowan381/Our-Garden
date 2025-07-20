import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/backend/backend.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/home_page_ui_models.dart';

/// Tasks section component showing today's tasks
class TasksSection extends StatefulWidget {
  final List<TaskItemModel> tasks;
  final Function(String taskId, bool value) onTaskToggle;
  final VoidCallback onViewMoreTap;

  const TasksSection({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onViewMoreTap,
  });

  @override
  State<TasksSection> createState() => _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection> {
  Map<String, bool> _taskStates = {};

  @override
  void initState() {
    super.initState();
    // Initialize task states
    for (final task in widget.tasks) {
      _taskStates[task.id] = task.isCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final containerWidth =
              screenWidth * 0.95 > 400.0 ? 400.0 : screenWidth * 0.95;

          return Container(
            width: containerWidth,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTasksHeader(context, containerWidth),
                  _buildTasksList(context, containerWidth),
                  _buildViewMoreButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTasksHeader(BuildContext context, double containerWidth) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: containerWidth,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondary,
            width: 2.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, -1.0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Text(
            'Today\'s Tasks',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList(BuildContext context, double containerWidth) {
    return Container(
      width: containerWidth,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent3,
      ),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.tasks.map((task) => _buildTaskItem(task)).toList(),
        ),
      ),
    );
  }

  Widget _buildTaskItem(TaskItemModel task) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFD1F3FF),
        border: Border.all(
          color: Color(0x3100ADEA),
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
            ),
            child: Checkbox(
              value: _taskStates[task.id] ?? task.isCompleted,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _taskStates[task.id] = newValue;
                  });
                  widget.onTaskToggle(task.id, newValue);
                }
              },
              side: BorderSide(
                width: 2,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              activeColor: task.type == 'garden'
                  ? FlutterFlowTheme.of(context).accent1
                  : FlutterFlowTheme.of(context).primary,
              checkColor: FlutterFlowTheme.of(context).info,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
              child: Text(
                task.title.length > 30
                    ? '${task.title.substring(0, 30)}...'
                    : task.title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewMoreButton(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onViewMoreTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 49.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondary,
            width: 2.0,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            'View More',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }
}
