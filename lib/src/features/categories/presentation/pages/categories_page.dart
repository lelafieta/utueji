import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:utueji/src/features/categories/domain/entities/category_entity.dart';
import 'package:utueji/src/features/categories/domain/params/create_category_params.dart';
import 'package:utueji/src/features/categories/presentation/cubit/categories/categories_cubit.dart';
import 'package:utueji/src/features/categories/presentation/cubit/categories/categories_state.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getAllCategories();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  void _createCategory() {
    if (_categoryNameController.text.isNotEmpty) {
      context.read<CategoriesCubit>().createCategory(
            CreateCategoryParams(name: _categoryNameController.text),
          );
      _categoryNameController.clear();
    }
  }

  void _deleteCategory(int id) {
    context.read<CategoriesCubit>().deleteCategory(id);
  }

  void _showUpdateDialog(CategoryEntity category) {
    final TextEditingController updateController =
        TextEditingController(text: category.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Category'),
          content: TextField(
            controller: updateController,
            decoration: const InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (updateController.text.isNotEmpty) {
                  context.read<CategoriesCubit>().updateCategory(
                        UpdateCategoryParams(
                            id: category.id, name: updateController.text),
                      );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CategoriesSuccess) {
            // Optionally refresh categories after a successful operation
            context.read<CategoriesCubit>().getAllCategories();
          }
        },
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesSuccess) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _categoryNameController,
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: _createCategory,
                        child: const Text('Add Category'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return ListTile(
                        title: Text(category.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showUpdateDialog(category);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCategory(category.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is CategoriesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press the button to load categories.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CategoriesCubit>().getAllCategories();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}