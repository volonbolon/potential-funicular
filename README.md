I set a limit of 8 hours and managed to finish a bunch of features. That means there’s still a lot of room for improvement in almost every part of the app.

Let’s start with the architecture. I chose VIPER, not because it’s the best choice for the app, but just to show a different way of doing things. Of course, I should probably get rid of the compose architecture (I know Apple says it’s a good way to learn, it’s simpler than other patterns, but it makes the views too big). MVVM would be perfect for a small and simple app like this one. VIPER is a bit more complicated, but it also makes it easier to break up the app into different parts and hide the details.

I also decided to use protocols for the services. That way, we can easily switch them out for testing.

When it comes to services, in a real-world scenario, we might want to use a live API.

I’m using SwiftData to store the data. It’s a simple solution, and it’s easy to switch the underlying store if we need to (we’re showing a simple struct that can be changed with any solution, like Core Data or Realm).

For the React side, I didn’t use React Web because I was running out of time. I’m not really familiar with that particular version. I’ve tried it a few times before, and it’s always been slow. That’s why I chose React. I’m loading it through RCTBridgeModule, which is much faster. We send messages back and forth between Swift and React, pushing and demanding supposed stock prices. 

For the internal state, I’m using Redux. Some people might say that for a simple app (or part of an app), it might be easier to pass props around. That might be true, but I like the idea of having a single place to keep all the data.

I’ve made a switch to TypeScript instead of JavaScript. Why? I’m a big fan of typed languages. Sure, defining types can be a bit of a pain, but it makes the code safer and less likely to break. 

For the chart, I’m using Victory with Skia. It’s a simple and user-friendly option that has some support for manipulation. I’ve used it to show a tooltip for each price. There are plenty of other options, but I’ve had great results with D3.js and Echarts, but they’re way more complicated. That’s why I went with Victory. 