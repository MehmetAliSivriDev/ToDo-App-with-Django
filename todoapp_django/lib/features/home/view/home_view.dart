import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp_django/features/home/model/todo_model.dart';
import 'package:todoapp_django/features/home/view_model/home_view_model.dart';
import 'package:todoapp_django/product/const/product_border_radius.dart';
import 'package:todoapp_django/product/const/product_box_decoration.dart';
import 'package:todoapp_django/product/const/product_colors.dart';
import 'package:todoapp_django/product/const/product_input_decoration.dart';
import 'package:todoapp_django/product/const/product_paddings.dart';
import 'package:todoapp_django/product/const/product_strings.dart';
import 'package:todoapp_django/product/extensions/context_extension.dart';
import 'package:todoapp_django/product/mixin/show_bottom_sheet_mixin.dart';
import 'package:todoapp_django/product/widget/custom_text_field.dart';
import 'package:todoapp_django/product/widget/divider_close_button.dart';
import 'package:todoapp_django/product/widget/slidable_action_container.dart';
import 'package:todoapp_django/product/widget/text_field_in_alert_dialog.dart';
import 'package:todoapp_django/product/widget/todo_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum Actions { delete, edit }

class _HomeViewState extends HomeViewModel with ShowBottomSheet {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  TextEditingController _titleEditController = TextEditingController();
  TextEditingController _bodyEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildAddFab(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAddFab(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          showCustomSheet(context, _buildAddToDo(context));
        },
        icon: const Icon(Icons.add),
        label: const Text(ProductStrings.fabText));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const ProductPaddings.scaffoldPadding(),
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(1),
      decoration: ProductBoxDecoration.backgroundDecoration(),
      child: Column(
        children: [
          _customAppBar(context),
          _buildSearchbar(context),
          Expanded(
              child: isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildToDos()),
          SizedBox(
            height: context.dynamicHeight(0.05),
          ),
          // context.emptyWidgetHeight
        ],
      ),
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Padding(
      padding: const ProductPaddings.onlyTop15(),
      child: SizedBox(
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(0.1),
        child: Card(
            color: ProductColors.bgWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ProductStrings.appBarText,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ProductColors.hlBlack)),
                context.emptyWidgetHeight,
                Text(
                  getTimeAndMessage(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: ProductColors.hlBlack),
                )
              ],
            )),
      ),
    );
  }

  Widget _buildSearchbar(BuildContext context) {
    return Padding(
      padding: const ProductPaddings.all5(),
      child: Container(
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(0.05),
        decoration: ProductBoxDecoration.searchbarDecoration(),
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ProductColors.txtwhite),
          decoration: ProductInputDecoration.searchbarInputDecoration(context),
          onChanged: (value) => filterList(value),
        ),
      ),
    );
  }

  Widget _buildToDos() {
    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      child: ListView.separated(
        separatorBuilder: (context, index) => context.emptyWidgetHeight,
        itemCount: filteredList?.length ?? 0,
        itemBuilder: (context, index) {
          return _buildToDo(index);
        },
      ),
    );
  }

  Widget _buildToDo(int index) {
    return Slidable(
      key: Key(filteredList?[index].title ?? ""),
      endActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableActionContainer(
            color: ProductColors.delRed,
            icon: Icons.delete,
            text: ProductStrings.slidableDelete,
            onTap: () => _actionFunction(index, Actions.delete))
      ]),
      startActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableActionContainer(
            color: Colors.blueAccent,
            icon: Icons.edit,
            text: ProductStrings.slidableEdit,
            onTap: () => _actionFunction(index, Actions.edit))
      ]),
      child: ToDoListTile(
        filteredList: filteredList,
        index: index,
      ),
    );
  }

  void _actionFunction(int index, Actions action) {
    switch (action) {
      case Actions.delete:
        final alertDialog = _buildDeleteDialog(index, context);
        showDialog(context: context, builder: (_) => alertDialog);
      case Actions.edit:
        final alertDialog = _buildEditDialog(index);
        showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  Widget _buildAddToDo(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(0.4),
      child: Column(
        children: [
          const DividerCloseButton(),
          CustomTextField(
              controller: _titleController,
              hintText: ProductStrings.tfHintTitle),
          CustomTextField(
              controller: _bodyController, hintText: ProductStrings.tfHintBody),
          FilledButton(
              onPressed: () {
                _controlAndAdd(context);
              },
              child: const Text(ProductStrings.addButtonText))
        ],
      ),
    );
  }

  void _controlAndAdd(BuildContext context) {
    if (_titleController.text != "" && _bodyController.text != "") {
      ToDoModel model =
          ToDoModel(title: _titleController.text, body: _bodyController.text);
      addToDo(model);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: ProductColors.delRed,
          content: Text(ProductStrings.dialogFillBlanksText)));
      Navigator.pop(context);
    }
    _titleController.text = "";
    _bodyController.text = "";
  }

  Widget _buildEditDialog(int index) {
    return AlertDialog(
      title: const Text(ProductStrings.editDialogTitle),
      shape: RoundedRectangleBorder(
          borderRadius: ProductBorderRadius.circularLow()),
      backgroundColor: ProductColors.dgWhite,
      actionsPadding: const ProductPaddings.all5(),
      actions: [
        TFinAlertDialog(
          controller: _titleEditController,
          hintText: ProductStrings.tfHintNewTitle,
        ),
        TFinAlertDialog(
          controller: _bodyEditController,
          hintText: ProductStrings.tfHintNewBody,
        ),
        _buildSendButton(index),
      ],
    );
  }

  Widget _buildSendButton(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              _controlAndEdit(index);
            },
            icon: const Icon(
              Icons.send,
            )),
      ],
    );
  }

  void _controlAndEdit(int index) {
    if (_titleEditController.text != "" && _bodyEditController.text != "") {
      ToDoModel model = ToDoModel(
          id: filteredList?[index].id,
          title: _titleEditController.text,
          body: _bodyEditController.text);
      editToDo(model);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: ProductColors.delRed,
          content: Text(ProductStrings.dialogFillBlanksText)));
      Navigator.pop(context);
    }

    _titleEditController.text = "";
    _bodyEditController.text = "";
  }

  Widget _buildDeleteDialog(int index, BuildContext context) {
    return AlertDialog(
      title: const Text(ProductStrings.deleteDialogTitle),
      content: Text(ProductStrings.deleteDialogContentText(
          filteredList?[index].title.toString() ?? "")),
      actions: [
        FilledButton(
          onPressed: () async {
            deleteToDo(filteredList?[index].id ?? -1);
          },
          child: const Text(ProductStrings.yesText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(ProductStrings.noText),
        ),
      ],
    );
  }
}
