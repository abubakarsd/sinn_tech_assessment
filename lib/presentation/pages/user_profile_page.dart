import 'package:flutter/material.dart';
import 'package:sinn_tech_assessment/core/constants/app_strings.dart';
import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';

class UserProfilePage extends StatelessWidget {
  final UserEntity user;
  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.userProfileTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(),
              const SizedBox(height: 24),
              _buildProfileCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.blueGrey,
      child: Text(
        user.name[0].toUpperCase(),
        style: const TextStyle(fontSize: 48, color: Colors.white),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              user.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user.username,
              style: theme.textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildInfoRow(Icons.email, user.email),
            _buildInfoRow(Icons.phone, user.phone),
            _buildInfoRow(Icons.public, user.website),
            const Divider(height: 32),
            _buildSectionTitle('Address'),
            _buildInfoText('${user.address.street}, ${user.address.suite}'),
            _buildInfoText('${user.address.city}, ${user.address.zipcode}'),
            const Divider(height: 32),
            _buildSectionTitle('Company'),
            _buildInfoText(user.company.name),
            _buildInfoText(user.company.catchPhrase),
            _buildInfoText(user.company.bs),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Text(text),
    );
  }
}