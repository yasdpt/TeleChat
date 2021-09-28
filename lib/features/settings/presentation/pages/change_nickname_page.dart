import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/styles/text_field_decoration.dart';
import 'package:telechat/core/utils/hive_controller.dart';

class ChangeNicknamePage extends StatefulWidget {
  static const String routeName = '/changeNickname';
  const ChangeNicknamePage({Key key}) : super(key: key);

  @override
  _ChangeNicknamePageState createState() => _ChangeNicknamePageState();
}

class _ChangeNicknamePageState extends State<ChangeNicknamePage> {
  AppLocalizations _locale;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    _locale = AppLocalizations.of(context);
    final controller = HiveController();

    bool isLight = controller.getAppTheme == ThemeMode.light;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _locale.editName,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              MdiIcons.check,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 18,
                    end: 18,
                    top: 18,
                    bottom: 18,
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'firstName',
                          initialValue: 'Mr YaS',
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          maxLength: 30,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 16),
                          decoration: defaultInputDecorationUnderline(
                            context,
                            _locale.firstName,
                            backgroudColor: isLight
                                ? Colors.white
                                : Theme.of(context).appBarTheme.backgroundColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'lastName',
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          maxLength: 30,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 16),
                          decoration: defaultInputDecorationUnderline(
                            context,
                            _locale.lastName,
                            backgroudColor: isLight
                                ? Colors.white
                                : Theme.of(context).appBarTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
