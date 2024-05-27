import 'package:fashionwear_ecommerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributesTabScreen extends StatefulWidget {
  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  List<String> _sizeList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your brand name';
              }
              return null;
            },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(
              labelText: 'Brand',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                ),
              ),
              _entered
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                          _entered = false;
                        });
                        print(_sizeList);
                      },
                      child: Text('Add'),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sizeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                              _productProvider.getFormData(sizeList: _sizeList);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _sizeList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _productProvider.getFormData(sizeList: _sizeList);
              },
              child: Text('Save'),
            ),
        ],
      ),
    );
  }
}
