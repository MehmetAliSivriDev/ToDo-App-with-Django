class ProductStrings {
  static const fabText = "Add To Do";
  static const appBarText = "To Do";
  static const searchText = "Search";

  //Slidable Strings
  static const slidableDelete = "Delete";
  static const slidableEdit = "Edit";
  //----

  //Hint Text Strings
  static const tfHintTitle = "Title";
  static const tfHintBody = "Body";
  static const tfHintNewTitle = "New Title";
  static const tfHintNewBody = "New Body";
  //----

  //Buttons Strings
  static const addButtonText = "Add";
  static const yesText = "Yes";
  static const noText = "No";
  //----

  //Alert Dialog Strings
  static const dialogFillBlanksText = "Please fill all the blanks.";
  static const editDialogTitle = "Edit To Do";
  static const deleteDialogTitle = "Delete To Do";
  static deleteDialogContentText(String itemTitle) =>
      'Are you sure about to delete this "$itemTitle" to do.';
  //----

  //Snackbar Strings
  //Delete
  static const deleteSnackbarSuccessContent = "To Do successfully deleted";
  static const deleteSnackbarErrorContent =
      "An error occurred while deleting the to do.";

  //Add
  static const addSnackbarSuccessContent = "To Do added successfully";
  static const addSnackbarErrorContent =
      "An error occurred while adding the to do.";

  //Edit
  static const editSnackbarSuccessContent = "To Do edited successfully";
  static const editSnackbarErrorContent =
      "An error occurred while editing the to do.";
  //----
}
