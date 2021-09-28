import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/utils/custom_toast.dart';

import '../../../../core/styles/text_field_decoration.dart';
import '../../../../core/utils/hive_controller.dart';

class ChangeUsernamePage extends StatefulWidget {
  static const String routeName = '/changeProfilePage';
  const ChangeUsernamePage({Key key}) : super(key: key);

  @override
  _ChangeUsernamePageState createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  AppLocalizations _locale;
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    Future.delayed(Duration.zero, () {
      String username = ModalRoute.of(context).settings.arguments as String;
      _textController.text = username ?? '';
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = HiveController();

    bool isLight = controller.getAppTheme == ThemeMode.light;
    _locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _locale.username,
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
              shrinkWrap: true,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: FormBuilderTextField(
                            name: 'username',
                            autofocus: true,
                            keyboardType: TextInputType.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontSize: 16),
                            controller: _textController,
                            validator: (value) {
                              String pattern = r'(^[a-zA-Z0-9_]*$)';
                              RegExp regExp = new RegExp(pattern);
                              if (!regExp.hasMatch(value)) {
                                return _locale.pleaseEnterAValidUsername;
                              } else if (value.isEmpty) {
                                return null;
                              } else if (value.length < 5) {
                                return _locale.pleaseEnterAtLeast5Characters;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                              _formKey.currentState.validate();
                            },
                            decoration: defaultInputDecorationUnderline(
                              context,
                              _locale.yourUsername,
                              backgroudColor: isLight
                                  ? Colors.white
                                  : Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _locale.changeUsernameDetail,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 16),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FlutterClipboard.copy(
                                      'https://telechat.com/${_textController.text}')
                                  .then((value) => kShowToast(
                                      'https://telechat.com/${_textController.text} ${_locale.copied}'));
                            },
                            child: Text(
                              'https://telechat.com/${_textController.text}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                      fontSize: 16, color: Colors.blue[300]),
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
        ],
      ),
    );
  }
}
