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
                    isLoading: ref.watch(expeditionDetailNotifier).isLoading,
                    press: () => addExpedition(ref, context),
                    text: "Add Expedition"),

                Button(
                    isLoading: ref.watch(quizNotifier).isLoading,
                    press: () => addQuiz(ref, context),
                    text: "Add Quiz"),
                AppSizes.largeY,
              ],
            ),
          )),
    );
  }

  void addQuiz(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    Quiz q = Quiz(
        id: generateId(),
        expeditionId: "4ca94538-32d6-4a71-a0c7-5d5c3d1ba4d6",
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
              "Stars are giant balls of hot gas – mostly hydrogen, with some helium and small amounts of other elements.",
          questionType: QuestionType.trueFalse,
          options: ["True", "False"],
          correctAnswer: "True"),
      Question(
          id: generateId(),
          questionText: "Stars form in large clouds of gas and dust called ?",
          questionType: QuestionType.singleChoice,
          options: ["Molecular Cloud", "Dust Clouds", "Gas Clouds"],
          correctAnswer: "Molecular Clouds"),
      Question(
          id: generateId(),
          questionText:
              "Batches of stars that have recently formed from molecular clouds are often called stellar clusters.",
          questionType: QuestionType.trueFalse,
          options: ["True", "False"],
          correctAnswer: "True"),
      Question(
          id: generateId(),
          questionText:
              "Nuclear fission releases energy, which heats the star and prevents it from further collapsing under the force of gravity.",
          questionType: QuestionType.trueFalse,
          options: ["True", "False"],
          correctAnswer: "False"),
      Question(
          id: generateId(),
          questionText:
              "More massive stars must burn fuel at a higher rate to generate the energy that keeps them from collapsing under their own weight",
          questionType: QuestionType.trueFalse,
          options: ["True", "False"],
          correctAnswer: "True"),
      Question(
          id: generateId(),
          questionText:
              "A low-mass star’s atmosphere will keep expanding until it becomes a subgiant or giant star while fusion converts ? into carbon in the core",
          questionType: QuestionType.singleChoice,
          options: ["Helium", "Carbon", "Nitrogen", "Hydrogen"],
          correctAnswer: "Helium"),
      Question(
          id: generateId(),
          questionText:
              "Stars are giant balls of hot gas – mostly hydrogen, with some helium and small amounts of other elements.",
          questionType: QuestionType.trueFalse,
          options: ["True", "False"],
          correctAnswer: "True"),
      Question(
          id: generateId(),
          questionText:
              "The star’s iron core collapses until forces between the nuclei push the brakes, then it rebounds. The result is a huge explosion called a ?",
          questionType: QuestionType.singleChoice,
          options: ["Supernova", "nebula", "blackhole"],
          correctAnswer: "Supernova"),
    ];

    for (var i = 0; i < qList.length; i++) {
      ref.read(questionNotifier.notifier).addQuestion(
          adminId: ownerId,   
          question: qList[i],
          context: context,
          quizId: "fa4e54e4-0774-4626-b07a-b229309a99e8");
    }
  }

  void addExpedition(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    print(ownerId);
    // final storageRef = FirebaseStorage.instance.ref("/Kepler/");
    // final result = await ImageService().uploadImage(storageRef, "Kepler");
    String? image;
    // result.fold((left) => null, (right) {
    //   image = right;
    // Expedition expedition = Expedition(
    //     id: generateId(),
    //     name: "Stars",
    //     description:
    //         " Our Milky Way alone contains more than 100 billion, including our most well-studied star, the Sun.",
    //     image: image.toString());
    // ref
    //     .read(expeditionNotifier.notifier)
    //     .addExpedition(adminId: "", context: context, expedition: expedition);

    List<ExpeditionDetail> eds = [
      ExpeditionDetail(
        id: generateId(),
        text: "What is a star?",
        description:
            "Stars are giant balls of hot gas – mostly hydrogen, with some helium and small amounts of other elements. Every star has its own life cycle, ranging from a few million to trillions of years, and its properties change as it ages. Astronomers estimate that the universe could contain up to one septillion stars – that’s a one followed by 24 zeros. Our Milky Way alone contains more than 100 billion, including our most well-studied star, the Sun.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Birth",
        description:
            "Stars form in large clouds of gas and dust called molecular clouds. Molecular clouds range from 1,000 to 10 million times the mass of the Sun and can span as much as hundreds of light-years. Molecular clouds are cold which causes gas to clump, creating high-density pockets. Some of these clumps can collide with each other or collect more matter, strengthening their gravitational force as their mass grows. Eventually, gravity causes some of these clumps to collapse. When this happens, friction causes the material to heat up, which eventually leads to the development of a protostar – a baby star. ",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Life",
        description:
            "At first, most of the protostar’s energy comes from heat released by its initial collapse. After millions of years, immense pressures and temperatures in the star’s core squeeze the nuclei of hydrogen atoms together to form helium, a process called nuclear fusion. Nuclear fusion releases energy, which heats the star and prevents it from further collapsing under the force of gravity. Astronomers call stars that are stably undergoing nuclear fusion of hydrogen into helium main sequence stars. This is the longest phase of a star’s life. The star’s luminosity, size, and temperature will slowly change over millions or billions of years during this phase. Our Sun is roughly midway through its main sequence stage.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Life",
        description:
            "A star’s gas provides its fuel, and its mass determines how rapidly it runs through its supply, with lower-mass stars burning longer, dimmer, and cooler than very massive stars. More massive stars must burn fuel at a higher rate to generate the energy that keeps them from collapsing under their own weight. Some low-mass stars will shine for trillions of years – longer than the universe has currently existed – while some massive stars will live for only a few million years.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Death",
        description:
            "At the beginning of the end of a star’s life, its core runs out of hydrogen to convert into helium. The energy produced by fusion creates pressure inside the star that balances gravity’s tendency to pull matter together, so the core starts to collapse. But squeezing the core also increases its temperature and pressure, making the star slowly puff up. However, the details of the late stages of the star’s death depend strongly on its mass.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Death",
        description:
            "A low-mass star’s atmosphere will keep expanding until it becomes a subgiant or giant star while fusion converts helium into carbon in the core. (This will be the fate of our Sun, in several billion years.) Some giants become unstable and pulsate, periodically inflating and ejecting some of their atmospheres. Eventually, all the star’s outer layers blow away, creating an expanding cloud of dust and gas called a planetary nebula.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Death",
        description:
            "A high-mass star goes further. Fusion converts carbon into heavier elements like oxygen, neon, and magnesium, which will become future fuel for the core. For the largest stars, this chain continues until silicon fuses into iron. These processes produce energy that keeps the core from collapsing, but each new fuel buys it less and less time. The whole process takes just a few million years. By the time silicon fuses into iron, the star runs out of fuel in a matter of days. The next step would be fusing iron into some heavier element but doing so requires energy instead of releasing it.",
      ),
      ExpeditionDetail(
        id: generateId(),
        text: "Death",
        description:
            "The star’s iron core collapses until forces between the nuclei push the brakes, then it rebounds. This change creates a shock wave that travels outward through the star. The result is a huge explosion called a supernova. The core survives as an incredibly dense remnant, either a neutron star or a black hole.",
      ),
    ];

    for (var i = 0; i < eds.length; i++) {
      ref.read(expeditionDetailNotifier.notifier).addExpeditionDetail(
            expeditionId: "4ca94538-32d6-4a71-a0c7-5d5c3d1ba4d6",
            expeditionDetail: eds[i],
            adminId: ownerId.toString(),
            context: context,
          );
    }

    // });

    clearControllers();
  }
}
