import 'package:flutter/material.dart';
import 'package:pazzy/pazzy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('PazzyWidget'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const PazzyWidgetScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('PazzyNumberlessWidget'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const PazzyNumberlessWidgetScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PazzyWidgetScreen extends StatefulWidget {
  const PazzyWidgetScreen({super.key});

  @override
  PazzyWidgetScreenState createState() => PazzyWidgetScreenState();
}

class PazzyWidgetScreenState extends State<PazzyWidgetScreen> {
  var _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PazzyWidgetScreen'),
      ),
      body: SingleChildScrollView(
        child: PazzyWidget(
          itemCount: _titles.length,
          currentPage: _currentPage,
          perPage: 10,
          itemBuilder: (context, index) {
            final title = _titles[index];
            return ListTile(
              leading: const ColoredBox(
                color: Colors.grey,
                child: SizedBox(
                  width: 44,
                  height: 44,
                ),
              ),
              title: Text(title),
            );
          },
          numberBuilder: (context, number, current) {
            if (number == null) {
              return const Center(
                child: Text('…'),
              );
            }
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(52, 44),
                maximumSize: const Size(52, 44),
              ),
              onPressed: () {
                setState(() {
                  _currentPage = number;
                });
              },
              child: Text('$number'),
            );
          },
          previousButtonBuilder: (context, previous) {
            return IconButton(
              style: IconButton.styleFrom(
                maximumSize: const Size(44, 44),
                minimumSize: const Size(44, 44),
              ),
              onPressed: previous != null
                  ? () {
                      setState(() {
                        _currentPage = previous;
                      });
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_left),
            );
          },
          nextButtonBuilder: (context, next) {
            return IconButton(
              style: IconButton.styleFrom(
                minimumSize: const Size(44, 44),
                maximumSize: const Size(44, 44),
              ),
              onPressed: next != null
                  ? () {
                      setState(() {
                        _currentPage = next;
                      });
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_right),
            );
          },
          itemsAndPaginationSpacing: 8,
          numberButtonSpacing: 8,
        ),
      ),
    );
  }
}

class PazzyNumberlessWidgetScreen extends StatefulWidget {
  const PazzyNumberlessWidgetScreen({super.key});

  @override
  PazzyNumberlessWidgetScreenState createState() => PazzyNumberlessWidgetScreenState();
}

class PazzyNumberlessWidgetScreenState extends State<PazzyNumberlessWidgetScreen> {
  var _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PazzyNumberlessWidgetScreen'),
      ),
      body: SingleChildScrollView(
        child: PazzyNumberlessWidget(
          itemCount: _titles.length,
          currentPage: _currentPage,
          perPage: 10,
          itemBuilder: (context, index) {
            final title = _titles[index];
            return ListTile(
              leading: const ColoredBox(
                color: Colors.grey,
                child: SizedBox(
                  width: 44,
                  height: 44,
                ),
              ),
              title: Text(title),
            );
          },
          paginationTextBuilder: (context, current, numberOfPages) {
            return Center(child: Text('Page $current of $numberOfPages'));
          },
          previousButtonBuilder: (context, previous) {
            return IconButton(
              style: IconButton.styleFrom(
                maximumSize: const Size(44, 44),
                minimumSize: const Size(44, 44),
              ),
              onPressed: previous != null
                  ? () {
                      setState(() {
                        _currentPage = previous;
                      });
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_left),
            );
          },
          nextButtonBuilder: (context, next) {
            return IconButton(
              style: IconButton.styleFrom(
                minimumSize: const Size(44, 44),
                maximumSize: const Size(44, 44),
              ),
              onPressed: next != null
                  ? () {
                      setState(() {
                        _currentPage = next;
                      });
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_right),
            );
          },
          itemsAndPaginationSpacing: 8,
        ),
      ),
    );
  }
}

final _titles = List.generate(122, (number) => 'title$number');
