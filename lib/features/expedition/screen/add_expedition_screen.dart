import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenith/app/themes/app_paddings.dart';
import 'package:zenith/app/themes/app_text_field_themes.dart';
import 'package:zenith/core/extensions/routes_extenstion.dart';
import 'package:zenith/core/extensions/sizes_extensions.dart';
import 'package:zenith/core/services/image_picker_service.dart';
import 'package:zenith/core/utils/gen_random_ids.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/auth/screens/widgets/app_bar_white.dart';
import 'package:zenith/features/auth/screens/widgets/button.dart';
import 'package:zenith/features/auth/screens/widgets/custom_text_field.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';
import 'package:zenith/features/expedition/providers/expedition_detail_notifier.dart';
import 'package:zenith/features/expedition/providers/expedtion_notifier.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/model/quiz.dart';
import 'package:zenith/features/quiz/providers/question_notifier.dart';
import 'package:zenith/features/quiz/providers/quiz_notifier.dart';

enum addHouseEnum { Rental, Seller }

class AddExpeditionScreen extends ConsumerStatefulWidget {
  const AddExpeditionScreen({super.key});

  @override
  ConsumerState<AddExpeditionScreen> createState() =>
      _AddRentalHomeScreenState();
}

class _AddRentalHomeScreenState extends ConsumerState<AddExpeditionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int expeditonsContent = 1;

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
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
              text: "Add Expedition")),
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
                    controller: nameController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "House Name")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: descriptionController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(
                            label: "Address")),
                AppSizes.normalY,
                // ...List.generate(
                //   expeditonsContent,
                //   (index) => GestureDetector(
                //     onTap: () => setState(() {
                //       expeditonsContent++;
                //     }),
                //     child: const ExpansionTile(
                //       title: Text('Add Info'),
                //       subtitle: Text('Subtitle of the tile'),
                //       leading: Icon(Icons.info),
                //       trailing: Icon(Icons.expand_more),
                //       children: <Widget>[
                //         ListTile(
                //           title: Text('Item 1'),
                //           leading: Icon(Icons.arrow_right),
                //         ),
                //         ListTile(
                //           title: Text('Item 2'),
                //           leading: Icon(Icons.arrow_right),
                //         ),
                //         ListTile(
                //           title: Text('Item 3'),
                //           leading: Icon(Icons.arrow_right),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Button(
                    isLoading: ref.watch(expeditionNotifier).isLoading,
                    press: () => addExpedition(ref, context),
                    text: "Add Expedition"),
                AppSizes.largeY,
                Button(
                    isLoading: ref.watch(quizNotifier).isLoading,
                    press: () => addQuiz(ref, context),
                    text: "Add Quiz"),
                AppSizes.largeY,
                Button(
                    isLoading: ref.watch(questionNotifier).isLoading,
                    press: () => addQuestions(ref, context),
                    text: "Add Questions"),
                AppSizes.largeY,
                Button(
                    isLoading: ref.watch(expeditionDetailNotifier).isLoading,
                    press: () => addEDS(ref, context),
                    text: "Add EDS"),
                AppSizes.largeY,
              ],
            ),
          )),
    );
  }

  void addQuiz(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    Quiz q = Quiz(
        quizName: "Kepler 22-b",
        id: generateId(),
        expeditionId: "53e3ffa4-a583-45cc-881e-9ddd5d684f17",
        correctAnswers: [],
        passingCriteria: 5);

    ref.read(quizNotifier.notifier).addQuiz(
          adminId: ownerId,
          quiz: q,
          context: context,
        );
  }

  void addQuestions(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    print(ownerId);

    List<Question> qList = [
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b is located approximately how many light-years away from Earth?",
        questionType: QuestionType.singleChoice,
        options: ["500", "600", "700", "800"],
        correctAnswer: "600",
      ),
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b orbits around a star that is classified as a G-type star, much like our Sun.",
        questionType: QuestionType.trueFalse,
        options: ["True", "False"],
        correctAnswer: "True",
      ),
      Question(
        id: generateId(),
        questionText:
            "The size of Kepler-22b is approximately how many times the size of Earth?",
        questionType: QuestionType.singleChoice,
        options: ["2.4", "3.0", "1.5", "4.0"],
        correctAnswer: "2.4",
      ),
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b orbits its star in approximately 290 Earth days.",
        questionType: QuestionType.trueFalse,
        options: ["True", "False"],
        correctAnswer: "True",
      ),
      Question(
        id: generateId(),
        questionText:
            "Which term describes the region where Kepler-22b is located, where conditions may allow liquid water to exist?",
        questionType: QuestionType.singleChoice,
        options: [
          "Goldilocks Zone",
          "Oort Cloud",
          "Kuiper Belt",
          "Asteroid Belt"
        ],
        correctAnswer: "Goldilocks Zone",
      ),
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b was the first planet discovered in the habitable zone of a Sun-like star.",
        questionType: QuestionType.trueFalse,
        options: ["True", "False"],
        correctAnswer: "True",
      ),
      Question(
        id: generateId(),
        questionText: "What type of telescope was used to discover Kepler-22b?",
        questionType: QuestionType.singleChoice,
        options: [
          "James Webb Space Telescope",
          "Hubble Space Telescope",
          "Kepler Space Telescope",
          "Spitzer Space Telescope"
        ],
        correctAnswer: "Kepler Space Telescope",
      ),
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b's exact composition is currently unknown, but it may have a thick atmosphere similar to which planet?",
        questionType: QuestionType.singleChoice,
        options: ["Earth", "Neptune", "Mars", "Jupiter"],
        correctAnswer: "Neptune",
      ),
      Question(
        id: generateId(),
        questionText:
            "Kepler-22b completes one orbit around its star in about how many Earth days?",
        questionType: QuestionType.singleChoice,
        options: ["365", "290", "180", "100"],
        correctAnswer: "290",
      ),
    ];

    for (var i = 0; i < qList.length; i++) {
      ref.read(questionNotifier.notifier).addQuestion(
          adminId: ownerId,
          question: qList[i],
          context: context,
          quizId: "e9ba7e4c-956a-414f-8130-a836053f093f");
    }
  }

  void addExpedition(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    print(ownerId);

    Expedition expedition = Expedition(
        id: generateId(),
        name: "Kepler 22-b",
        description:
            " Kepler-22b (also known by its Kepler Object of Interest designation KOI-087.01) is an exoplanet orbiting within the habitable zone of the Sun-like star Kepler-22.",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk0.jpeg?alt=media&token=c4bbef92-d157-40dd-a60e-cbbf9e3bab85");
    ref
        .read(expeditionNotifier.notifier)
        .addExpedition(adminId: "", context: context, expedition: expedition);

    // });
  }

  void addEDS(WidgetRef ref, BuildContext context) {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    print(ownerId);

    List<ExpeditionDetail> eds = [
      ExpeditionDetail(
        id: generateId(),
        order: 1,
        text: "Overview",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk0.jpeg?alt=media&token=c4bbef92-d157-40dd-a60e-cbbf9e3bab85",
        description:
            "Kepler-22b is an exoplanet located about 600 light-years away from Earth, in the constellation Cygnus. It was discovered by NASA's Kepler Space Telescope and was the first planet found within the habitable zone of a star similar to our Sun. The planet is roughly 2.4 times the size of Earth, making it a super-Earth, and it orbits its star every 290 days.",
      ),
      ExpeditionDetail(
        id: generateId(),
        order: 2,
        text: "Host Star",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk4.webp?alt=media&token=bd486a98-c714-4b51-b535-9b37a1ff9a14",
        description:
            "Kepler-22b orbits around the star Kepler-22, which is a G-type star, much like our Sun. It has a surface temperature of about 5,518 K and is slightly smaller and cooler than the Sun. The distance between Kepler-22b and its host star places it in the habitable zone, where liquid water could potentially exist under the right atmospheric conditions.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Habitability",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk0.jpeg?alt=media&token=c4bbef92-d157-40dd-a60e-cbbf9e3bab85",
        order: 3,
        description:
            "Kepler-22b resides in the 'habitable zone,' sometimes called the 'Goldilocks zone,' where conditions are just right for liquid water to exist—neither too hot nor too cold. However, whether Kepler-22b has liquid water or a suitable atmosphere for life remains unknown. Its size suggests it could have a thick atmosphere, potentially making it more like Neptune than Earth.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Planetary Composition",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk6.jpeg?alt=media&token=bb1d0a62-fddb-466b-bb50-072748519e92",
        order: 4,
        description:
            "The exact composition of Kepler-22b is currently unknown. Given its size, it could be a rocky planet with a thick atmosphere, or it might be composed largely of gas or ice. If it has a dense atmosphere, conditions on its surface could differ drastically from Earth-like planets, potentially affecting its habitability.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Discovery",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk2.jpeg?alt=media&token=9cb794e0-133d-4f9a-bbce-a89a7528d99d",
        order: 5,
        description:
            "Kepler-22b was discovered on December 5, 2011, using data from the Kepler Space Telescope. It was the first planet discovered in the habitable zone of a Sun-like star, marking a major milestone in the search for Earth-like planets in other star systems.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Orbital Period",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk7.jpeg?alt=media&token=32891648-d8ba-4940-b298-8d937e8fcd4e",
        order: 6,
        description:
            "Kepler-22b completes one orbit around its star in approximately 290 Earth days, which is slightly shorter than Earth's orbit around the Sun. Its distance from its star is about 15% less than the distance between Earth and the Sun.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Research Significance",
        image:
            "https://firebasestorage.googleapis.com/v0/b/zenith-08.appspot.com/o/expeditions%2Fkepler22b%2Fk1.jpeg?alt=media&token=e1814b32-0cef-401a-9ecf-7650d59d191f",
        order: 7,
        description:
            "Kepler-22b's discovery plays an important role in the ongoing search for habitable planets beyond our solar system. Its location in the habitable zone, coupled with its size, makes it a prime candidate for further study, especially with future telescopes aimed at exploring exoplanetary atmospheres.",
      ),
    ];

    for (var i = 0; i < eds.length; i++) {
      ref.read(expeditionDetailNotifier.notifier).addExpeditionDetail(
            expeditionId: "53e3ffa4-a583-45cc-881e-9ddd5d684f17",
            expeditionDetail: eds[i],
            adminId: ownerId.toString(),
            context: context,
          );
    }
  }
}
