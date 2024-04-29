import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:revier_pode/modles/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/modles/responsive%20.dart';


class AddNewItem extends ConsumerStatefulWidget {
  const AddNewItem({super.key});

  @override
  ConsumerState<AddNewItem> createState() {
    return AddNewItemState();
  }
}

class AddNewItemState extends ConsumerState<AddNewItem> {
  var name;
  var _enteredquantity;
    final _formKey =GlobalKey<FormState>();
  Color selectedcolor = Colors.blue;

  // Define custom colors. The 'guide' color values are from
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: selectedcolor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() => selectedcolor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }

 

  void save() {
      var check= _formKey.currentState!.validate();
    if (check)
    {
       _formKey.currentState!.save();
      Navigator.pop(context,Counter(title: name, color: selectedcolor,count:_enteredquantity ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            'Add New Item',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 4, 50, 88),
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      width: Responsive.isDesktop(context)?600 : Responsive.isTablet(context)?500
                      :Responsive.isMobile(context)?300:300,
                      child: Column(children: [
                        TextFormField(
                          maxLength: 10,
                          onSaved: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14.0),
                            labelText: "Counter Name",
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(),
                            ),
                      
                          ),
                        validator: (value)
                        {
                      if(value==null || 
                      value.isEmpty ||
                       value.trim().length <=1 ||
                       value.trim().length >50 )
                       {
                      return 'the name must be between 1 to 10 char';
                      }
                      return null;
                                  },
                        ),
                        const SizedBox(height: 30),
                         TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5.0),
                            labelText: "Which Number You Want The Counter Start",
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value)
                      {
                        if(value==null || 
                        value.isEmpty ||
                        int.tryParse(value) ==null||
                        int.tryParse(value)! <=0 )
                         {
                        return 'must be valid and postive';
                        }
                          return null;
                      },
                      onSaved: (value){
                       _enteredquantity=int.parse(value!);
                      },
                          ),
                         const SizedBox(height: 40),
                        ListTile(
                          title: const Text(
                            'Select Counter Color',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                          trailing: ColorIndicator(
                            width: 44,
                            height: 44,
                            borderRadius: 22,
                            color: selectedcolor,
                            onSelectFocus: false,
                            onSelect: () async {
                              final Color colorBeforeDialog = selectedcolor;
                              if (!(await colorPickerDialog())) {
                                setState(() {
                                  selectedcolor = colorBeforeDialog;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                            onPressed: ()
                            {
                              save();
                            },
                            child: const Text('SAVE'))
                      ]),
                    ),
                  ),
                ],
              )),
        ));
  }
}
