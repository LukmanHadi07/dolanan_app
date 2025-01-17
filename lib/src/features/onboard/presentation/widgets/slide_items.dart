import 'package:dulinan/src/features/onboard/presentation/widgets/slide_data.dart';
import 'package:flutter/material.dart';

class SlideItems extends StatelessWidget {
  final int index;
  const SlideItems({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            image: DecorationImage(
              image: AssetImage(
                slideList[index].image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          slideList[index].title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.normal, color: Colors.black38),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
