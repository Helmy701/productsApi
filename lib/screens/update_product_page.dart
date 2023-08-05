import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tharwat/models/product_model.dart';
import 'package:tharwat/services/update_product_service.dart';
import 'package:tharwat/widgets/custom_text_field.dart';
import 'package:tharwat/widgets/custon_botton.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key});

  static String id = 'update product';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? productName, desc, image;

  String? price;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update Product',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  CustomTextField(
                    hintText: 'Product Name',
                    keyboardtype: TextInputType.name,
                    onChanged: (data) {
                      productName = data;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Description',
                    keyboardtype: TextInputType.text,
                    onChanged: (data) {
                      desc = data;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Price',
                    onChanged: (data) {
                      price = data;
                    },
                    keyboardtype: TextInputType.number,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Image',
                    onChanged: (data) {
                      image = data;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: 'Update',
                    onTap: () async {
                      isLoading = true;
                      setState(() {});

                      try {} catch (e) {
                        await updateProduct(product);
                        print(e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      id: product.id,
      title: productName == null ? product.title : productName!,
      price: price == null ? product.price.toString() : price!,
      desc: desc == null ? product.description! : desc!,
      image: image == null ? product.image : image!,
      category: product.category,
    );
  }
}
