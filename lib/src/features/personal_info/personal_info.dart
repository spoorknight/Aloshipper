import 'package:app_shipper/src/shared/button_switch.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../configs/config.dart';
import '../../di/injection/injection.dart';
import '../../models/content_share_model.dart';
import '../../models/profile_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/button.dart';
import '../../shared/cache_image_network.dart';
import '../../shared/loading.dart';
import '../../utils/permission_helper/app_permission.dart';
import '../profile/profile_view_model.dart';
import '../profile/widgets/chevron_right_button.dart';
import 'widgets/modal_review_shipper.dart';
import 'widgets/price_setting.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return viewModel.isLoading
        ? const Loading()
        : Container(
            color: Palette.newLightGrey,
            child: SmartRefresher(
              controller: viewModel.refreshProfileCtl,
              onRefresh: viewModel.onRefreshProfile,
              child: SingleChildScrollView(
                child: StreamBuilder<ProfileModel?>(
                    stream: appData.profile,
                    builder: (context, profile) {
                      return Column(
                        children: [
                          Container(
                            color: Palette.white,
                            child: Column(
                              children: [
                                BoxConst.s16,
                                _profile(context, profile, viewModel),
                                BoxConst.s8,
                                _checkGPS(viewModel),
                                BoxConst.s8,
                                _userFunction(context, viewModel),
                              ],
                            ),
                          ),
                          BoxConst.s16,
                          _feeView(context, profile, viewModel),
                          BoxConst.s16,
                          _logout(context, viewModel),
                          _removeAccount(context, viewModel),
                        ],
                      );
                    }),
              ),
            ),
          );
  }

  Widget _profile(BuildContext context, AsyncSnapshot<ProfileModel?> profile,
      ProfileViewModel viewModel) {
    return InkWell(
      onTap: () async {
        final res = await AppNavigator.push(Routes.updateProfile);
        if (res == true) viewModel.getProfile();
      },
      child: Container(
        margin: AppTheme.mainPadding,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Palette.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 70.h,
                height: 70.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImageCustom(
                  url: profile.data?.item?.userAvatar ?? '',
                ),
              ),
            ),
            BoxConst.s8,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      BoxConst.s4,
                      Expanded(
                        child: Text(
                          '${profile.data?.item?.user?.firstName} ${profile.data?.item?.user?.lastName ?? ''}',
                          style: AppFont.t.s(16).w700,
                        ),
                      ),
                    ],
                  ),
                  BoxConst.s4,
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16),
                      BoxConst.s4,
                      Text(profile.data?.item?.user?.phoneNumber ?? '',
                          style: AppFont.t)
                    ],
                  ),
                  BoxConst.s4,
                  Row(
                    children: [
                      const Icon(Icons.motorcycle, size: 16),
                      BoxConst.s4,
                      Text(profile.data?.item?.user?.biensoxe ?? '',
                          style: AppFont.t)
                    ],
                  ),
                  BoxConst.s4,
                  Row(
                    children: [
                      const Icon(Icons.place, size: 16),
                      BoxConst.s4,
                      Expanded(
                          child: Text(profile.data?.item?.user?.address ?? '',
                              style: AppFont.t))
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Palette.grey, size: 50),
          ],
        ),
      ),
    );
  }

  Widget _checkGPS(ProfileViewModel viewModel) {
    return InkWell(
      onTap: () {
        GrantPermissionLocationStrategy().request(
          onGranted: viewModel.updateToaDo,
          onDenied: appData.showDialogOpenAppSettings,
          onPermanentlyDenied: appData.showDialogOpenAppSettings,
        );
      },
      child: Container(
        margin: AppTheme.mainPadding,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Palette.yellow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Kiểm tra định vị',
              style: AppFont.t.s(24).w900.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MyButton(
        title: 'Đăng xuất',
        action: viewModel.logOut,
        width: 0.5.sw,
        borderRadius: 8.r,
      ),
    );
  }

  Widget _removeAccount(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MyTextButton(
        text: 'Xóa tài khoản',
        style: AppFont.t.underline.red,
        action: () {
          showDialog(
            context: context,
            builder: (builder) {
              return DialogConfirmDeleteAccount(
                mess: 'Bạn có chắc chắn muốn xóa tài khoản này không?',
                confirmName: 'Đồng ý',
                action: viewModel.deleteAccount,
              );
            },
          );
        },
      ),
    );
  }

  Widget _userFunction(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      children: [
        const Divider(color: Palette.grey, height: 1),
        ChevronRightButton(
          title: 'Xác thực tài khoản',
          onTap: () async {
            final res = await AppNavigator.push(Routes.verifyAccount);
            if (res == true) viewModel.getProfile();
          },
        ),
        const Divider(color: Palette.grey, height: 1),
        StreamBuilder<bool>(
            stream: appData.canPayment,
            builder: (context, canPayment) {
              if (canPayment.data == true) {
                return ChevronRightButton(
                  title: 'Gia hạn tài khoản',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.extendScreen,
                      arguments: {
                        'profileViewModel': viewModel,
                      },
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
        const Divider(color: Palette.grey, height: 1),
        ChevronRightButton(
          title: 'Điều khoản',
          onTap: () => launchUrlString(
            'https://alotoday.vn/terms-conditions',
            mode: LaunchMode.externalApplication,
          ),
        ),
        const Divider(color: Palette.grey, height: 1),
        ChevronRightButton(
          title: 'Xem đánh giá',
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              context: context,
              isScrollControlled: true,
              constraints: BoxConstraints(maxHeight: 0.8.sh),
              builder: (modalCtx) {
                return ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const ModalReviewShipper(),
                );
              },
            );
          },
        ),
        const Divider(color: Palette.grey, height: 1),
        ChevronRightButton(
          title: 'Hợp tác',
          onTap: () {
            Navigator.pushNamed(context, Routes.collaborateScreen);
          },
        ),
        const Divider(color: Palette.grey, height: 1),
        StreamBuilder<ContentShareModel?>(
          stream: appData.contentShare,
          builder: (context, snapshot) {
            String content = snapshot.data?.getAppContentSharing ?? '';
            String? linkSharing = snapshot.data?.getAppLinkSharing;
            if (linkSharing == null) {
              return const SizedBox();
            }
            return Column(
              children: [
                ChevronRightButton(
                  title: 'Chia sẻ',
                  onTap: () async {
                    try {
                      await Clipboard.setData(
                        ClipboardData(text: content),
                      );

                      ShareResult shareResult = await Share.shareWithResult(
                          linkSharing,
                          subject: content);
                      if (shareResult.status == ShareResultStatus.success &&
                          (shareResult.raw.toLowerCase().contains('facebook') ||
                              shareResult.raw.toLowerCase().contains('zalo') ||
                              shareResult.raw.toLowerCase().contains('zing'))) {
                        viewModel.shareLinkSuccess();
                      }
                    } catch (e) {
                      Logger.d('sharing', e);
                    }
                  },
                ),
                const Divider(color: Palette.grey, height: 1),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _feeView(BuildContext context, AsyncSnapshot<ProfileModel?> profile,
      ProfileViewModel viewModel) {
    return Padding(
      padding: AppTheme.mainPadding,
      child: Column(
        children: [
          ButtonPrice(
              title1: 'Phí Km đầu',
              value: profile.data?.item?.user?.phiKmDauTien ?? '0',
              editPrice: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: const PriceSetting(type: PriceType.phiKmDau),
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    viewModel.getProfile();
                  }
                });
              }),
          BoxConst.s8,
          ButtonPrice(
              title1: 'Phí gọi xe',
              title2: 'Trạng thái',
              value: profile.data?.item?.user?.phigoixe ?? '0',
              isOpen: profile.data?.item?.user?.isOnBatGoiXe ?? false,
              switchValue: (value) {
                viewModel.update(value ? '1' : '0',
                    profile.data?.item?.user?.batNhanHang ?? '0');
              },
              editPrice: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: const PriceSetting(type: PriceType.goiXe),
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    viewModel.getProfile();
                  }
                });
              }),
          BoxConst.s8,
          ButtonPrice(
              title1: 'Phí giao hàng',
              title2: 'Trạng thái',
              value: profile.data?.item?.user?.phigiaohang ?? '0',
              isOpen: profile.data?.item?.user?.isOnBatNhanDon ?? false,
              switchValue: (value) {
                viewModel.update(profile.data?.item?.user?.batGoiXe ?? '0',
                    value ? '1' : '0');
              },
              editPrice: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: const PriceSetting(type: PriceType.giaoHang),
                    );
                  },
                ).then((value) {
                  if (value == true) {
                    viewModel.getProfile();
                  }
                });
              }),
        ],
      ),
    );
  }
}

