import 'package:flutter/material.dart';
import 'package:flutter_scaffold/account/address_add_page.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:flutter_scaffold/services/address_service.dart';
import 'package:flutter_scaffold/services/basket_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage>{

    final addressService = new AddressService();
    final basketService  = new BasketService();
    List<Address> address;

    bool loading = true;
    
    @override
    void initState() {
       this.getAddress();
    }

    void getAddress() async {
        
        this.address = await this.addressService.fetchAddress();

        setState(() {
            loading = false;
        });
    }

    void setAddressToBasket({int addressId}) async {
        Map result = await this.basketService.setAddressToBasket(addressId: addressId);

        Fluttertoast.showToast(
            msg: "${result['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            fontSize: 16.0
        );

        if (result['ok']) {
            Navigator.pushNamed(context, '/checkout');
        }
    }


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Selecciona una dirección'),
            ),
            body: loading == false
                ? _addressList()
                : Center(child: CircularProgressIndicator()),
        );
    }

    Widget _addressList() {
        return this.address.length != 0 ? SafeArea(
            top: false,
            left: false,
            right: false,
            child: Container(
                child: ListView.builder(
                    itemCount: this.address ==  null ? 0 : this.address.length,
                    itemBuilder: (BuildContext context , int index) {
                        Address address = this.address[index];
                        return Container(
                            child: Card(
                                child: ListTile(
                                    onTap: (){
                                        //Navigator.pushNamed(context, '/checkout');
                                        this.setAddressToBasket(addressId:address.addressId);
                                    },
                                    leading: Icon(
                                        Icons.place,
                                        color: Theme.of(context).accentColor,
                                        size: 28,
                                    ),
                                    title: Text('${address.colonia} No. Int ${address.nInterior} No. Ext ${address.nExterior} ',
                                        style:TextStyle(color: Colors.black, fontSize: 17)
                                    ),
                                    subtitle:  Text('${address.estado}, ${address.municipio}, ${address.codigoPostal}'),
                                    trailing: Icon(Icons.edit, color: Theme.of(context).accentColor, ) 
                                ),
                            ),
                        );
                    },
                ),
            ),
        ) : Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32, top: 10, bottom: 10),
            child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                height: 40.0,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressAddPage(edit: false,)));
                    },
                    child: Text(
                        "Nueva dirección",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                ),
            ),
        );
    }
}