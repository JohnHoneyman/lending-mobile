import 'package:lendingmobile/core/model/form_model.dart';

String getFormVersionID(String formID, List<FormStruct> forms) {
  final form = forms.firstWhere(
    (form) => form.formID == formID,
  );

  return form.formVersionID!;
}

String getFormVersion(String formID, List<FormStruct> forms) {
  final form = forms.firstWhere(
    (form) => form.formID == formID,
  );

  return form.version!;
}
