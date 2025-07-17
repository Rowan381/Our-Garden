import '/flutter_flow/flutter_flow_util.dart';
import 'uploaded_image_widget.dart' show UploadedImageWidget;
import 'package:flutter/material.dart';

class UploadedImageModel extends FlutterFlowModel<UploadedImageWidget> {
  ///  Local state fields for this component.

  String removeImagesPlurality = 'Remove Image';

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataVyc = false;
  FFUploadedFile uploadedLocalFile_uploadDataVyc =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataVyc = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
