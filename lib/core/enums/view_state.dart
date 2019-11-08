/// A value mapping the View UI to the state in the Model.
enum ViewState {
  /// When nothing is happening or just initialized

  Idle,

  /// Typically shows a loading indicator of some sorts
  Busy,

  /// Indicates that there's data available on the view
  DataFetched,

  /// Indicates that data was fetched successfully but nothing is available
  NoDataAvailable,

  /// Indicates there's an error on the view
  Error,

  /// Successful action occurred
  Success,

  /// The starting state that a form view is in
  WaitingForInput
}
