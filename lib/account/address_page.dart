import 'package:flutter/material.dart';
import 'package:flutter_scaffold/account/address_add_page.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:flutter_scaffold/services/address_service.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
    
    final addressService = AddressService();

    List<Address> address;
    bool loading = true;
    @override
    void initState() {
        this.getAddress();
    }

    void getAddress() async {
        this.address = await addressService.fetchAddress();
        setState(() {
            loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Mis direcciones'),
            ),
            body: loading == false 
                ? _addressList()
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressAddPage(edit: false,)));
                },
                child: Icon(Icons.add_location),
            
            ),
        );
    }

    Widget _addressList() {
        return SafeArea(
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressAddPage(edit: true,addressId: address.addressId,)));
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
        );
    }
}