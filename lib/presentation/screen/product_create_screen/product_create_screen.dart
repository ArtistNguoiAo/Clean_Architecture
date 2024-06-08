import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risky_coin/presentation/common/text_field_common.dart';
import 'package:risky_coin/presentation/screen/product_create_screen/bloc/product_create_bloc.dart';
import 'package:risky_coin/presentation/utils/text_style_utils.dart';

import '../../utils/color_utils.dart';

@RoutePage()
class ProductCreateScreen extends StatelessWidget {
  ProductCreateScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController factoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCreateBloc()..add(ProductCreateInitEvent()),
      child: BlocConsumer<ProductCreateBloc, ProductCreateState>(
        listener: (context, state) {
          if(state is ProductCreateSuccess) {
            AutoRouter.of(context).maybePop(true);
          }
          if(state is ProductCreateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if(state is ProductCreateLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(state is ProductCreateLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Thêm mới sản phẩm",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _input("Tên sản phẩm", nameController),
                      const SizedBox(height: 16.0),
                      _input("Mô tả sản phẩm", descriptionController),
                      const SizedBox(height: 16.0),
                      _input("Xưởng sản xuất", factoryController),
                      const SizedBox(height: 16.0),
                      _input("Giá thành", priceController),
                      const SizedBox(height: 16.0),
                      _input("Số lượng", quantityController),
                      const SizedBox(height: 32.0),
                      _buttonAdd(context),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        },
      ),
    );
  }

  Widget _input(String title, TextEditingController controller) {
    return TextFieldCommon(
    style: TextStyleUtils.textStyleNunitoS18W500Black,
    hintText: title,
    prefixIcon: const Icon(
      FontAwesomeIcons.receipt,
      color: ColorUtils.primaryColor,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorUtils.primaryColor),
    ),
    controller: controller,
    );
  }

  Widget _buttonAdd(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductCreateBloc>(context).add(
          ProductCreateAddEvent(
            name: nameController.text,
            description: descriptionController.text,
            workshop: factoryController.text,
            price: priceController.text,
            quantity: quantityController.text,
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: ColorUtils.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Thêm mới",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
