## CustomSwitchWidget

```yaml
dependencies:
  ...
  custom_switch_widget: ^0.0.1
```

```dart
final CustomSwitchController _controller = CustomSwitchController();

CustomSwitchWidget(
  controller: _controller, 
  onChange: (value) {},
)
```

* Enable switch
```dart
_controller.enable();
```

* Disable switch
```dart
_controller.disable();
```

| Fields        | Description                                                                                           |
|---------------|-------------------------------------------------------------------------------------------------------|
| controller    | Channel sending the changes to be made                                                                          |
| activeColor   | color the widget when enable                                                                          |
| inactiveColor | color the widget when disable                                                                         |
| pointColor    | color the point widget                                                                                |
| width         | Helps set the width of the widget. NOTE: only up to **50 px** is allowed **(width >= 30 && width <= 50)** |
| height        | Helps set the height of the widget. NOTE: only up to **50 px** is allowed **(width >= 20 && width <= 50)** |
| borderRadius  | Sets the edges of the widget                                                                        |
| onChange      | Detects call touch for state change                                                                        |

