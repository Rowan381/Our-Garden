import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'soil_type_model.dart';
export 'soil_type_model.dart';

class SoilTypeWidget extends StatefulWidget {
  const SoilTypeWidget({super.key});

  @override
  State<SoilTypeWidget> createState() => _SoilTypeWidgetState();
}

class _SoilTypeWidgetState extends State<SoilTypeWidget> {
  late SoilTypeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SoilTypeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 7.0,
              color: Color(0x2F1D2429),
              offset: Offset(
                0.0,
                3.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Text(
                    'Soil Types',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                    child: Text(
                      'Clay',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FclaySoil.png?alt=media&token=38343bd3-ffdf-4f78-8961-784ac4203c4d',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Sticky when wet, forms a hard ball when squeezed, and cracks when it dries.\n- Benefits: Rich in nutrients and holds moisture well.\n- Drawbacks: Slow to drain, can become compacted, and difficult to work with when wet.\n- How to Amend: Add coarse sand or gypsum to improve drainage. Add organic matter regularly to help break up the clay and improve its structure.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Sandy',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FsandySoil.png?alt=media&token=89917e26-2e08-4d95-8ed1-1ded4c3614cc',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Gritty and falls apart easily when you rub it between your fingers.\n- Benefits: Drains quickly, warms up faster in spring, and is easy to dig.\n- Drawbacks: Dries out quickly, low in nutrients, and needs frequent watering and fertilizing.\n- How to Amend: Add lots of organic matter like compost, aged manure, or leaf mold to improve water retention and fertility.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Silt',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FsiltySoil.png?alt=media&token=f0703eb0-890f-4757-aee3-385b1e63e404',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Smooth and floury when dry, slippery when wet.\n- Benefits: Fertile and holds moisture well.\n- Drawbacks: Can become compacted easily, prone to erosion, and may not drain well.\n- How to Amend: Similar to clay soil, add coarse sand and plenty of organic matter to improve drainage and structure.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Loam',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FloamSoil.png?alt=media&token=83ef0f54-241f-40f4-871b-345f81967da0',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Crumbly and moist, easily forms a ball but breaks apart when poked.\n- Benefits: The \"Goldilocks\" soil – well-balanced with good drainage, moisture retention, and fertility. Easy to work with.\n- Drawbacks: Very few, the ideal soil for most plants!\n- How to Amend: Maintain its quality by adding compost or other organic matter annually.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Peat',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FpeatSoil.png?alt=media&token=66012876-9d2c-48e9-b7fe-b7f75e0ebd80',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Spongy, lightweight, and holds a lot of water.\n- Benefits: Excellent for moisture-loving plants, rich in organic matter.\n- Drawbacks: Can become waterlogged, acidic, and low in nutrients if not properly managed.\n- How to Amend: If too acidic, add lime to raise the pH. Mix in other materials like compost or garden soil to improve drainage and nutrient content.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Chalk',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FchalkSoil.png?alt=media&token=9636faeb-5eaa-406c-a28f-3e8f714d1b4f',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Gritty and often contains visible white chalk fragments.\n- Benefits: Free-draining and warms up quickly in spring.\n- Drawbacks: Can be alkaline, low in nutrients, and may struggle to retain moisture.\n- How to Amend: Add plenty of organic matter to improve moisture retention and fertility. If too alkaline, add sulfur or other acidifying amendments to lower the pH.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 3.0),
                    child: Text(
                      'Potting',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FpottingSoil.png?alt=media&token=ea53f08d-5f2f-49c9-b4f2-bf8f6e9883d8',
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '- Feels: Lightweight, fluffy, often contains visible pieces of bark, perlite, or vermiculite.\n- Benefits: Sterile (no weeds or diseases), drains well, and formulated for container gardening.\n- Drawbacks: Can dry out quickly, may not contain enough nutrients for long-term growth.\n- How to Amend: Refresh with new potting mix regularly. Supplement with slow-release fertilizer or liquid feed during the growing season.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: 320.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 8.0),
                            child: Text(
                              'Pro-Tip!',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 3.0, 10.0),
                          child: Text(
                            'The best way to know your soil type is to get it tested. A soil test will provide detailed information on its composition, pH, and nutrient levels, allowing you to make informed decisions about amendments and plant selection. You can often obtain soil test kits from your local garden center',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
