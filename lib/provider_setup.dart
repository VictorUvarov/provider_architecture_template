import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [];
