

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/core/styles/inputStyle.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';

typedef OnFinished<ParamsPasutri> = void Function(ParamsPasutri item);
typedef OnBack<ParamsPasutri> = void Function(ParamsPasutri item);

class IsiDataPage extends StatefulWidget  {

  const IsiDataPage({Key? key }) : super(key: key);

  @override
  _IsiDataPage createState() => _IsiDataPage();
}

class _IsiDataPage extends State<IsiDataPage> {

  final _formKey = GlobalKey<FormState>();

  var _baroPressureInput = TextEditingController();
  var _dryTempInput = TextEditingController();
  var _wetTempInput = TextEditingController();
  var _relativeHumidityInput = TextEditingController();

  var _gtFuelInput = TextEditingController();
  var _fuelTempInput = TextEditingController();
  var _injectSteamInput = TextEditingController();
  var _tempInput = TextEditingController();
  var _pressureInput = TextEditingController();
  var _phasaOWaterInput = TextEditingController();
  var _comprresExtAirInput = TextEditingController();
  var _extAirTempInput = TextEditingController();
  var _refTempInput = TextEditingController();
  var _exhOutTempInput = TextEditingController();

  var _gtPowerOutInput = TextEditingController();
  var _genLossInput = TextEditingController();
  var _gearLossInput = TextEditingController();
  var _fixedHeadLossInput = TextEditingController();
  var _varHeatLossInput = TextEditingController();

