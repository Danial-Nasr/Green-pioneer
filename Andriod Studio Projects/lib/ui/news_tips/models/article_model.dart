import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final int views;
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.createdAt,
  });

  static List<Article> articles = [
    Article(
      id: '1',
      title:
          'Climate Change.A Short Film',
      subtitle:
          'Original Video by Philip Kapadia:Climate Change,Short Film',
      body:
          'The challenge facing our climate is the greatest existential threat of our lifetime. The actions will take now will determine the future for generations to come. Now is not a time for half measures nor is it a time where we can we afford to continue our prioritization of profit over people. Climate change is greater than any one of us, but it requires every single one of us to come together to ensure there can and will be a future for the next to come.',
      author: 'Philip. Wright',
      authorImageUrl:
      'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
      'assets/images/wp6303673.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Article(
      id: '2',
      title:
          'The world transition to sustainable agriculture has become more urgent to reduce environmental damage',
      subtitle:
          'The world transition to sustainable agriculture has become more urgent to reduce environmental damage',
      body:
          'Today the world faces many challenges, including the steady increase in population and, consequently, the increase in food consumption.  Therefore, the transition to sustainable agriculture has become more urgent.  What is this concept?',
      author: 'skynewsarabia',
      authorImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'assets/images/wallpaperflare.com_wallpaper.jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '3',
      title:
          'How to grow rice, step by step. The most important tips for reducing its side effects',
      subtitle:
          'How to grow rice, step by step. The most important tips for reducing its side effects',
      body:
          'How to grow rice, step by step. The most important tips for reducing its side effects',
      author: 'My Farming Village',
      authorImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:"assets/images/wallpaperflare.com_wallpaper (2).jpg",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '4',
      title: 'For home gardening enthusiasts...the best types of soil and fertilizer.  And tips for correct irrigation..',
      subtitle:
          'For home gardening enthusiasts...the best types of soil and fertilizer.  And tips for correct irrigation..',
      body:
          'A comprehensive video on home farming methods, how to choose the appropriate soil, and how to deal with seeds',
      author: 'Agricultural Nsamat',
      authorImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'assets/images/wallpaperflare.com_wallpaper (3).jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '5',
      title:
          'How to use weed killers',
      subtitle:
          'Conditions that must be taken into account when spraying weed control pesticides on field crops',
      body:
          'Conditions that must be taken into account when spraying weed control pesticides on field crops,How to use weed killers',
      author: 'Fekra',
      authorImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'assets/images/wallpaperflare.com_wallpaper (1).jpg',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        createdAt,
      ];
}