class ButtonPrice extends StatelessWidget {
  const ButtonPrice(
      {super.key,
      required this.title1,
      this.title2,
      this.editPrice,
      this.switchValue,
      this.value = '0',
      this.isOpen = false});

  final String title1;
  final String? title2;
  final String value;
  final Function()? editPrice;
  final Function(bool)? switchValue;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editPrice,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        constraints: BoxConstraints(
          minHeight: 70.w,
        ),
        decoration: AppTheme.boxDecoration.copyWith(
          color: Palette.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title1,
                  style: AppFont.t.s(13).w700.black,
                ),
                Text(
                  '${value.formatNumber}đ/km',
                  style: AppFont.t.s(13).w400.black,
                ),
              ],
            ),
            if (title2 != null) ...[
              BoxConst.s8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title2 ?? '',
                    style: AppFont.t.s(13).w700.black,
                  ),
                  ButtonSwitch(
                    onTap: switchValue,
                    initState: isOpen,
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class DialogConfirmDeleteAccount extends StatelessWidget {
  final String mess;
  final String? desc;
  final VoidCallback? action;
  final String confirmName;

  const DialogConfirmDeleteAccount({
    Key? key,
    required this.mess,
    required this.action,
    required this.confirmName,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mess,
              style: AppFont.t.s(18).w700,
              textAlign: TextAlign.center,
            ),
            if (desc != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  desc!,
                  style: AppFont.t,
                  textAlign: TextAlign.center,
                ),
              ),
            BoxConst.s16,
            Row(
              children: [
                const Expanded(
                  child: MyTextButton(
                    alignment: Alignment.centerLeft,
                    text: 'Quay lại',
                    action: AppNavigator.pop,
                  ),
                ),
                Expanded(
                  child: MyButton(
                    title: confirmName,
                    action: action,
                    borderRadius: 8,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
