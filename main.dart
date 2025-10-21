import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Three Page App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
        ),
      ),
      routes: {
        '/': (context) => const MainShell(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
      },
      initialRoute: '/',
    );
  }
}

class PageCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets pad;

  const PageCard({super.key, required this.child, this.pad = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(padding: pad, child: child),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const AboutPage(),
    const ContactPage(),
  ];

  static const List<String> _titles = ['Home', 'About', 'Contact'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail_outlined), label: 'Contact'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  @override
  Widget build(BuildContext context) {
    return PageCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.teal,
            child: Icon(Icons.home, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text('Welcome', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text(
            'This is the Home Page',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.asset(
                'assets/home_image.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.broken_image, size: 36, color: Colors.grey),
                      SizedBox(height: 6),
                      Text('image not found in assets', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _goToAbout(context),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('About'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                icon: const Icon(Icons.contact_mail_outlined),
                label: const Text('Contact'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _smartBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xFF2A9E28),
            child: Icon(Icons.info_outline, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'About',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is the About Page\nMy name is Osama M. Elemam',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('Go to Contact Page'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _smartBack(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void _smartBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xFF00695C),
            child: Icon(Icons.contact_mail, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text('Contact', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text(
            'OSAMA Elemam\nID: 4221166',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () => _smartBack(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
