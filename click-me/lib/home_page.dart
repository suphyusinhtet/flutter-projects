import 'package:provider/provider.dart';
import 'package:click_me/domain/click_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use (_) modifier before variables to indicate that they are private
  // private means they can only be accessed within the scope

  @override
  Widget build(BuildContext context) {
    final clickProvider = context.read<ClickProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Click Me'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/leaderboard',
                arguments: {
                  'result': (context.read<ClickProvider>().likeCounter + context.read<ClickProvider>().loveCounter) - context.read<ClickProvider>().unlikeCounter,
                },
              );
            },
            icon: const Icon(Icons.leaderboard),
          ),
        ],
      ),
      body: Container(
        width: double
            .maxFinite, // [double.maxFinite] width = 1.7976931348623157e+308
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color:
              Theme.of(context).primaryColor.withOpacity(0.1), // transparency
        ),
        padding: const EdgeInsets.all(
            20), // the space between the border and the content
        margin: const EdgeInsets.all(12), // the space outside the border
        child: Column(
          children: [
            Text(
              'This is your Click Me post!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 100,
            ), // an empty container
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Consumer<ClickProvider>( // GetBuilder
                  builder: (_, counter, __) {
                    return Text(
                      '${counter.likeCounter}\n 👍',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                Consumer<ClickProvider>( // GetBuilder
                  builder: (_, counter2, __) {
                    return Text(
                      '${counter2.loveCounter}\n 💖',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.green,
                      ),
                    textAlign: TextAlign.center,
                    );
                  },
                ),
                Consumer<ClickProvider>( // GetBuilder
                  builder: (_, counter3, __) {
                    return Text(
                      '${counter3.unlikeCounter}\n 👎',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton.icon(
            onPressed: (){
              clickProvider.increaseLike();
            },
            icon: const Icon(
              Icons.thumb_up,
              size: 18,
            ),
            label: const Text('Like'),
          ),
          FilledButton.icon(
            onPressed: (){
              clickProvider.increaseLove();
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            icon: const Icon(
              Icons.favorite,
              size: 18,
            ),
            label: const Text('Love'),
          ),
          FilledButton.icon(
            onPressed: (){
              clickProvider.increaseUnlike();
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            icon: const Icon(
              Icons.thumb_down,
              size: 18,
            ),
            label: const Text('Unlike'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
