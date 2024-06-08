import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:risky_coin/presentation/route/app_router.gr.dart';
import 'package:risky_coin/presentation/screen/product_screen/bloc/product_bloc.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';


@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductInitEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(state is ProductLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Quản lý kho hàng",
                  style: TextStyle(
                    fontSize: 28,
                    color: ColorUtils.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(ProductDetailRoute(id: state.products[index].id ?? 0)).then((value) {
                          if(value == true) {
                            context.read<ProductBloc>().add(ProductInitEvent());
                          }
                        });
                      },
                      child: Card(
                        elevation: 6.0,
                        color: const Color(0xffEDFFFF),
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        "Tên SP: ${state.products[index].name}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: ColorUtils.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        "Tên kho: ${state.products[index].workshop}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: ColorUtils.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
                                  state.products[index].price.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorUtils.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                  itemCount: state.products.length,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(ProductCreateRoute()).then((value){
                    if(value == true) {
                      context.read<ProductBloc>().add(ProductInitEvent());
                    }
                  });
                },
                backgroundColor: ColorUtils.primaryColor,
                child: const Icon(
                  Icons.add,
                  color: ColorUtils.white,
                ),
              )
            );
          }
          return Container();
        },
      ),
    );
  }
}
