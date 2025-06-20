import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/helper/text_helper.dart';

class CardMenu extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? image;
  final EdgeInsets? contentPadding;

  final Function()? onTap;
  final bool? isSelected;
  final bool? isEnable;
  final Color? colorImgContainer;
  final Color? color;
  final String? router;
  final Object? extra;
  final BoxShape? shape;
  final Widget? subtitleWidget;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final TextStyle? titleStyle;

  final Widget? imageWidget;

  const CardMenu({
    Key? key,
    this.title,
    this.color,
    this.titleStyle,
    this.subtitleWidget,
    this.titleWidget,
    this.contentPadding,
    this.leadingWidget,
    this.shape,
    this.colorImgContainer,
    this.subtitle,
    this.trailingWidget,
    this.isEnable,
    this.image,
    this.onTap,
    this.router,
    this.isSelected,
    this.extra,
    this.imageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            context.pushNamed(router!, extra: extra);
          },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color:
              isEnable == true ? color ?? Colors.grey.withOpacity(.09) : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected == true
                ? Colors.blue.withOpacity(.6)
                : const Color(0xffE5E7EB),
          ),
        ),
        child: ListTile(
          horizontalTitleGap: 6.5,
          minVerticalPadding: 6,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          leading: image == null && imageWidget == null && leadingWidget == null
              ? null
              : imageWidget != null
                  ? Container(
                      height: 35,
                      width: 35,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: shape ?? BoxShape.rectangle,
                        color: isSelected == true
                            ? Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(.2)
                            : colorImgContainer ?? const Color(0xffE6F1FB),
                        borderRadius: shape == BoxShape.circle
                            ? null
                            : BorderRadius.circular(10),
                      ),
                      child: imageWidget,
                    )
                  : leadingWidget ??
                      Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: shape ?? BoxShape.rectangle,
                          color: colorImgContainer ?? const Color(0xffE6F1FB),
                          borderRadius: shape == BoxShape.circle
                              ? null
                              : BorderRadius.circular(10),
                        ),
                        child: imageWidget ??
                            SvgPicture.asset(
                              image ?? 'assets/svgs/ic_security.svg',
                            ),
                      ),
          title: titleWidget ??
              Text(
                title ?? 'Menu',
                style:
                    titleStyle ?? getTextStyle(context: context, fontSize: 14),
              ),
          subtitle: subtitle == null && subtitleWidget == null
              ? null
              : subtitleWidget ??
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      subtitle ?? '',
                      style: getTextStyle(context: context, fontSize: 12),
                    ),
                  ),
          trailing: trailingWidget ??
              Icon(
                Icons.arrow_forward,
                size: 25,
              ),
        ),
      ),
    );
  }
}
