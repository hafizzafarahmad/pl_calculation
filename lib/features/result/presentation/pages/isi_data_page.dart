

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/core/styles/inputStyle.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/pages/index_result.dart';

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

  var _methaneInput = TextEditingController();
  var _ethaneInput = TextEditingController();
  var _propaneInput = TextEditingController();
  var _iButaneInput = TextEditingController();
  var _nButaneInput = TextEditingController();
  var _iPetaneInput = TextEditingController();
  var _nPetaneInput = TextEditingController();
  var _hexaneInput = TextEditingController();
  var _nitrogenInput = TextEditingController();
  var _carboneMonoxideInput = TextEditingController();
  var _carbonDioxideInput = TextEditingController();
  var _waterInput = TextEditingController();
  var _hydrogenSulfideInput = TextEditingController();
  var _hydrogenInput = TextEditingController();
  var _heliumInput = TextEditingController();
  var _oxygenInput = TextEditingController();
  var _argonInput = TextEditingController();

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

      _methaneInput.value = TextEditingValue(text: calculateEntity.methane!);
      _ethaneInput.value = TextEditingValue(text: calculateEntity.ethane!);
      _propaneInput.value = TextEditingValue(text: calculateEntity.propane!);
       _iButaneInput.value = TextEditingValue(text: calculateEntity.iButane!);
       _nButaneInput.value = TextEditingValue(text: calculateEntity.nButane!);
       _iPetaneInput.value = TextEditingValue(text: calculateEntity.iPetane!);
       _nPetaneInput.value = TextEditingValue(text: calculateEntity.nPetane!);
       _hexaneInput.value = TextEditingValue(text: calculateEntity.hexane!);
       _nitrogenInput.value = TextEditingValue(text: calculateEntity.nitrogen!);
       _carboneMonoxideInput.value = TextEditingValue(text: calculateEntity.carboneMonoxide!);
       _carbonDioxideInput.value = TextEditingValue(text: calculateEntity.carbonDioxide!);
       _waterInput.value = TextEditingValue(text: calculateEntity.water!);
       _hydrogenSulfideInput.value = TextEditingValue(text: calculateEntity.hydrogenSulfide!);
       _hydrogenInput.value = TextEditingValue(text: calculateEntity.hydrogen!);
       _heliumInput.value = TextEditingValue(text: calculateEntity.helium!);
       _oxygenInput.value = TextEditingValue(text: calculateEntity.oxygen!);
       _argonInput.value = TextEditingValue(text: calculateEntity.argon!);
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
        variableHeatLoss: _varHeatLossInput.text,

        methane: _methaneInput.text,
        ethane: _ethaneInput.text,
        propane: _propaneInput.text,
        iButane: _iButaneInput.text,
        nButane: _nButaneInput.text,
        iPetane: _iPetaneInput.text,
        nPetane: _nPetaneInput.text,
        hexane: _hexaneInput.text,
        nitrogen: _nitrogenInput.text,
        carboneMonoxide: _carboneMonoxideInput.text,
        carbonDioxide: _carbonDioxideInput.text,
        water: _waterInput.text,
        hydrogenSulfide: _hydrogenSulfideInput.text,
        hydrogen: _hydrogenInput.text,
        helium: _heliumInput.text,
        oxygen: _oxygenInput.text,
        argon: _argonInput.text,
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "F", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        ///Ref Temperature for Enthalpy
                        Text(
                          'Ref Temperature for Enthalpy',
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
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
                          // inputFormatters: [
                          //   ThousandsFormatter(allowFraction: true)
                          // ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: inputStyle(context, suffixText: "MMBtu/h", hint: "0.00"),
                        ),
                        SizedBox(height: 30,),

                        _gasComposition(),

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
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                CalculateEntity calculate = CalculateEntity(
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
                                  variableHeatLoss: _varHeatLossInput.text,

                                  methane: _methaneInput.text,
                                  ethane: _ethaneInput.text,
                                  propane: _propaneInput.text,
                                  iButane: _iButaneInput.text,
                                  nButane: _nButaneInput.text,
                                  iPetane: _iPetaneInput.text,
                                  nPetane: _nPetaneInput.text,
                                  hexane: _hexaneInput.text,
                                  nitrogen: _nitrogenInput.text,
                                  carboneMonoxide: _carboneMonoxideInput.text,
                                  carbonDioxide: _carbonDioxideInput.text,
                                  water: _waterInput.text,
                                  hydrogenSulfide: _hydrogenSulfideInput.text,
                                  hydrogen: _hydrogenInput.text,
                                  helium: _heliumInput.text,
                                  oxygen: _oxygenInput.text,
                                  argon: _argonInput.text,
                                );


                                context.read<ResultBloc>().add(GetResultEvent(
                                  context: context,
                                  calculateEntity: calculate
                                ));

                                Navigator.push(context, MaterialPageRoute(builder: (context) => IndexResult(
                                    calculateEntity: calculate
                                )));
                              } else {
                                alertToast("Field cannot be empty");
                              }
                            },
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

  Widget _gasComposition(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //---------------------------------------------------------------
        Container(
          alignment: Alignment.center,
          child: Text(
            'Gas Composition',
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

        ///Methane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Methane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _methaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Methane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Ethane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Ethane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _ethaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Ethane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Propane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Propane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _propaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Propane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///I-Butane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'I-Butane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _iButaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "I-Butane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///N-Butane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'N-Butane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _nButaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "N-Butane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///I-Petane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'I-Petane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _iPetaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "I-Petane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///N-Petane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'IN-Petane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _nPetaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "N-Petane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Hexane
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Hexane',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _hexaneInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Hexane cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Nitrogen
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Nitrogen',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _nitrogenInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Nitrogen cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Carbone Monoxide
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Carbone Monoxide',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _carboneMonoxideInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Carbone Monoxide cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Carbon Dioxide
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Carbon Dioxide',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _carbonDioxideInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Carbon Dioxide cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Water
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Water',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _waterInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Water cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Hydrogen sulfide
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Hydrogen sulfide',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _hydrogenSulfideInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Hydrogen sulfide cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Hydrogen
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Hydrogen',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _hydrogenInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Hydrogen cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Helium
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Helium',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _heliumInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Helium cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Oxygen
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Oxygen',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _oxygenInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Oxygen cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        ///Argon
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Argon',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: _argonInput,
                validator: (val){
                  if(val!.isEmpty){
                    return "Argon cannot be blank";
                  }
                },
                onChanged: (val){
                  _saveData();
                },
                // inputFormatters: [
                //   ThousandsFormatter(allowFraction: true)
                // ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: inputStyle(context, suffixText: "%", hint: "0.00"),
              ),
            )
          ],
        ),
        SizedBox(height: 15,),

        // ///Total
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Total :',
        //       style: TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.bold
        //       ),
        //     ),
        //     Text(
        //       '100%',
        //       style: TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.bold
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: 25,),
      ],
    );
  }
}