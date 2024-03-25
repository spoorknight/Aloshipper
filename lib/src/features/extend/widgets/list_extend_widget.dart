part of '../extend_screen.dart';

class ListExtendWidget extends StatelessWidget {
  const ListExtendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, viewModel, _) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.listService.length,
        separatorBuilder: (context, index) => BoxConst.s12,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        itemBuilder: (context, index) {
          Packages item = viewModel.listService[index];
          return ItemExpand(
            title: item.getTitle,
            description: item.getListPlan,
            price: item.getPrice,
            isSelected: viewModel.selectedPlanId == item.id,
            onTapBuy: () {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return DialogConfirm(
                      mess: 'Bạn có chắc muốn mua gói này không?',
                      action: (){
                        viewModel.thanhToanGoiDichVu(item.id);
                        AppNavigator.pop();
                      },
                      titleButton: "Chắc chắn",
                      cancelButton: "Huỷ",
                    );
                  });
            },
          );
        },
      );
    });
  }
}
