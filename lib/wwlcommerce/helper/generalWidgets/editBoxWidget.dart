import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

Widget editBoxWidget(
    BuildContext context,
    TextEditingController edtController,
    Function validationFunction,
    String label,
    String errorLabel,
    TextInputType inputType,
    {Widget? tailIcon,
    Widget? leadingIcon,
    bool? isLastField,
    bool? isEditable = true,
    List<TextInputFormatter>? inputFormatters}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        enabled: isEditable,
        style: TextStyle(
          color: ColorsRes.mainTextColor,
        ),
        controller: edtController,
        textInputAction:
            isLastField == true ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          prefix: leadingIcon,
          suffixIcon: tailIcon,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: ColorsRes.appColor,
              width: 1,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          labelText: label,
          isDense: true,
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : ColorsRes.appColor;
              return TextStyle(color: color, letterSpacing: 1.3);
            },
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: inputType,
        inputFormatters: inputFormatters ?? [],
        validator: (String? value) {
          return validationFunction(value ?? "") == null ? null : errorLabel;
        },
      )
    ],
  );
}
