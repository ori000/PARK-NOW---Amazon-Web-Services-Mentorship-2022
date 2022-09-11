import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllPage extends StatefulWidget {
  const ViewAllPage({ Key? key }) : super(key: key);

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {

final data=0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> users=FirebaseFirestore.instance.collection("Collaborator Info").snapshots();
    const appTitle = 'View All';

    return MaterialApp(
      title: 'PARK NOW',
      debugShowCheckedModeBanner: false,
      theme: _buildShrineTheme(),
      home: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("something went wrong");
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Text("Loading");
          }

          final data=snapshot.requireData;

          return DataTableDemo(data: data);

        },
      ),
    );
  }
}

class DataTableDemo extends StatelessWidget {
  final data;

  const DataTableDemo(
      {Key? key,
        required this.data, // non-nullable and required
        //this.placeHolder = "", // non-nullable but optional with a default value
        //this.onFocusChange, // nullable and optional
      })
      : super(key: key);


  //DataTableDemo(final data);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Tables'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            header: Text('Header Text'),
            rowsPerPage: 4,
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Price/Hr')),
              DataColumn(label: Text('Operating Hrs')),
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text('Available Spots')),
            ],
            source: _DataSource(context,data),
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD,
      this.valueE,
      this.valueF
      );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context,data) {
    _rows = <_Row>[
     // _Row('', 'CellB1', 'CellC1', 'CellD1', 'CellE1', 'CellF1'),

    ];

    /*
        DataColumn(label: Text('Name')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Price/Hr')),
              DataColumn(label: Text('Operating Hrs')),
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text('Available Spots')),
     */
    for(int index=0; index<data.size; index++){
      _rows.add(_Row("${data.docs[index]["Org Name"]}" , "${data.docs[index]["Location"]}" , "${data.docs[index]["Price"]}" ,"${data.docs[index]["Hours"]}" ,"${data.docs[index]["Mobile Number"]}" ,"${data.docs[index]["Availability"]}"));
    }

  }

  final BuildContext context;
  late List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount == value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value!;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    caption: base.caption?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    button: base.button?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: 'Rubik',
    displayColor: shrineBrown900,
    bodyColor: shrineBrown900,
  );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;