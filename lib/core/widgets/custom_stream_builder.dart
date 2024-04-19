import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/message_widget.dart';

import '../utils/colors_palette.dart';
import '../utils/util_values.dart';
import 'loading_widget.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget Function(T) successBuilder;
  final Widget? loadingWidget;
  final Widget Function(String)? errorBuilder;
  final String? errorMessage;
  final bool? asSliver;
  final bool? expandSliver;

  const CustomStreamBuilder({
    Key? key,
    required this.stream,
    required this.successBuilder,
    this.loadingWidget,
    this.errorBuilder,
    this.errorMessage,
    this.asSliver = false,
    this.expandSliver = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (loadingWidget != null) {
            return loadingWidget!;
          } else {
            if (asSliver!) {
              if (expandSliver!) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: loadingWidgetBuilder(),
                );
              } else {
                return SliverToBoxAdapter(
                  child: loadingWidgetBuilder(),
                );
              }
            } else {
              return loadingWidgetBuilder();
            }
          }
        }
        if (snapshot.hasError) {
          if (errorBuilder != null) {
            return errorBuilder!(snapshot.error.toString());
          } else {
            if (asSliver!) {
              if (expandSliver!) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: errorWidgetBuilder(snapshot.error.toString()),
                );
              } else {
                return SliverToBoxAdapter(
                  child: errorWidgetBuilder(snapshot.error.toString()),
                );
              }
            } else {
              return errorWidgetBuilder(snapshot.error.toString());
            }
          }
        }
        return successBuilder(snapshot.data as T);
      },
    );
  }

  Widget errorWidgetBuilder(String error) {
    return Center(
        child: MessageWidget(
      icon: Icons.error,
      message: errorMessage ?? error,
    ));
  }

  Widget loadingWidgetBuilder() {
    return const Center(
      child: Padding(
        padding: UtilValues.padding24,
        child: LoadingWidget(
          color: ColorsPalette.primaryColor,
        ),
      ),
    );
  }
}
