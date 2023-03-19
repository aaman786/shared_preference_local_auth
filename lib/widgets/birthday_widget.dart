import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class BirthdayWidget extends StatefulWidget {
  final DateTime? birthday;
  final ValueChanged<DateTime> onChangedBirthday;
  const BirthdayWidget(
      {super.key, required this.birthday, required this.onChangedBirthday});

  @override
  State<BirthdayWidget> createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<BirthdayWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    setDate();
  }

  @override
  void didUpdateWidget(covariant BirthdayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setDate();
  }

  void setDate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.birthday == null) {
          controller.text = '';
        } else {
          controller.text = DateFormat.yMd().format(widget.birthday!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => FocusBuilder(
        onChangeVisibility: (isVisible) {
          if (isVisible) {
            selectDate(context);
            //
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        focusNode: focusNode,
        builder: (hasFocus) => TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? 'Is Required' : null,
          decoration: const InputDecoration(
            prefixText: ' ',
            hintText: 'Your birthday',
            prefixIcon: Icon(Icons.calendar_today_rounded),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF000000))),
          ),
        ),
      );

  Future selectDate(BuildContext context) async {
    final birthday = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (birthday == null) return;

    widget.onChangedBirthday(birthday);
  }
}

class FocusBuilder extends StatefulWidget {
  final FocusNode focusNode;
  final Widget Function(bool hasFocus) builder;
  final ValueChanged<bool> onChangeVisibility;

  const FocusBuilder(
      {required this.focusNode,
      required this.builder,
      required this.onChangeVisibility,
      super.key});

  @override
  _FocusBuilderState createState() => _FocusBuilderState();
}

class _FocusBuilderState extends State<FocusBuilder> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onChangeVisibility(true),
        child: Focus(
          focusNode: widget.focusNode,
          onFocusChange: widget.onChangeVisibility,
          child: widget.builder(widget.focusNode.hasFocus),
        ),
      );
}
