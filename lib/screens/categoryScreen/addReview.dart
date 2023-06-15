import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/services/remote_services.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class AddReview extends StatefulWidget {
  final String id;
  const AddReview({Key? key, required this.id}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _contentcontroller = TextEditingController();
  final TextEditingController titlecontroller = TextEditingController();
  double rating = 0;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    titlecontroller.dispose();
    _contentcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextField(
        controller: titlecontroller,
        maxLines: 2,
        decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Enter the title"),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _contentcontroller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: 'Enter your feedback here',
            filled: true,
          ),
          maxLines: 5,
          maxLength: 4096,
          textInputAction: TextInputAction.done,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
      actions: [
        Column(
          children: [
            SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (v) {
                  rating = v;
                  print("tags.rating ${rating}");
                  setState(() {});
                },
                starCount: 5,
                rating: rating,
                size: 40.0,
                color: Colors.orange,
                borderColor: Colors.orange,
                spacing: 0.0),
            Row(
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: 150,
                ),
                TextButton(
                    child: const Text('Send'),
                    onPressed: () async {
                      final now = DateTime.now();
                      String formatter = DateFormat('yMd').format(now);
                      Services().addReview(
                          titlecontroller.text,
                          _contentcontroller.text,
                          rating,
                          widget.id,
                          formatter);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Review Added")));
                      Navigator.pop(context);
                  })
              ],
            )
          ],
        ),
      ],
    );
  }
}