  _getData() async {
    final calBox = await Hive.openBox(BOX_CALCULATION);
    if(calBox.isNotEmpty){
      CalculateEntity calculateEntity = calBox.getAt(0);

      _baroPressureInput.value = TextEditingValue(text: calculateEntity.barometricPressure!);
      _dryTempInput.value = TextEditingValue(text: calculateEntity.inletDryBulbTemperature!);
      _wetTempInput.value = TextEditingValue(text: calculateEntity.inletWetBulbTemperature!);
      _relativeHumidityInput.value = TextEditingValue(text: calculateEntity.inletRelativeHumidity!);

      _gtFuelInput.value = TextEditingValue(text: calculateEntity.gTFuelFlow!);
      _fuelTempInput.value = TextEditingValue(text: calculateEntity.fuelTemperature!);
      _injectSteamInput.value = TextEditingValue(text: calculateEntity.injectionSteamFlow!);
      _tempInput.value = TextEditingValue(text: calculateEntity.temperature!);
      _pressureInput.value = TextEditingValue(text: calculateEntity.pressure!);
      _phasaOWaterInput.value = TextEditingValue(text: calculateEntity.phasaWaterSteam!);
      _comprresExtAirInput.value = TextEditingValue(text: calculateEntity.comprresorExtractionAir!);
      _extAirTempInput.value = TextEditingValue(text: calculateEntity.extractionAirTemperature!);
      _refTempInput.value = TextEditingValue(text: calculateEntity.refTemperatureEnthalpy!);
      _exhOutTempInput.value = TextEditingValue(text: calculateEntity.exhaustOutletTemperature!);

      _gtPowerOutInput.value = TextEditingValue(text: calculateEntity.gTPowerOutput!);
      _genLossInput.value = TextEditingValue(text: calculateEntity.generatorLoss!);
      _gearLossInput.value = TextEditingValue(text: calculateEntity.gearboxLoss!);
      _fixedHeadLossInput.value = TextEditingValue(text: calculateEntity.fixedHeadLoss!);
      _varHeatLossInput.value = TextEditingValue(text: calculateEntity.variableHeatLoss!);
    } else {
      calBox.add(CalculateEntity());
    }
  }
  _saveData(){
    final calBox = Hive.box(BOX_CALCULATION);
    calBox.putAt(0,
      CalculateEntity(
          barometricPressure: _baroPressureInput.text,
          inletDryBulbTemperature: _dryTempInput.text,
          inletWetBulbTemperature: _wetTempInput.text,
          inletRelativeHumidity: _relativeHumidityInput.text,
          gTFuelFlow: _gtFuelInput.text,
          fuelTemperature: _fuelTempInput.text,
          injectionSteamFlow: _injectSteamInput.text,
          temperature: _tempInput.text,
          pressure: _pressureInput.text,
          phasaWaterSteam: _phasaOWaterInput.text,
          comprresorExtractionAir: _comprresExtAirInput.text,
          extractionAirTemperature: _extAirTempInput.text,
          refTemperatureEnthalpy: _refTempInput.text,
          exhaustOutletTemperature: _exhOutTempInput.text,
          gTPowerOutput: _gtPowerOutInput.text,
          generatorLoss: _genLossInput.text,
          gearboxLoss: _gearLossInput.text,
          fixedHeadLoss: _fixedHeadLossInput.text,
          variableHeatLoss: _varHeatLossInput.text
      )
    );
  }


  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Calculation', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);

            },
            icon: Icon(LineAwesomeIcons.angle_left, color: Colors.black,),
          ),
        ),
        body: _mainBody()


    );
  }


  Widget _mainBody(){
    return ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //---------------------------------------------------------------
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Ambient Condition',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'PoppinsMedium'
                            ),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        SizedBox(height: 10,),

                        ///Barometric Pressure
                        Text(
                          'Barometric Pressure',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _baroPressureInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Barometric Pressure cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "Psia", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Inlet Dry Bulb Temperature
                        Text(
                          'Inlet Dry Bulb Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _dryTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Inlet Dry Bulb Temperature cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Inlet Wet Bulb Temperature
                        Text(
                          'Inlet Wet Bulb Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _wetTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Inlet Wet Bulb Temperature cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Inlet Relative Humidity
                        Text(
                          'Inlet Relative Humidity',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _relativeHumidityInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Inlet Relative Humidity cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        //---------------------------------------------------------------
                        ///Gas Turbine
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Gas Turbine',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'PoppinsMedium'
                            ),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        SizedBox(height: 10,),

                        ///GT Fuel Flow
                        Text(
                          'GT Fuel Flow',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _gtFuelInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "GT Fuel Flow cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "lb/hr", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Fuel Temperature
                        Text(
                          'Fuel Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _fuelTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Fuel Temperature cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        ///Injection Steam Flow
                        Text(
                          'Injection Steam Flow',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _injectSteamInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Injection Steam Flow cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "lb/hr", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Temperature
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _tempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Temperature cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Pressure
                        Text(
                          'Pressure',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _pressureInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Pressure cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "Psig", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Phasa 0-water / 1-Steam
                        Text(
                          'Phasa 0-water / 1-Steam',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _phasaOWaterInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Phasa 0-water / 1-Steam cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        ///Comprresor Extraction Air
                        Text(
                          'Comprresor Extraction Air',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _comprresExtAirInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Comprresor Extraction Air cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "lb/hr", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Extraction Air Temperature
                        Text(
                          'Extraction Air Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _extAirTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Extraction Air Temperature cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        ///Ref Temperature for Enthalpy
                        Text(
                          'Inlet Relative Humidity',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _refTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Ref Temperature for Enthalpy cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),


                        ///Exhaust Outlet Temperature
                        Text(
                          'Exhaust Outlet Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _exhOutTempInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Inlet Relative Humidity cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        //---------------------------------------------------------------
                        ///Generator
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Generator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'PoppinsMedium'
                            ),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        SizedBox(height: 10,),

                        ///GT Power Output
                        Text(
                          'GT Power Output',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _gtPowerOutInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "GT Power Output cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MW", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Generator Loss
                        Text(
                          'Generator Loss',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _genLossInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Generator Loss cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MW", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Gearbox Loss
                        Text(
                          'Gearbox Loss Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _gearLossInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Gearbox Loss cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MW", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Fixed Head Loss
                        Text(
                          'Fixed Head Loss',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _fixedHeadLossInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Fixed Head Loss cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MMBtu/h", hint: "0.00"),
                        ),
                        SizedBox(height: 10,),

                        ///Variable Heat Loss
                        Text(
                          'Variable Heat Loss',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _varHeatLossInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Variable Heat Loss cannot be blank";
                            }
                          },
                          onChanged: (val){
                            _saveData();
                          },
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MMBtu/h", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        Center(
                          child: ElevatedButton(
                            child: Text('Calculate', style: TextStyle(fontSize: 16),),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                              primary: Pigment.fromString(PRIMARY_COLOR),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}