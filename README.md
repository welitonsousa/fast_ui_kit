
<p align="center">
<img width="400" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/images/fast.png">
</p>

### Access the complete documentation 
[www.fast-ui-kit.vercel.app](https://fast-ui-kit.vercel.app)

### Simple Implementation !

<p>
The "Fast UI Kit" is a Flutter package that aims to simplify application development by providing a collection of ready-to-use components. Similar to Quasar, it offers a set of components that can be used to quickly and efficiently create user interfaces while maintaining a consistent and elegant design.
</p>
<p>
The main goal of the "Fast UI Kit" is to expedite the development process by allowing developers to utilize pre-defined components instead of building each element from scratch. This saves time and effort while helping to maintain a cohesive visual appearance throughout the application.
</p>

<p align="center">
  <img width="200" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/images/ui.png">
</p>


✅ Dark Mode suporte
✅ Color scheme suporte

The components screenshots with colors scheme green selected

#### example of button
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/button.png">
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/button_outlined.png">
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/button_outlined_loading.gif">
</p>
<br>


#### example of form field
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/formfield.gif">
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/money_mask.gif">
</p>
<br>

#### example of form field
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/button.png">
</p>
<br>



#### example of button group
<p>
  <img width="400" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/button_group.gif">
</p>
<br>


#### example of audio player
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/audio.png">
</p>
<br>

#### example of calendar
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/calendar.png">
</p>
<br>

#### example of carousel
<p>
  <img width="400" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/carousel.gif">
</p>
<br>

#### example of typographic
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/text.png">
</p>
<br>

#### example of input picker
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/file.gif">
</p>
<br>

#### example of column

Use FastColumn to have a vertical gap between components
<p>
  <img width="300" src="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/assets/components/column.png">
</p>
<br>



### Define your theme

```dart
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final theme = FastTheme(seed: Colors.green);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: theme.dark,
      theme: theme.light,
      home: const HomePage(),
    );
  }
}
```

### Components
- FastColum
- FastRow
- FastImg
- FastAvatar
- FastAnimate
- FastCalendar
- FastTable
- FastSkeleton
- FastSearchAppBar
- FastFormField
- FastFormFieldFile
- FastDropDown
- FastDialog
- FastContent
- FastCarousel
- FastButton
- FastButtonIcon
- FastButtonGroup
- FastAudio
- FastIcon -> `Icon(FastIcons.library.icon)`

### Extension
<span>
Typographic

- context.H1
- context.H2
- context.H3
- context.H4
- context.H5
- context.H6
- context.P

<br>
Size

- context.height
- context.width

<br>
Navigation

- context.dialog
- context.push
- context.pushNamed
- context.pushReplacement
- context.pushReplacementNamed
- context.pushAndRemoveUntil
- context.pushAndRemoveUntilNamed
- pop
- popUntil
- popUntilNamed

<br>
Style

- context.colors  `color scheme`
- context.theme `current theme`
- context.button `button scheme of colors`
- context.brightness `brightness of application`

<br>
Message

- context.showMessage

example:
```dart
context.showMessage(
  'Update user successful',
  title: 'Sucesso', //optional field
  type: MessageVariant.success, //optional field
  position: MessagePosition.top, //optional field
  style: Style.flat, //optional field
);
```

### Utils
- FastDebounce
- FastUUID

### Services
- FastAudioService
- FastPickerService


<br>

<a target="_blank" href="https://raw.githubusercontent.com/welitonsousa/fast_ui_kit/main/example/lib/main.dart">📄 Access the example file</a>

<a target="_blank" href="https://fast-ui-kit.vercel.app">📚 Access the complete documentation</a>


<br>
<br>
<p align="center">
   Feito com ❤️ by <a target="_blank" href="https://welitonsousa.shop"><b>Weliton Sousa</b></a>
</p>