import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shopping_app/Controllers/productController.dart';
import 'package:shopping_app/Model/productModel.dart';
import 'package:shopping_app/screens/categoryScreen/addReview.dart';
import 'package:shopping_app/services/remote_services.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../consts/colors.dart';
import '../../widgets/defaultAppBarwidget.dart';
import '../../widgets/defaultbackbuttonWidget.dart';
import '../../widgets/reviewUIwidget.dart';

class Reviews extends StatefulWidget {
  ProductModel productModel;
  Reviews({Key? key, required this.productModel}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  ProductController productController = ProductController();
  bool isMore = false;
  double avg = 0;
  double average = 0;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];

  void averageRating() {
    for (int i = 0; i < widget.productModel.reviews.length; i++) {
      average += widget.productModel.reviews[i].reviewRating!;
      print("average ${average}");
    }
    avg = average / widget.productModel.reviews.length;
  }

  @override
  void initState() {
    averageRating();
    print("tags.InReview");
    productController.fetchReviewsById(widget.productModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: "Reviews",
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Container(
            color: kAccentColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: avg.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 48.0),
                          ),
                          const TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      starCount: 5,
                      rating: 4.5,
                      size: 28.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "${widget.productModel.reviews.length} Reviews",
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 220.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 8.0),
                          Expanded(
                            flex: 0,
                            child: LinearPercentIndicator(
                              lineHeight: 6.0,
                              // linearStrokeCap: LinearStrokeCap.roundAll,
                              width: MediaQuery.of(context).size.width / 2.8,
                              animation: true,
                              animationDuration: 2500,
                              percent: ratings[index],
                              progressColor: Colors.orange,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            initialData: productController.reviews,
            future: Services().getAllReviewsById(widget.productModel.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  itemCount: widget.productModel.reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewUI(
                      name: widget.productModel.reviews[index].reviewTitle,
                      date: widget.productModel.reviews[index].reviewDate,
                      comment: widget.productModel.reviews[index].reviewContent,
                      rating: widget.productModel.reviews[index].reviewRating!,
                      onPressed: () => print("More Action $index"),
                      onTap: () => setState(() {
                        isMore = !isMore;
                      }),
                      isLess: isMore,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2.0,
                      color: kAccentColor,
                    );
                  },
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    print("tags.id ${widget.productModel.name}");
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AddReview(id: widget.productModel.id));
                  },
                  child: const Text('Add Review')))
        ],
      ),
    );
  }
}
