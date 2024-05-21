import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:risky_coin/domain/entity/user_entity.dart';
import 'package:risky_coin/presentation/common/text_field_common.dart';
import 'package:risky_coin/presentation/screen/home_screen/bloc/home_bloc.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeEventInit()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if(state is HomeStateError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if(state is HomeStateLoaded) {
            _nameController.text = state.userEntity.name;
            _emailController.text = state.userEntity.email;
            _phoneController.text = state.userEntity.phone;
            _addressController.text = state.userEntity.address;
          }
        },
        builder: (context, state) {
          if(state is HomeStateLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: _body(context),
            ),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _userInformation(context),
            _sizeBoxH16(),
            _informationField(context, 'Name', _nameController),
            _informationField(context, 'Email', _emailController),
            _informationField(context, 'Phone', _phoneController),
            _informationField(context, 'Address', _addressController),
            _buttonCreate(context),
            _buttonSave(context),
          ],
        ),
      ),
    );
  }

  Widget _userInformation(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
          color: ColorUtils.primaryColor,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _avatar(context),
              ],
            ),
          )
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return const CircleAvatar(
      radius: 36,
      backgroundImage: NetworkImage('https://cdn.cmp.edu.vn/wp-content/uploads/2024/04/anh-cuoi-bua-1.jpg'),
    );
  }

  Widget _sizeBoxH16() {
    return const SizedBox(height: 16);
  }

  Widget _informationField(BuildContext context, String hintText, TextEditingController controller) {
    return TextFieldCommon(
      controller: controller,
      hintText: hintText,
    );
  }

  Widget _buttonSave(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeBloc>().add(HomeEventSave(
          userEntity: UserEntity(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
          ),
        ));
      },
      child: const Text('Save'),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeBloc>().add(HomeEventCreate(
          userEntity: UserEntity(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
          ),
        ));
      },
      child: const Text('Create'),
    );
  }
}
