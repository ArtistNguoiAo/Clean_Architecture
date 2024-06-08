import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/presentation/common/text_field_common.dart';
import 'package:risky_coin/presentation/screen/product_detail_screen/bloc/product_detail_bloc.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';
import 'package:risky_coin/presentation/utils/text_style_utils.dart';

@RoutePage()
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.id});

  final int id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController factoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc()..add(ProductDetailInitEvent(id: id)),
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if(state is ProductDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if(state is ProductDetailDeleted) {
            AutoRouter.of(context).maybePop(true);
          }
          if(state is ProductDetailUpdated) {
            AutoRouter.of(context).maybePop(true);
          }
          if(state is ProductDetailLoaded) {
            nameController.text = state.productEntity.name;
            descriptionController.text = state.productEntity.description;
            factoryController.text = state.productEntity.workshop;
            priceController.text = state.productEntity.price;
            quantityController.text = state.productEntity.quantity;
          }
        },
        builder: (context, state) {
          if(state is ProductDetailLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(state is ProductDetailLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Chi tiết sản phẩm",
                  style: TextStyle(
                    fontSize: 28,
                    color: ColorUtils.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _item("Tên sản phẩm", nameController),
                        const SizedBox(height: 16.0),
                        _item("Mô tả sản phẩm", descriptionController),
                        const SizedBox(height: 16.0),
                        _item("Xưởng sản xuất", factoryController),
                        const SizedBox(height: 16.0),
                        _item("Giá thành", priceController),
                        const SizedBox(height: 16.0),
                        _item("Số lượng", quantityController),
                        const SizedBox(height: 32.0),
                        _button(context),
                      ],
                    ),
                  )
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

  Widget _item(String title, TextEditingController controller) {
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

  Widget _button(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        InkWell(
          onTap: () {
            context.read<ProductDetailBloc>().add(ProductDetailUpdateEvent(
              productEntity: ProductEntity(
                id: id,
                name: nameController.text,
                description: descriptionController.text,
                workshop: factoryController.text,
                price: priceController.text,
                quantity: quantityController.text,
              ),
            ));
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              border: Border.all(color: Colors.red, width: 4),
            ),
            child: Text(
              "Sửa",
              style: TextStyleUtils.textStyleNunitoS20W600White,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        InkWell(
          onTap: () {
            context.read<ProductDetailBloc>().add(ProductDetailDeleteEvent(id: id));
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            decoration: BoxDecoration(
              color: ColorUtils.red,
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              border: Border.all(color: Colors.red, width: 4),
            ),
            child: Text(
              "Xóa",
              style: TextStyleUtils.textStyleNunitoS20W600White,
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
