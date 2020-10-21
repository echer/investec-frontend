import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GraficoPizzaCarteira extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GraficoPizzaCarteira(this.seriesList, {this.animate});

  factory GraficoPizzaCarteira.newInstance(List<CarteiraPrecoVM> series) {
    return new GraficoPizzaCarteira(
      _createData(series),
      //_createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      //
      // [ArcLabelDecorator] will automatically position the label inside the
      // arc if the label will fit. If the label will not fit, it will draw
      // outside of the arc with a leader line. Labels can always display
      // inside or outside using [LabelPosition].
      //
      // Text style for inside / outside can be controlled independently by
      // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
      //
      // Example configuring different styles for inside/outside:
      //       new charts.ArcLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 60,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            showLeaderLines: true,
            labelPosition: charts.ArcLabelPosition.auto,
          ),
        ],
      ),
      behaviors: [
        new charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.top,
          // For a legend that is positioned on the left or right of the chart,
          // setting the justification for [endDrawArea] is aligned to the
          // bottom of the chart draw area.
          outsideJustification: charts.OutsideJustification.endDrawArea,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Set [showMeasures] to true to display measures in series legend.
          showMeasures: true,
          // Configure the measure value to be shown by default in the legend.
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          // Optionally provide a measure formatter to format the measure value.
          // If none is specified the value is formatted as a decimal.
          measureFormatter: (num value) {
            return value == null ? '-' : 'R\$ $value';
          },
        ),
      ],
    );
  }

  static List<charts.Series<CarteiraPrecoVM, String>> _createData(
      List<CarteiraPrecoVM> data) {
    return [
      new charts.Series<CarteiraPrecoVM, String>(
        id: 'Carteiras',
        domainFn: (CarteiraPrecoVM obj, _) => obj.carteira.nomeCarteira,
        measureFn: (CarteiraPrecoVM obj, _) => obj.saldoAtual,
        data: data,
        labelAccessorFn: (CarteiraPrecoVM row, _) =>
            '${row.carteira.nomeCarteira}',
      )
    ];
  }
}
