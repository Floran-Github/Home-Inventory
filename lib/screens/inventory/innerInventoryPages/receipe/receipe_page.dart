import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class ReceipePage extends StatefulWidget {
  const ReceipePage({super.key});

  @override
  State<ReceipePage> createState() => _ReceipePageState();
}

class _ReceipePageState extends State<ReceipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const NestedAppBar(title: "Receipe Page"),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () {},
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              color: AppColors.sharedInv,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: const Text(
                "Let's Cook it",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/food.png")),
              title("Receipe Name"),
              const Text(
                "Burger",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title("Time required"),
                      iconText(Icons.schedule, "45 Min")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title("Serving for"),
                      iconText(Icons.people, "1")
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              title("Ingredients"),
              const SizedBox(
                height: 10,
              ),
              listText("1 pound ground beef (80/20 lean to fat ratio)"),
              listText("1 teaspoon salt"),
              listText("1/2 teaspoon black pepper"),
              listText("4 hamburger buns"),
              listText("4 leaves of lettuce"),
              listText("1 medium tomato, sliced"),
              listText("1/2 medium onion, sliced"),
              listText("4 pickle slices (optional)"),
              listText("Condiments of your choice (ketchup, mustard, mayo)"),
              const SizedBox(
                height: 10,
              ),
              title("Instructions"),
              const SizedBox(
                height: 10,
              ),
              ollistText("1",
                  "In a mixing bowl, add Aashirvaad Atta, salt, sugar, active dry yeast, warm water, and oil. Mix well."),
              ollistText("2",
                  "Add boiled and mashed potatoes and cumin seeds. Mix well."),
              ollistText(
                  "3", "Knead the dough until it becomes soft and elastic."),
              ollistText(
                  "4", "Cover and let it rest for 1 hour in a warm place."),
              ollistText("5", "Preheat the oven at 180°C for 10 minutes."),
              ollistText("6", "Grease a bread pan with oil."),
              ollistText("7", "Shape the dough and place it in the bread pan."),
              ollistText("8",
                  "Bake for 25-30 minutes or until the bread turns golden brown."),
              ollistText("9", "Let it cool down and slice into pieces."),
              ollistText("10", "Serve with butter or jam."),
              const SizedBox(
                height: 10,
              ),
              title("Nutrition value per serving (1 slice): "),
              const SizedBox(
                height: 10,
              ),
              listText("Calories: 120 kcal "),
              listText("Carbohydrates: 17 g"),
              listText("Protein: 3 g "),
              listText("Fat: 4 g "),
              listText("Fiber: 2 g"),
            ],
          ),
        ),
      ),
    );
  }

  Padding listText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }

  Padding ollistText(String index, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }

  Row iconText(IconData icondata, String text) {
    return Row(
      children: [
        Icon(
          icondata,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Text title(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: AppColors.yellow, fontWeight: FontWeight.w500, fontSize: 18),
    );
  }
}
