# Overlapped Carousel

A horizontal overlapped carousel widget. The center widget will be at the top of the stack.

# Demo

|                                                                          Demo 1                                                                          |                                                                            Demo 2                                                                            |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| <img src="https://user-images.githubusercontent.com/42492040/144290050-b45603df-42c9-48e0-b29e-5b68205ffc63.gif" width="250" height="460" alt="demo 1"/> | <img src="https://github.com/yashas-hm/overlapped_carousel/assets/64674824/7146b81c-decc-42d1-a702-93bd8f12d492.gif" width="250" height="460" alt="demo 2"/> |

# Installation

Add `overlapped_carousel: ^1.1.0` to your `pubspec.yaml` dependencies. And import it:

```
import 'package:overlapped_carousel/overlapped_carousel.dart';
```

<br>

# How to use

Simply add a `OverlappedCarousel` widget with required params.

``` dart 
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      //Wrap with Center to place the carousel center of the screen
      body: Center(
        //Wrap the OverlappedCarousel widget with SizedBox to fix a height. No need to specify width.
        child: SizedBox(
          height: min(screenWidth / 3.3 * (16 / 9),screenHeight*.9),
          child: OverlappedCarousel(
            widgets: widgets, //List of widgets
            currentIndex: 2,
            onClicked: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You clicked at $index"),
                ),
              );
            },
            // To obscure or blur cards not in focus use the obscure parameter.
            obscure: 0.4,
            // To control skew angle
            skewAngle: 0.25,
          ),
        ),
      ),
    );
  }
```
