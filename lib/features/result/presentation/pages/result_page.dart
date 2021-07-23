

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/error/error_page.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/format_date.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/features/calculate/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_state.dart';

typedef OnFinished<ParamsPasutri> = void Function(ParamsPasutri item);
typedef OnBack<ParamsPasutri> = void Function(ParamsPasutri item);

class ResultPage extends StatefulWidget  {
  final CalculateEntity? calculateEntity;

  const ResultPage({Key? key, this.calculateEntity }) : super(key: key);

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {

  _inputtedDataText(String title, String body){
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text("$title", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ),
        Expanded(
          flex: 3,
          child: Text("$body",
              style: TextStyle(fontSize: 14, fontFamily: 'PoppinsSemiBold')),
        )
      ],
    );
  }




  @override
  void initState() {
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
          title: Text('Result', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);

            },
            icon: Icon(LineAwesomeIcons.angle_left, color: Colors.black,),
          ),
        ),
        body: Container(
          height: autoSizedHeight(context, 1),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child:  BlocBuilder<ResultBloc, ResultState>(
            builder: (context, state){
              print(state);
              ///LoadingKontakState
              if(state is LoadingResultState){
                return Center(child: CircularProgressIndicator(),);
              } else if (state is ResultRetrievedState){
                return _mainBody(state.resultEntity!);
              } else if (state is ErrorResultState){
                return Container(
                    width: autoSizedWidth(context, 1),
                    height: autoSizedHeight(context, 0.75),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ErrorPage(messages: state.messages, onTap: () {
                      // _onRefresh();
                    },)
                );
              } else {
                return Container();
              }
            },
          ),
        )


    );
  }


  Widget _mainBody(ResultEntity resultEntity){
    return ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date', style: TextStyle(color: Colors.grey, fontSize: 15, ),),
                    Text('${setPlainDate(DateTime.now().toString())}', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 15),),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(thickness: 1,),
                ///INPUTED DATA
                ExpandablePanel(
                theme: ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                  ),
                  header: Text("Inputted Data", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 15)),
                  collapsed: SizedBox(),
                  expanded: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Text("Ambient Condition", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                        SizedBox(height: 5,),
                        _inputtedDataText("Barometric Pressure", "${widget.calculateEntity!.barometricPressure}   Psia"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Inlet Dry Bulb Temperature", "${widget.calculateEntity!.inletDryBulbTemperature}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Inlet Wet Bulb Temperature", "${widget.calculateEntity!.inletWetBulbTemperature}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Inlet Relative Humidity", "${widget.calculateEntity!.inletRelativeHumidity}   %"),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        Text("Gas Turbine", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        _inputtedDataText("GT Fuel Flow", "${widget.calculateEntity!.gTFuelFlow}   lb/hr"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Fuel Temperature", "${widget.calculateEntity!.fuelTemperature}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Injection Steam Flow", "${widget.calculateEntity!.injectionSteamFlow}   lb/hr"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Temperature", "${widget.calculateEntity!.temperature}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Pressure", "${widget.calculateEntity!.pressure}   Psig"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Phasa 0-water / 1-Steam", "${widget.calculateEntity!.phasaWaterSteam}"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Comprresor Extraction Air", "${widget.calculateEntity!.comprresorExtractionAir}   lb/hr"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Extraction Air Temperature", "${widget.calculateEntity!.extractionAirTemperature}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Ref Temperature for Enthalpy", "${widget.calculateEntity!.refTemperatureEnthalpy}   F"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Exhaust Outlet Temperature", "${widget.calculateEntity!.exhaustOutletTemperature}   F"),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        Text("Generator", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        _inputtedDataText("GT Power Output", "${widget.calculateEntity!.gTPowerOutput}   MW"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Generator Loss", "${widget.calculateEntity!.gearboxLoss}   MW"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Gearbox Loss", "${widget.calculateEntity!.gearboxLoss}   MW"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Fixed Head Loss", "${widget.calculateEntity!.fixedHeadLoss}   MMBtu/h"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Variable Heat Loss", "${widget.calculateEntity!.variableHeatLoss}   MMBtu/h"),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        Text("Gas Composition", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                        SizedBox(height: 5,),

                        SizedBox(height: 5,),
                        _inputtedDataText("Methane", "${widget.calculateEntity!.methane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Ethane", "${widget.calculateEntity!.ethane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Propane", "${widget.calculateEntity!.propane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("I-Butane", "${widget.calculateEntity!.iButane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("N-Butane", "${widget.calculateEntity!.nButane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("I-Petane", "${widget.calculateEntity!.iPetane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("N-Petane", "${widget.calculateEntity!.nPetane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Hexane", "${widget.calculateEntity!.hexane}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Carbone Monoxide", "${widget.calculateEntity!.carboneMonoxide}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Carbon Dioxide", "${widget.calculateEntity!.carbonDioxide}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Water", "${widget.calculateEntity!.water}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Hydrogen sulfide", "${widget.calculateEntity!.hydrogenSulfide}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Hydrogen", "${widget.calculateEntity!.hydrogen}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Helium", "${widget.calculateEntity!.helium}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Oxygen", "${widget.calculateEntity!.oxygen}   %"),
                        SizedBox(height: 5,),
                        _inputtedDataText("Argon", "${widget.calculateEntity!.argon}   %"),
                        SizedBox(height: 5,),

                      ],
                    ),
                  )
                ),
                Divider(thickness: 1,),
                SizedBox(height: 20,),
                _freeResult(resultEntity),

                SizedBox(height: 30,),
                _paidResult(),

                SizedBox(height: 50,),
                Center(
                  child: ElevatedButton(
                    child: Text('View Result Detail', style: TextStyle(fontSize: 16),),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                        primary: Pigment.fromString(PRIMARY_COLOR),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            )
        )
    );
  }

  Widget _freeResult(ResultEntity resultEntity){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Result', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'PoppinsSemiBold'),),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Fraction of Dry air', style: TextStyle(color: Colors.black, fontSize: 14,),),
              ),
              Expanded(
                flex: 3,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${resultEntity.resultH27}', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: SizedBox()
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Humidity Ratio', style: TextStyle(color: Colors.black, fontSize: 13,),),
              ),
              Expanded(
                flex: 3,
                child:  Container(
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide())
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${resultEntity.resultH28}', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Text('  lb h2O/lb dry air', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Fuel LHV', style: TextStyle(color: Colors.black, fontSize: 13,),),
              ),
              Expanded(
                flex: 3,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${resultEntity.resultH30}', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('  BTU/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('GT Exhaust Flow', style: TextStyle(color: Colors.black, fontSize: 13,),),
              ),
              Expanded(
                flex: 3,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide())
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${resultEntity.resultH31}', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('  lb/h', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('GT Exhaust Enthalpy', style: TextStyle(color: Colors.black, fontSize: 13,),),
              ),
              Expanded(
                flex: 3,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${resultEntity.resultH32}', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('  Btu/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _paidResult(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: autoSizedWidth(context, 2),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 0.0)
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Summary', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'PoppinsSemiBold'),),
            Divider(thickness: 1,),
            SizedBox(height: 10,),
            ///title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 4,
                    child: SizedBox()
                ),
                Expanded(
                  flex: 3,
                  child: Text("Flowl\nb/h", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsSemiBold'),),
                ),
                Expanded(
                    flex: 3,
                    child: Text("Enthalpy\nBtu/lb", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsSemiBold'),),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Duty\nMMBtu/h", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsSemiBold'),),
                ),

              ],
            ),
            SizedBox(height: 10,),
            ///Excess Air at Comp Inlet
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text('Excess Air at Comp Inlet', style: TextStyle(color: Colors.black, fontSize: 14,),),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Pigment.fromString(BG_SELECT_PHOTO),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('0.983223', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: SizedBox()
                ),
                Expanded(
                    flex: 3,
                    child: SizedBox()
                ),

              ],
            ),
            SizedBox(height: 20,),

            ///Combustion Air + Extr Fuel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text('Combustion Air + Extr Fuel', style: TextStyle(color: Colors.black, fontSize: 14,),),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('0.983223', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(), bottom: BorderSide()),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('0.983223', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('0.983223', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                  ),
                ),

              ],
            ),
            


            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text('Fuel LHV', style: TextStyle(color: Colors.black, fontSize: 13,),),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Pigment.fromString(BG_SELECT_PHOTO),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('2321', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('  BTU/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text('GT Exhaust Flow', style: TextStyle(color: Colors.black, fontSize: 13,),),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide())
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('4,223,213', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('  lb/h', style: TextStyle(color: Colors.black, fontSize: 11,),),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Text('GT Exhaust Enthalpy', style: TextStyle(color: Colors.black, fontSize: 13,),),
                ),
                Expanded(
                  flex: 3,
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                      color: Pigment.fromString(BG_SELECT_PHOTO),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text('0.9833', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('  Btu/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
                ),

              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}