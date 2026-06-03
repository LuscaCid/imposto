import 'package:flutter/material.dart';
import 'package:imposto/components/fieldset.dart';
import 'package:imposto/components/home_match_card.dart';
import 'package:imposto/components/page_wrapper.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/services/rooms_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchMatchesController =
      TextEditingController();
  final int _matchesLimit = 15;

  String _searchMatchesQuery = "";
  bool _isLoading = false;
  bool _hasMore = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMore();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore({bool reset = false}) async {
    if (_isLoading) return;
  }

  void _onSearchChanged(String value) {
    setState(() => _searchMatchesQuery = value);
    _loadMore(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    final roomsProvider = Provider.of<RoomsProvider>(context);

    return PageWrapper(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FieldSet(
              controller: _searchMatchesController,
              onChanged: _onSearchChanged,
              icon: Icons.search,
              placeholder: 'Código da partida ou nome',
              variant: FieldVariant.primary,
              type: FieldType.normal,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _loadMore(reset: true),
              child: ListView.builder(
                itemCount: roomsProvider.rooms.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index < roomsProvider.rooms.length) {
                    final room = roomsProvider.rooms[index];
                    return HomeMatchCard(
                      room: room,
                      players: room.players,
                    );
                  }

                  if (_isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
