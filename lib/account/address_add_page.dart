import 'package:flutter/material.dart';
import 'package:flutter_scaffold/account/address_page.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:flutter_scaffold/services/address_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressAddPage extends StatefulWidget {

    final bool edit;
    final int addressId;

    const AddressAddPage({@required this.edit, this.addressId});

    @override
    _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage>{

    final addressService = new AddressService();
    final _formKey = GlobalKey<FormState>();
    Address address;
    bool loading = false;

    String codigoPostal,estado,municipio,colonia,calle,nInterior,nExterior,calle1,calle2,telefono,referencia;
    
    @override
    void initState() {
        if (widget.edit)
            this.getAddress();
    }

    void getAddress() async {
        setState(() {
            loading = true;
        });
        address= await addressService.getAddress(addressId:widget.addressId);
        setState(() {
            loading = false;
        });
    }

    void deleteAddres() async {
        setState(() {
            loading = true;
        });
        Map result = await this.addressService.deleteAddress(addressId:widget.addressId);

        await Fluttertoast.showToast(
            msg: "${result['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            fontSize: 16.0
        );
        setState(() {
            loading = false;
        });

        if (result['ok']) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddressPage()));
        }

       
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.edit ? 'Actualizar dirección' : 'Agreagar dirección'),
            ),
            body: loading == false 
                ? _form()
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: widget.edit ? FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                   this.deleteAddres();
                },
                child: Icon(Icons.delete_forever),
            
            ) : Text('') ,
        );
    }

    Widget _form() {
        return Center(
            child: Form(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.telefono}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa el numero de telefono de referencia';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                codigoPostal = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa tu numero de telefono',
                                            labelText: 'Numero de telefono',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.codigoPostal}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa el codigo postal';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                codigoPostal = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa el codigo postal',
                                            labelText: 'Codigo postal',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.estado}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa el estado';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                estado = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa el estado',
                                            labelText: 'Estado',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.municipio}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa el Municipio';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                municipio = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa el municipio',
                                            labelText: 'Municipio',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.colonia}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa la colonia';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                colonia = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa la colonia',
                                            labelText: 'Colonia',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.calle}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa la calle principal';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                calle = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa la calle principal',
                                            labelText: 'Calle principal',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.nInterior}' : '',

                                        onSaved: (value) {
                                            setState(() {
                                                nInterior = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa la calle principal',
                                            labelText: 'N° Interior / Depto (opcional)',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.nExterior}' : '',
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Por favor ingresa el numero exterior';
                                            }
                                            return null;
                                        },
                                        onSaved: (value) {
                                            setState(() {
                                                nExterior = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa el numero exterior',
                                            labelText: 'Numero exterior',
                                        ),
                                    ),
                                ),
                                SizedBox(height: 15.0,),
                                Text(
                                    '¿Entre que calles esta ? (Opcional)'
                                ),
                                SizedBox(height: 15.0,),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.calle1}' : '',
                                        
                                        onSaved: (value) {
                                            setState(() {
                                                calle1 = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa la calle 1',
                                            labelText: 'Calle 1',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.calle2}' : '',
                                        
                                        onSaved: (value) {
                                            setState(() {
                                                calle2 = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Ingresa la calle 2',
                                            labelText: 'Calle 2',
                                        ),
                                    ),
                                ),
                                SizedBox(height: 15.0,),
                                Text(
                                    'Indicaciones adicionales para entregar tu compra en esta dirección'
                                ),
                                SizedBox(height: 15.0,),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormField(
                                        initialValue: widget.edit ? '${address.referencias}' : '',
                                        
                                        onSaved: (value) {
                                            setState(() {
                                                referencia = value;
                                            });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Referencias',
                                            labelText: 'Referencias',
                                        ),
                                    ),
                                ),
                                 SizedBox(height: 15.0,),
                                Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: ButtonTheme(
                                        buttonColor: Theme.of(context).primaryColor,
                                        minWidth: double.infinity,
                                        height: 40.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                                
                                            },
                                            child: Text(
                                                "Guardar",
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}