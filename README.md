I self impose a limit of 8 hours, and tried to achive a set of finished features. Because of that, there is plenty of room to improve almost each corner of the app. 

First, let's talk about the architecture. I choose to go with VIPER. Not because is the most appropriate for the app, but because I wanted to show something different. Obviously, the compose architecture should be vanished (i do understand Apple advancing it as a pedagogical tool, it is simpler than other patterns, but it drives to gigantic Views). MVVM would be great for a small and simple app (like this one). VIPER is a little bit more complex, but it also helps with the modularization and abstraction of different layers. 

I also choose to inject dependencies, and use protocols for the services. That way we can simply swap them for testing. 

Regarding services, obviously, in a real app we might want to talk to some kind of live API. 

I am using SwiftData to store entities. It is a simple solution, and is really easy to swap the underlying store if needed (here we are exposing a simple struct, that can be cycled with any solution (core data, Realm, etc)). 

For the react side i choose against React Web. Mostly because of my self imposed time limit. I am not that familiar with such a flavour. I have tried a few times in the past, and the performance was always dissapointing. That's why i choose React. I am loading it through RCTBridgeModule. It is far more perfomant. We are dispatching a payload from Swift to React, and then, we are messaging swift from react (asking for a list of supposed prices to show in a chart). 

I've also decided to use Typescript, instead of JS. The reason is simple, i like typed languages. You might need to define types, and perhaps sometimes seems a little more cumbersome, but at the end of the day, is safer. Less prone to bugs, easier to deploy. 

For the cart i am using victory with skia. It is simple, and it offers some support for manipulation (i've used it to show a tooltip with each price). There are pleny of alternatives. I've had wonderful results with D3.js and Echarts, but these are way more complex. That's why i choose Victory. 