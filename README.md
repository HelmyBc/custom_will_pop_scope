
# CustomWillPopScope

  

>  _Note: This package can be used on any platform, and is not specific to iOS. `CustomWillPopScope` and `CustomWillPopScopePageTransionsBuilder` can each be used seprately._

  

<br/>

  

### CustomWillPopScope

  

When using this widget, be sure to update `canReturn` based on the state of your screen, and only set it to `false` when the screen **should not be allowed to pop**. Additionally, the `onWillPop` property should not be changed once set.

  

-------

  

A working app using this package can be found in the [example](example/lib/main.dart) folder.

  

## Usage

  

To use this package, add `custom_will_pop_scope` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

  
  

## Example

### Import the library

  

``` dart

// main.dart
import  'package:decorated_icon/custom_will_pop_scope.dart';

```

### Wrap your screen

Using the included `CustomWillPopScope` widget, wrap your screen and define an `onWillPop` callback for it, and `onPopAction` if you have a function to call when the screen pops (Like removing a route name in the [example](example/lib/main.dart) ).

>  ##### Note that `onWillPop` should always return a `bool`. See the [Flutter Docs](https://api.flutter.dev/flutter/widgets/WillPopScope-class.html) for more.

  

##### Using CustomWillPopScope:
```dart

// first_screen.dart
class  HomeScreen  extends  StatelessWidget {

void  navigateToNext() {

locator<NavigationService>().navigateTo(secondScreen);

}

  

@override

Widget  build(BuildContext  context) {
	return  Scaffold(
		appBar:AppBar(title: Text('CustomWillPopScopeDemo')),
		body:  Center(
			child:  ElevatedButton(
				onPressed: () =>  navigateToNext(),	
				child:  Padding(
					padding:  EdgeInsets.symmetric(horizontal:  24.0,vertical:  12.0),
					child:  Text('Go to second screen'),
					),
				),
			),
		);
	}
}
```

  
###### Using WillPopScope:

```dart

// second_screen.dart
class  SecondScreen  extends  StatefulWidget {
  @override
  _SecondScreenState  createState() =>  _SecondScreenState();
}

  

class  _SecondScreenState  extends  State<SecondScreen> {
	final  NavigationService  _navigationService  =  locator<NavigationService>();
	/// Holds the state of the screen.
	bool  _canReturn  =  true;
	/// Shows an alert and returns `false` when `_canReturn` is `true`.
	/// This prevents the navigator from popping this route.
	Future<bool> _onWillPop() async {
		if (!_canReturn) {
		// Show an alert before returning `false`.
			showDialog(context:  context,
				builder: (context) =>  AlertDialog(
					content:  Text('Back navigation is disabled.'),
				),
			);
			// Return `false` to prevent the route from popping.
			return  false;
		} else {
			_navigationService.removeLastRouteName();
			return  true;
		}
	}

	void  _onPopAction() {
		_navigationService.removeLastRouteName();
	}

  

	/// Updates `_hasChanges` with the provided value.
	void  _updateChanges(bool  value) =>  setState(() =>  _canReturn  =  value);
	@override
	Widget  build(BuildContext  context) {
		return  CustomWillPopScope(
			// canReturn is optional, it is set to true by default
			canReturn:  _canReturn,
			onWillPop:  _onWillPop,
			onPopAction:  _onPopAction,
			child:  Scaffold(
				appBar:  AppBar(title:  Text('Second Screen')),
				body:  Center(
					child:  Container(
						decoration:  BoxDecoration(
							border:  Border.all(color:  _color),
							borderRadius:  BorderRadius.circular(6.0),
						),
						margin:  EdgeInsets.symmetric(horizontal:  12.0),
						child:  SwitchListTile(
							activeColor:  _color,
							onChanged:  _updateChanges,
							title:  Text('Enable back navigation'),
							value:  _canReturn,
						),
					),
				),
			),
		);
	}
}
```

  

