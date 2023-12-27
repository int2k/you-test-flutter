import 'package:youappflutter/bloc/auth/auth_bloc.dart';
import 'package:youappflutter/components/custom_text.dart';
import 'package:youappflutter/constants/color_constant.dart';
import 'package:youappflutter/constants/icon_enums.dart';
import 'package:youappflutter/constants/string_constant.dart';
import 'package:youappflutter/extensions/context_extensions.dart';
import 'package:youappflutter/extensions/image_extensions.dart';
import 'package:youappflutter/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youappflutter/views/login/login_view.dart';


class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    this.isHome = false,
  }) : super(key: key);

  final bool isHome;

  @override
  State<AppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      leadingWidth: 120,
      leading: ElevatedButton.icon(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
        label: const Text('Back'),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      // flexibleSpace: Container(
      //   clipBehavior: Clip.antiAlias,
      //   decoration: ShapeDecoration(
      //     gradient: RadialGradient(
      //       center: Alignment(0.58, 0.83),
      //       radius: 0.35,
      //       colors: [Color(0xFF1F4247), Color(0xFF0D1C22), Color(0xFF09141A)],
      //     ),
      //     shape: ContinuousRectangleBorder(
      //       borderRadius: BorderRadius.circular(0),
      //     ),
      //   ),
      // ),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Image.asset(
      //       IconEnums.appLogo.iconName.toPng,
      //       height: context.dynamicHeight(0.03),
      //       width: context.dynamicWidth(0.06),
      //     ),
      //     7.pw,
      //     CustomText(
      //       StringConstants.appName,
      //       textStyle: context.textTheme.headlineSmall,
      //
      //     ),
      //   ],
      // ),
      actions: [
        widget.isHome
            ? IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: ColorConstants.black,
                ),
              )
            : const SizedBox.shrink(),
        10.pw,
      ],
    );
  }
}
