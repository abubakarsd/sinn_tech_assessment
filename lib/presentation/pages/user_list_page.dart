import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinn_tech_assessment/core/constants/app_strings.dart';
import 'package:sinn_tech_assessment/presentation/bloc/user_bloc.dart';
import 'package:sinn_tech_assessment/presentation/bloc/user_event.dart';
import 'package:sinn_tech_assessment/presentation/bloc/user_state.dart';
import 'package:sinn_tech_assessment/presentation/pages/user_profile_page.dart';
import 'package:sinn_tech_assessment/presentation/widgets/error_view.dart';
import 'package:sinn_tech_assessment/presentation/widgets/loading_indicator.dart';
import 'package:sinn_tech_assessment/presentation/widgets/no_data_view.dart';
import 'package:sinn_tech_assessment/presentation/widgets/user_card.dart';
import 'package:sinn_tech_assessment/presentation/bloc/theme_bloc.dart';
import 'package:sinn_tech_assessment/presentation/bloc/theme_event.dart';
import 'package:sinn_tech_assessment/presentation/bloc/theme_state.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // this section add event to fetch users when the page is initialized
    context.read<UserBloc>().add(FetchUsers());

    // this is the Setup of scrolling listener for lazy loading
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.9) {
      // Trigger lazy loading when the user is near the bottom
      context.read<UserBloc>().loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.userListTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (query) {
                // this will trigger search as user types in the search field
                context.read<UserBloc>().add(SearchUsers(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                // This handle different states of the BLoC
                if (state is UserLoading) {
                  return const LoadingIndicator();
                } else if (state is UserLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      // when you manually pull down, it will refresh event the user list
                      context.read<UserBloc>().add(RefreshUsers());
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCard(
                          user: user,
                          onTap: () {
                            // this will navigate you to the user profile page on card tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserProfilePage(user: user),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is UserError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () {
                      // Dispatch fetch event on retry button tap
                      context.read<UserBloc>().add(FetchUsers());
                    },
                  );
                } else if (state is UserNoData) {
                  return const NoDataView();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return FloatingActionButton(
            onPressed: () {
              // This will toggle the theme between light and dark when clicked
              context.read<ThemeBloc>().add(ToggleTheme());
            },
            child: Icon(
              themeState.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          );
        },
      ),
    );
  }
}
