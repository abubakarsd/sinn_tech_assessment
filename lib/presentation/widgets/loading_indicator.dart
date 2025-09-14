import 'package:flutter/material.dart';
import 'package:sinn_tech_assessment/core/constants/app_strings.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(AppStrings.loading),
        ],
      ),
    );
  }
}
