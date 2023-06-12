import 'package:flutter/material.dart';
import 'package:miaged/screens/product.dart';

class ProductsDesignWidget extends StatefulWidget {
  Products? model;
  BuildContext? context;

  ProductsDesignWidget({
    this.context,
    this.model,
  });

  @override
  State<ProductsDesignWidget> createState() => _ProductsDesignWidgetState();
}

class _ProductsDesignWidgetState extends State<ProductsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children : [
                    CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    minRadius: 90.0,
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(
                        widget.model!.image!,
                      ),
                    )
                ),
                    const SizedBox(height: 10.0,),
                    Text(
                      widget.model!.titre!,
                      style: const TextStyle(
                        color : Colors.pink,
                        fontSize: 20,
                        fontFamily: "Bebas",
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Text(
                      widget.model!.marque!,
                      style: const TextStyle(
                        color : Colors.pink,
                        fontSize: 12,
                      ),
                    ),
                ],
                ),
            ),
        ),
    );
  }
}
