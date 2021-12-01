# Coverflow

A horizontal overlapped carousel widget. The center widget will be at the top of the stack.
<br><br>

# Demo
![screenrecord](https://user-images.githubusercontent.com/42492040/144290050-b45603df-42c9-48e0-b29e-5b68205ffc63.gif)


# Installation

Add `overlapped_carousel: ^1.0.0` to your `pubspec.yaml` dependecies. And import it:

```
import 'package:overlapped_carousel/overlapped_carousel.dart';
```
<br>

# How to use
Simply add a `OverlappedCarousel` widget with required params.

```  
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      //Wrap with Center to place the carousel center of the screen
      body: Center(
        //Wrap the OverlappedCarousel widget with SizedBox to fix a height. No need to specify width.
        child: SizedBox(
          height: maxWidth / 3.6 * (16 / 9),
          child: OverlappedCarousel(
            widgets: widgets, //List of widgets
            onClicked: () {},
          ),
        ),
      ),
    );
  }
```
<br>

