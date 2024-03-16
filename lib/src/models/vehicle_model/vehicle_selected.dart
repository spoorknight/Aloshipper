import 'package:app_shipper/src/models/vehicle_model/vehicle_model_by_brand.dart';
import 'package:app_shipper/src/models/vehicle_model/vehilce_brand_model.dart';

class VehicleSelected {
  VehicleBrand? vehicleBrand;
  VehicleModel? vehicleModel;
  String? vehicleYear;
  String? fullVehicle;

  VehicleSelected({this.vehicleBrand, this.vehicleModel, this.vehicleYear,this.fullVehicle});
}