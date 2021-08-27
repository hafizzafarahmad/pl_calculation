

import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/error/error_page.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/format_currency.dart';
import 'package:pl_calculation/core/platform/format_date.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_event.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/listResult/presentation/pages/list_result_page.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_state.dart';
import 'package:pl_calculation/features/result/presentation/widgets/input_name_resdult_dialog.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

typedef OnFinished<ParamsPasutri> = void Function(ParamsPasutri item);
typedef OnBack<ParamsPasutri> = void Function(ParamsPasutri item);

class ResultPage extends StatefulWidget  {
  final CalculateEntity? calculateEntity;

  const ResultPage({Key? key, this.calculateEntity }) : super(key: key);

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {
  bool imperial = false;

  List<String> _kProductIds = <String>[
    "full_version_1"
  ];

  InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _purchased = false;
  String? _queryProductError;

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

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = isAvailable;
    });

    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
      });
      return;
    }
  }

  _purcaseProcess()async{
    PurchaseDetails? previousPurchase;
    Map<String, PurchaseDetails> purchases =
    Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    print("PRODUK ${_products.isNotEmpty}");

    if(_products.isNotEmpty){
      _products.map((ProductDetails productDetails){
        previousPurchase = purchases[productDetails.id];

        late PurchaseParam purchaseParam;
        if (Platform.isAndroid) {
          // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
          // verify the latest status of you your subscription by using server side receipt validation
          // and update the UI accordingly. The subscription purchase status shown
          // inside the app may not be accurate.

          purchaseParam = GooglePlayPurchaseParam(
              productDetails: productDetails,
              applicationUserName: null,
              changeSubscriptionParam: null);

        } else {
          purchaseParam = PurchaseParam(
            productDetails: productDetails,
            applicationUserName: null,
          );
        }

        _inAppPurchase.buyNonConsumable(
            purchaseParam: purchaseParam);
      });
    } else {
      alertToast("Product Not Found");
    }

  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }


  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("STATUS PENDING");
        alertToast("Purchase PENDING");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("STATUS ERROR");
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            print("STATUS VALID");
            _purchased = true;
            alertToast("Purchase Success");
          } else {
            print("STATUS INVALID");
            alertToast("Purchase INVALID");
            return;
          }
        }
        if (Platform.isAndroid) {
          if (purchaseDetails.productID == "full_version_1") {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:  BlocBuilder<ResultBloc, ResultState>(
            builder: (context, state){

              ///LoadingKontakState
              if(state is LoadingResultState  ){
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 5,),
                    Text('Calculating...', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
                  ],
                ),);
              } else if (state is ResultRetrievedState){
                return _mainBody(state.resultEntity!);
              } else if (state is ErrorResultState){
                return Container(
                    width: autoSizedWidth(context, 1),
                    height: autoSizedHeight(context, 0.75),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ErrorPage(messages: state.messages, onTap: () {
                      // _onRefresh();
                      context.read<ResultBloc>().add(GetResultEvent(context: context, calculateEntity: widget.calculateEntity));
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
                SizedBox(height: 20,),
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
                        _inputtedDataText("Enthalpy", "${widget.calculateEntity!.enthalpy}"),
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
                        _inputtedDataText("Nitrogen", "${widget.calculateEntity!.nitrogen}   %"),
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
                Text("can purchase    $_isAvailable", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                Text("purchased    $_purchased", style: TextStyle(color: Colors.black, fontFamily: 'PoppinsSemiBold', fontSize: 14)),
                SizedBox(height: 50,),
                SizedBox(height: 30,),
                Center(
                  child: ElevatedButton(
                    child: Text(_purchased ? "Purchased" : 'Upgrade Version', style: TextStyle(fontSize: 16, color: Pigment.fromString(PRIMARY_COLOR)),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                      primary: Colors.white,
                      side: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      if(!_purchased){
                        _purcaseProcess();
                      }


                    },
                  ),
                ),
                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: FittedBox(
                            child: Text('Save Result', style: TextStyle(fontSize: 15,
                            color: Pigment.fromString(PRIMARY_COLOR)),),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          primary: Colors.white,
                          side: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return InputNameResultDialog(calculateEntity: widget.calculateEntity,
                                  resultEntity: resultEntity,);
                              });
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: FittedBox(child: Text('Back to Menu', style: TextStyle(fontSize: 15),),),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          primary: Pigment.fromString(PRIMARY_COLOR),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                        onPressed: () {
                          context.read<ListResultBloc>().add(GetListResultEvent());
                          Hive.deleteBoxFromDisk(BOX_CALCULATION);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              ListResultPage()), (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
              ],
            )
        )
    );
  }

  Widget _freeResult(ResultEntity resultEntity){
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(10)),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //       color: Colors.black12,
        //       blurRadius: 1.0,
        //       spreadRadius: 1.0,
        //       offset: Offset(0.0, 0.0)
        //   )
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Result', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'PoppinsSemiBold'),),
          // Divider(thickness: 1,),
          SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Fraction of Dry air', maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: autoSizedWidth(context, 0.031),),),
              ),
              Expanded(
                flex: 5,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${formattedCurrency(resultEntity.h28!)}${resultEntity.h28!.split(".").last}', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: SizedBox()
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Humidity Ratio', maxLines: 1,
                  style: TextStyle( color: Colors.black, fontSize: autoSizedWidth(context, 0.031),),),
              ),
              Expanded(
                flex: 5,
                child:  Container(
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide())
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${formattedCurrency(resultEntity.h29!)}${resultEntity.h29!.split(".").last}', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text('  lb h2O', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('Fuel LHV', maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: autoSizedWidth(context, 0.031),),),
              ),
              Expanded(
                flex: 5,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${formattedCurrency(resultEntity.h31!)}${resultEntity.h31!.split(".").last}', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('  BTU/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('GT Exh Flow', maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: autoSizedWidth(context, 0.031),),),
              ),
              Expanded(
                flex: 5,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide())
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${formattedCurrency(resultEntity.h32!)}${resultEntity.h32!.split(".").last}', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('  lb/h', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text('GT Exh Enthalpy', maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: autoSizedWidth(context, 0.031),),),
              ),
              Expanded(
                flex: 5,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                    color: Pigment.fromString(BG_SELECT_PHOTO),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('${formattedCurrency(resultEntity.h33!)}${resultEntity.h33!.split(".").last}',
                    style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'PoppinsMedium'),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('  Btu/lb', style: TextStyle(color: Colors.black, fontSize: 11,),),
              ),
            ],
          ),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.check_circle_sharp, color: !imperial ? Colors.red : Colors.grey),
                        SizedBox(width: 10,),
                        Text(
                          "Metric",
                          style: TextStyle(
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.check_circle_sharp, color: imperial ? Colors.red : Colors.grey),
                        SizedBox(width: 10,),
                        Text(
                          "Imperial",
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                icon: Icon(Icons.settings, size: 18, ),
                offset: Offset(0, 0),
                onSelected: (value){
                  if(value == 0){
                    setState(() {
                      imperial = false;
                    });
                  }else{
                    setState(() {
                      imperial = true;
                    });
                  }
                },
              ),
            ],
          ),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (imperial) ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('${formattedCurrency(resultEntity.h63!)}${resultEntity.h63!.split(".").last}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(' F', textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('${formattedCurrency(resultEntity.h64!)}${resultEntity.h64!.split(".").last}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(' klb/h', textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ),
                      ],
                    ),
                  ],
                ) :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('${formattedCurrency(resultEntity.h66!)}${resultEntity.h66!.split(".").last}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(' C', textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('${formattedCurrency(resultEntity.h67!)}${resultEntity.h67!.split(".").last}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(' Ton/h', textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Image.asset(
                  'assets/diagram.png',
                  fit: BoxFit.cover,
                  width: autoSizedWidth(context, 0.9),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          (imperial) ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f67!)}${resultEntity.f67!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' Psia', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f68!)}${resultEntity.f68!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' F', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f69!)}${resultEntity.f69!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' klb/h', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                            ],
                          ) :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f72!)}${resultEntity.f72!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' mBar', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f73!)}${resultEntity.f73!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' C', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.f74!)}${resultEntity.f74!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' Ton/h', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          (imperial) ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j78!)}${resultEntity.j78!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' F', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j79!)}${resultEntity.j79!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' klb/h', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j80!)}${resultEntity.j80!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' Btu/lb', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                            ],
                          ) :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j82!)}${resultEntity.j82!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' C', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j83!)}${resultEntity.j83!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' Ton/h', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('${formattedCurrency(resultEntity.j84!)}${resultEntity.j84!.split(".").last}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'PoppinsMedium'),),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(' kJ/kg', textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black, fontSize: 14,),),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          )
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