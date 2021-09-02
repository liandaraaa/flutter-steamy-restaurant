import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/error_widget.dart';

class CustomerReviewsPage extends StatelessWidget {
  static const routName = '/customer_review_page';

  final List<CustomerReview> reviews;

  CustomerReviewsPage({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Review"),
        ),
        body: _buildPage(context));
  }

  Widget _buildPage(BuildContext context) {
    if (reviews.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return _buildReviewItem(context, review);
        },
      );
    } else {
      return ErrorWidgetPage(
        message: "Empty Data",
        image: 'images/ic_empty.png',
      );
    }
  }

  Widget _buildReviewItem(BuildContext context, CustomerReview review) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            review.review,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          children: [
            Text(
              review.name,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              review.date,
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
