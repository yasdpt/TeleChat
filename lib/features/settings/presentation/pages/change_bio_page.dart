import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:telechat/core/utils/custom_toast.dart';

import '../../../../core/styles/text_field_decoration.dart';
import '../../../../core/utils/hive_controller.dart';

class ChangeBioPage extends StatefulWidget {
  static const String routeName = '/changeBioPage';
  const ChangeBioPage({Key key}) : super(key: key);

  @override
  _ChangeBioPageState createState() => _ChangeBioPageState();
}

class _ChangeBioPageState extends State<ChangeBioPage> {
  AppLocalizations _locale;
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    Future.delayed(Duration.zero, () {
      String bio = ModalRoute.of(context).settings.arguments as String;
      _textController.text = bio ?? '';
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
          _locale.bio,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
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
      body: ListView(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FormBuilderTextField(
                      name: 'bio',
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 70,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 16),
                      controller: _textController,
                      decoration: defaultInputDecorationUnderline(
                        context,
                        _locale.bio,
                        backgroudColor: isLight
                            ? Colors.white
                            : Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _locale.bioDetail,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
