import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/shared/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TourGuideModal extends StatefulWidget {
  const TourGuideModal({super.key});

  @override
  State<TourGuideModal> createState() => _TourGuideModalState();
}

class _TourGuideModalState extends State<TourGuideModal> {
  final _pageController = PageController(viewportFraction: 1);
  final currentPageStreamController = BehaviorSubject<int>.seeded(0);

  List<BaseGuide> lstGuide = [
    BaseGuide(
      'assets/svgs/support/step-1-1.webp',
      'Tải và sử dụng mã QR để thực hiện chuyển khoản nhanh chóng và chính xác',
      'Cách 1- Bước 1',
    ),
    BaseGuide(
      'assets/svgs/support/step-2.webp',
      'Mở App ngân hàng của bạn và vào mục chuyển khoản ngân hàng',
      'Cách 1- Bước 2',
    ),
    BaseGuide(
      'assets/svgs/support/step-1-3.webp',
      'Chỉ cần quét mã QR là các thông tin thanh toán như số tài khoản, số tiền sẽ tự động hiện ra, nhanh chóng chính xác và tiện lợi.',
      'Cách 1 - Bước 3',
    ),
    BaseGuide(
      'assets/svgs/support/step-2-1.webp',
      'Sao chép nội dung chuyển khoản, số tiền và số tài khoản ',
      'Cách 2 - Bước 1',
    ),
    BaseGuide(
      'assets/svgs/support/step-2.webp',
      'Mở App ngân hàng của bạn và vào mục chuyển khoản ngân hàng',
      'Cách 2 - Bước 2',
    ),
    BaseGuide(
      'assets/svgs/support/step-2-3.webp',
      'Chọn chuyển khoản đến ngân hàng MB Bank. Dán hoặc nhập chính xác số tài khoản, số tiền và nội dung chuyển khoản để nạp tiền vào tài khoản Alotoday.',
      'Cách 2 - Bước 3',
    ),
  ];

  //indicator handler
  @override
  void initState() {
    //page controller is always listening
    //every pageview is scrolled sideways it will take the index page
    _pageController.addListener(() {
      currentPageStreamController.add(_pageController.page!.toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Palette.primaryF9D8D8,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                )
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Palette.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BoxConst.s8,
                  renderImagePage(),
                ],
              ),
            ),
            renderDot(),
            BoxConst.s16,
            renderDetailStep(),
            renderBottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget renderBottomButton(BuildContext context){
    return StreamBuilder<int>(
        initialData: 0,
        stream: currentPageStreamController,
        builder: (context, snapshot) {
          int currentPage = snapshot.data ?? 0;
          if (currentPage == lstGuide.length - 1) {
            return InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                decoration: BoxDecoration(
                  color: Palette.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Đã hiểu',
                  textAlign: TextAlign.center,
                  style: AppFont.t.s(16).w700.white,
                ),
              ),
            );
          }
          return InkWell(
            onTap: (){
              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Text(
              'Tiếp tục',
              textAlign: TextAlign.center,
              style: AppFont.t.s(16).w700.primary,
            ),
          );
        });
  }

  Widget renderImagePage() {
    return SizedBox(
      height: 500.h,
      child: PageView.builder(
          controller: _pageController,
          itemCount: lstGuide.length,
          itemBuilder: (context, position) {
            BaseGuide item = lstGuide[position];
            return Image.asset(
              item.url,
              fit: BoxFit.contain,
            );
          }),
    );
  }

  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          lstGuide.length,
          (index) {
            return StreamBuilder<int>(
                initialData: 0,
                stream: currentPageStreamController,
                builder: (context, snapshot) {
                  int currentPage = snapshot.data ?? 0;
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.centerLeft,
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index
                          ? Palette.primary
                          : Colors.black12,
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  Widget renderDetailStep() {
    return Column(
      children: [
        StreamBuilder<int>(
            initialData: 0,
            stream: currentPageStreamController,
            builder: (context, snapshot) {
              int currentPage = snapshot.data ?? 0;
              return Text(
                lstGuide[currentPage].title,
                style: AppFont.t.s(16).w700.black,
              );
            }),
        BoxConst.s16,
        Container(
          padding: AppTheme.mainPadding,
          height: 90.h,
          child: StreamBuilder<int>(
              initialData: 0,
              stream: currentPageStreamController,
              builder: (context, snapshot) {
                int currentPage = snapshot.data ?? 0;
                BaseGuide item = lstGuide[currentPage];
                return Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: AppFont.t.s(16).w400.black,
                );
              }),
        ),
      ],
    );
  }
}

class BaseGuide {
  String url;
  String description;
  String title;

  BaseGuide(this.url, this.description, this.title);
}
