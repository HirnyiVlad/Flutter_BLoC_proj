import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Function to display an alert dialog for filtering options
void showAlertDialog(
    BuildContext context,
    void Function() onClickCompleteness,
    void Function() onClickCategory,
    ) {
  // Show a dialog to the user
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        // Content of the dialog
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
            children: [
              // Button for filtering by completeness
              TextButton(
                onPressed:() {
                  // Call the provided function for completeness filter
                  onClickCompleteness();
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: const Text('filter by completeness'),
              ),
              // Button for filtering by category
              TextButton(
                onPressed:(){
                  // Call the provided function for category filter
                  onClickCategory();
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: const Text('filter by category'),
              ),
            ],
          ),
        ),
      );
    },
  );
}