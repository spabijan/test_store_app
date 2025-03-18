import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({required this.submitReviewCallback, super.key});

  final void Function(double, String) submitReviewCallback;

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final _reviewController = TextEditingController();
  double rating = 4;
  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Leave a review'),
      actions: [
        TextButton(
            onPressed: () {
              widget.submitReviewCallback(rating, _reviewController.text);
              Navigator.pop(context);
            },
            child: const Text('Submit'))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _reviewController,
            decoration: const InputDecoration(labelText: 'Your review'),
          ),
          RatingBar(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            onRatingChanged: (newRating) => setState(() {
              rating = newRating;
            }),
            initialRating: 4,
            maxRating: 5,
          )
        ],
      ),
    );
  }
}
