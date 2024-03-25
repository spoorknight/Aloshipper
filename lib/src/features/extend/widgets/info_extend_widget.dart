part of '../extend_screen.dart';

class InfoExtendWidget extends StatelessWidget {
  const InfoExtendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModelPro = context.watch<ProfileViewModel>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
      decoration: AppTheme.boxDecoration.copyWith(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 6.sp, horizontal: 10.sp),
                decoration: BoxDecoration(
                  color: Palette.nuatral20,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child:
                // StreamBuilder<ProfileModel?>(
                //   stream: appData.profile,
                //   builder: (context, profile) {
                //     return Text(
                //       // profile.data?.plan?.planTitle ?? '',
                //       viewModelPro.listServiceModel?.currentPackageOfUser?.title ?? "",
                //       style: AppFont.t.s(13).w500.black,
                //     );
                //   },
                // ),
                Text(
                  // profile.data?.plan?.planTitle ?? '',
                  viewModelPro.listServiceModel?.currentPackageOfUser?.title ?? "",
                  style: AppFont.t.s(13).w500.black,
                )
              ),
              BoxConst.s4,
              StreamBuilder<ProfileModel?>(
                  stream: appData.profile,
                  builder: (context, profile) {
                    return Text.rich(
                      TextSpan(
                          text: 'Hạn sử dụng còn lại: ',
                          style: AppFont.t.s(13).w400.black,
                          children: [
                            TextSpan(
                              text:
                                  '${profile.data?.plan?.numberOfDays ?? 0} ngày',
                              style: AppFont.t.s(13).w500.black,
                            ),
                          ]),
                    );
                  }),
            ],
          ),
          Column(
            children: [
              Consumer<ProfileViewModel>(builder: (context, viewModel, _) {
                return StreamBuilder<ProfileModel?>(
                    stream: appData.profile,
                    builder: (context, profile) {
                      return BaseToggleButton(
                        currentValue:
                            profile.data?.item?.user?.giaHanTuDong == '1',
                        onChange: viewModel.autoGiaHan,
                      );
                    });
              }),
              Text(
                'Tự động gia hạn',
                style: AppFont.t.s(8).w500.nuatral50,
              )
            ],
          )
        ],
      ),
    );
  }
}
