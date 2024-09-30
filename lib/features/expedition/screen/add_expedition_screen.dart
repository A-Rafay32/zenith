import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenith/app/constants/app_images.dart';
import 'package:zenith/app/constants/firebase_constants.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/app/themes/app_text_field_themes.dart';
import 'package:zenith/core/enums/house_status.dart';
import 'package:zenith/core/enums/house_type.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/services/image_picker_service.dart';
import 'package:zenith/core/utils/gen_random_ids.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';
import 'package:zenith/features/auth/screens/widgets/custom_field_drop_down.dart';
import 'package:zenith/features/auth/screens/widgets/custom_text_field.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/providers/expedition_detail_notifier.dart';
import 'package:zenith/features/expedition/providers/expedtion_notifier.dart';
import 'package:zenith/features/home/providers/home_providers.dart';
// import 'package:zenith/features/seller/provider/seller_notifier.dart';

enum addHouseEnum { Rental, Seller }

class AddExpeditionScreen extends ConsumerStatefulWidget {
  const AddExpeditionScreen({super.key});

  @override
  ConsumerState<AddExpeditionScreen> createState() =>
      _AddRentalHomeScreenState();
}

class _AddRentalHomeScreenState extends ConsumerState<AddExpeditionScreen> {
  TextEditingController houseNameController = TextEditingController();
  TextEditingController bathroomQtyController = TextEditingController();
  TextEditingController roomQtyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController mortgageCostController = TextEditingController();
  TextEditingController mortgageInterestController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedValue = addHouseEnum.Seller.name;

  void clearControllers() {
    houseNameController.clear();
    bathroomQtyController.clear();
    roomQtyController.clear();
    addressController.clear();
    sizeController.clear();
    rentController.clear();
    descriptionController.clear();
    mortgageCostController.clear();
    purchasePriceController.clear();
    mortgageInterestController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBar(
              onPressed: () {
                context.pop();
              },
              text: "Add ${selectedValue.toString()} Home")),
      body: SizedBox(
          height: context.h,
          width: context.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CustomFieldDropDown(
                //     hint: "Rental",
                //     selectedValue: selectedValue,
                //     onChanged: (String? value) {
                //       selectedValue = value!;
                //       setState(() {});
                //     },
                //     dropdownItems:
                //         addHouseEnum.values.map((e) => e.toString()).toList()),
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: houseNameController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "House Name")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: addressController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "Address")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: bathroomQtyController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "No. of Bathrooms")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: sizeController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "Size in feet")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: roomQtyController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "No. of Rooms")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: descriptionController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "Description")),
                AppSizes.normalY,
                selectedValue == addHouseEnum.Rental.name
                    ? Column(
                        children: [
                          CustomTextField(
                              validator: (value) {
                                return value == null
                                    ? "Field can't be empty"
                                    : null;
                              },
                              controller: rentController,
                              inputDecoration: AppTextFieldDecorations
                                  .genericInputDecoration(
                                      label: "\$ Rent Per Month ")),
                          AppSizes.normalY,
                        ],
                      )
                    : Column(children: [
                        CustomTextField(
                            validator: (value) {
                              return value == null
                                  ? "Field can't be empty"
                                  : null;
                            },
                            controller: purchasePriceController,
                            inputDecoration:
                                AppTextFieldDecorations.genericInputDecoration(
                                    label: "\$ Purchase Price ")),
                        AppSizes.normalY,
                        CustomTextField(
                            validator: (value) {
                              return value == null
                                  ? "Field can't be empty"
                                  : null;
                            },
                            controller: mortgageCostController,
                            inputDecoration:
                                AppTextFieldDecorations.genericInputDecoration(
                                    label: "\$ Mortgage/month ")),
                        AppSizes.normalY,
                        CustomTextField(
                            validator: (value) {
                              return value == null
                                  ? "Field can't be empty"
                                  : null;
                            },
                            controller: mortgageInterestController,
                            inputDecoration:
                                AppTextFieldDecorations.genericInputDecoration(
                                    label: "\$ Interest/year ")),
                        AppSizes.normalY,
                      ]),
                AppSizes.normalY,
                Button(
                    isLoading: ref.watch(expeditionDetailNotifier).isLoading,
                    press: () => addExpedition(ref, context),
                    text: "Add Expedition"),
                AppSizes.largeY,
              ],
            ),
          )),
    );
  }

  void addExpedition(WidgetRef ref, BuildContext context) async {
    // String? ownerId = ref.read(currentUserProvider)?.uid;
    // print(ownerId);
    // final result = await ImageService().pickImage(source: ImageSource.gallery);
    // String? image;
    // result.fold((left) => null, (right) {
    // image = right;
    Expedition expedition = Expedition(
        id: generateId(),
        name: "Kepler 452b",
        description:
            "Kepler-452b (sometimes quoted to be an Earth 2.0 or Earth's Cousin[4][5] based on its characteristics; also known by its Kepler object of interest designation KOI-7016.01) is a super-Earth exoplanet orbiting within the inner edge of the habitable zone of the sun-like star Kepler-452 and is the only planet in the system discovered by the Kepler space telescope. It is located about 1,400 light-years (430 pc)[6] from Earth in the constellation of Cygnus.",
        image: "image.toString()");
    ref
        .read(expeditionNotifier.notifier)
        .addExpedition(adminId: "", context: context, expedition: expedition);
    // });

    clearControllers();
  }
}
