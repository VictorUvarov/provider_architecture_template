/// Model that a dialog in the [DialogManager] accepts as input
class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;

  AlertRequest({
    this.title,
    this.description,
    this.buttonTitle,
  });
}
