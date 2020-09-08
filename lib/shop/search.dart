import 'package:flutter/material.dart';
import 'package:flutter_scaffold/shop/shop.dart';

class ShopSearch extends StatefulWidget {
  @override
  _ShopSearchState createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  String dropdownValue = 'One';
  @override
  RangeValues _values = RangeValues(0.0, 500.0);
  Widget build(BuildContext context) {
    return Container(
      height: 425,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                blurRadius: 2, color: Colors.black12, spreadRadius: 3)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                  child: Container(
                    width: 30,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                      'Selecciona un rango de precios', style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
                RangeSlider(
                    values: _values,
                    min: 0,
                    max: 5000,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.grey[300],
                    onChanged: (RangeValues values) {
                        setState(() {
                            if (values.end - values.start >= 20) {
                            _values = values;
                            } else {
                            if (_values.start == values.start) {
                                _values = RangeValues(_values.start, _values.start + 20);
                            } else {
                                _values = RangeValues(_values.end - 20, _values.end);
                            }
                            }
                        });
                    }
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          width: 120,
                          height: 45.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Theme.of(context).accentColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$ ${_values.start.round()}', style: TextStyle(color: Colors.white)),
                          )
                      ),
                      Text('a', style: TextStyle(fontSize: 16, color: Colors.black),),
                      Container(
                          width: 120,
                          height: 45.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Theme.of(context).accentColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$ ${_values.end.round()}', style: TextStyle(color: Colors.white)),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        buttonColor: Theme.of(context).primaryColor,
                        minWidth: double.infinity,
                        height: 40.0,
                        child: RaisedButton(
                          onPressed: () {
                            double minPrice = _values.start;
                            double maxPrice = _values.end;
                            bool toFilter = true;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Shop(minPrice: minPrice, maxPrice: maxPrice, toFilter: toFilter)));
                          },
                          child: Text(
                            "Aplicar filtro",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }
}
