class ApiPath {
  //* Base URL
  static const String _apiVersion = 'apiv3';
  static const String baseUrl = 'https://alotoday.vn/$_apiVersion/';
  static const String baseUrlStaging =
      'https://stagingtest.alotoday.vn/$_apiVersion/';

  //* Authen
  static const String loginMember = 'LoginShipper';
  static const String requestOpenShipper = 'RequestOpenShipper';
  static const String fotgetPasswordMember = 'fotgetPasswordMember';

  //* Tài khoản
  static const String getProfileShopApi = 'get_ProfileShopApi';
  static const String getUserInfoActive = 'getAvtivityShipperInfo';
  static const String updateProfileShipper = 'UpdateProfileShipper';
  static const String updateTaiKhoanShipper = 'UpdateTaiKhoanShipper';
  static const String getInfoTaiKhoanHopTac = 'getInfoTaiKhoanHopTac';
  static const String getListHoaHongSanPham = 'getListHoaHongSanPham';
  static const String getListSanPhamDangChiecKhau =
      'getListSanPhamDangChiecKhau';
  static const String getListHoaHongMoShopApi = 'getListHoaHongMoShopApi';
  static const String naptien = 'naptien_vnpay_alotoday';
  static const String rutTienChuyenKhoanApi = 'RutTienChuyenKhoanApi';
  static const String rutTienMatDaiLyAPI = 'RutTienMatDaiLyAPI';
  static const String updateFeeShipper = 'UpdateFeeShipper';
  static const String getListReviewShipper = 'getListReviewShipper';
  static const String getGoiDichVuShipper = 'getGoiDichVuShipper';
  static const String autoGiaHan = 'AutoGiaHan';
  static const String thanhToanGoiDichVu = 'ThanhToanGoiDichVu';
  static const String updateLatLng = 'updateLatLng';
  static const String huyTaiKhoan = 'HuyTaiKhoan';
  static const String updateStatusOrderShipper = 'updateStatusOrderShipper';
  static const String getUserBanksInfo = 'user-bank/info';
  static const String getRideHailingSetting = 'ride-hailing/get-shipper-ride-hailing-settings';
  static const String updateRideHailingSetting = 'ride-hailing/insert-or-update-shipper-config';
  static const String getBanks = 'getBanks';
  static const String createOrUpdate = 'user-bank/create-or-update';

  //* Địa chỉ
  static const String getTinhTPList = 'getTinhTPList';
  static const String getQuanHuyenList = 'getQuanHuyenList';
  static const String getPhuongXaList = 'getPhuongXaList';

  //* Thông báo
  static const String getListThongBao = 'getListThongBao';
  static const String getListThongBaoV2 = 'getListThongBaoV2';

  //* Đơn hàng
  static const String getDetailOrderShipperById = 'getDetailOrderById';
  // static const String getDetailOrderShipperById = 'getDetailOrderShipperById';
  static const String getCancelReasons = 'getCancelReasons';
  static const String updateStatusOrderByShipper = 'UpdateStatusOrderByShipperNew';
  static const String shopOnlineActive = 'ShopOnlineActive';
  static const String getListCompletedOrdersShipper = 'getListCompletedOrdersShipper';
  static const String getOrders = 'getOrders';
  static const String cancelOrder = 'ShipperHuyDonHang';
  static const String ShipperHuyDonHangNew = 'ShipperHuyDonHangNew';

  //* Ẩn hiện thanh toán
  static const String checkCanPayment =
      'https://alotoday.vn/apiv3/aloshipperApp';
  static const String getListUserCanNotViewPayment = 'https://alotoday.vn/apiv3/getUsersCannotViewPMPage';


  //* nô dung chia sẻ
  static const String getShareSettings =
      'https://alotoday.vn/apiv3/getShareSettings';

  //* event
  static const String giftCreate = 'gift/create';
  static const String adCreate = 'ad/create';
  static const String giftPointsInfo = 'gift/pointsInfo';
  static const String giftGetPointsExchangeHistories = 'gift/getPointsExchangeHistories';
  static const String exchangePointsToMoneyOrDay = 'exchangePointsToMoneyOrDay';
  static const String giftGetDailyMissions = 'getDailyMissions';
  static const String giftGetMissionHistories = 'getMissionHistories';
  static const String getReferFriends = 'getReferFriends';
  static const String addGiftForReferFriendMission = 'gift/addGiftForReferFriendMission';
  static const String getStoresPurchasedSharePackage = 'getStoresPurchasedSharePackage';
  static const String checkValidAdViews = 'checkValidAdViews';
  static const String exchangePointsToGift = 'exchangePointsToGift';
  static const String getAlotodayVouchers = 'getAlotodayVouchers';
  static const String getBannerAdsAdmobKeys = 'getBannerAdsAdmobKeys';


  ///News
  static const String getNotiNews = 'getNews';
  static const String readNotiNews = 'readNotification';
  static const String countUnReadNotiNews = 'countUnreadNotification';
  static const String getDetailNotiNew = 'detailNotification';


}
