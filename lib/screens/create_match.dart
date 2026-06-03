import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imposto/components/fieldset.dart';
import 'package:imposto/components/page_wrapper.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/services/matches_provider.dart';
import 'package:provider/provider.dart';
import 'package:imposto/contracts/match.dart';

class CreateMatchPage extends StatefulWidget {
  const CreateMatchPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateMatchPageState();
}

enum Action { add, remove }

enum FieldSetType {
  TOTAL_IMPOSTORS,
  TOTAL_ROUNDS,
  MAX_PLAYERS,
  ANSWER_DURATION,
  VOTING_DURATION,
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  final TextEditingController _matchName = TextEditingController();
  final TextEditingController _matchPassword = TextEditingController();

  final double _pad = 12;
  static const int DEFAULT_MAX_PLAYERS = 6;
  static const int DEFAULT_TOTAL_ROUNDS = 3;
  static const int DEFAULT_ANSWER_DURATION = 45;
  static const int DEFAULT_VOTING_DURATION = 60;
  static const int DEFAULT_TOTAL_IMPOSTORS = 2;

  final Map<FieldSetType, int> values = {
    FieldSetType.MAX_PLAYERS: DEFAULT_MAX_PLAYERS,
    FieldSetType.TOTAL_IMPOSTORS: DEFAULT_TOTAL_IMPOSTORS,
    FieldSetType.TOTAL_ROUNDS: DEFAULT_TOTAL_ROUNDS,
    FieldSetType.ANSWER_DURATION: DEFAULT_ANSWER_DURATION,
  };

  final Map<FieldSetType, String> labels = {
    FieldSetType.ANSWER_DURATION: "Tempo limite para dicas (em segundos)",
    FieldSetType.VOTING_DURATION: "Duração da votação (em segundos)",
    FieldSetType.TOTAL_IMPOSTORS: "Número de impostores",
    FieldSetType.MAX_PLAYERS: "Limite de jogadores",
    FieldSetType.TOTAL_ROUNDS: "Quantidade de rounds",
  };

  void _handleNumberValues(Action action, FieldSetType field) {
    final step = field == FieldSetType.ANSWER_DURATION ? 5 : 1;

    setState(() {
      final result = values[field]! + (action == Action.add ? step : -step);
      if (result < 0) return;
      values[field] = result;
    });
  }

  @override
  void dispose() {
    _matchName.dispose();
    _matchPassword.dispose();
    super.dispose();
  }

  Widget ActionIconButton(FieldSetType fieldSetType, Action action) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ElevatedButton(
          onPressed: () => _handleNumberValues(action, fieldSetType),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 40),
            backgroundColor: action == Action.remove
                ? ThemeColors.danger500
                : ThemeColors.success500,
          ),
          child: Center(
            child: Icon(
              action == Action.remove ? Icons.remove : Icons.add,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  Widget numericField({required FieldSetType fieldSetType}) {
    return Card(
      color: ThemeColors.zinc800,
      elevation: 2.5,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, top: 10, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemedText(
              content: labels[fieldSetType]!,
              variant: ThemedTextVariant.muted,
              fontSize: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActionIconButton(fieldSetType, Action.remove),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: ThemeColors.zinc800),
                  ),
                  child: Center(
                    child: ThemedText(
                      content: values[fieldSetType].toString(),
                      variant: ThemedTextVariant.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rajdhani',
                    ),
                  ),
                ),
                ActionIconButton(fieldSetType, Action.add),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCreateMatch(BuildContext context) async {
    // TODO: TRATATIVAS COM API PARA CRIAÇÃO DA PARTIDA
    final matchProvider = Provider.of<MatchProvider>(context);
    await matchProvider.createMatch(
      payload: Match(
        maxPlayers: values[FieldSetType.MAX_PLAYERS]!,
        impostorCount: values[FieldSetType.TOTAL_IMPOSTORS]!,
        totalRounds: values[FieldSetType.TOTAL_ROUNDS]!,
        answerDuration: values[FieldSetType.ANSWER_DURATION]!,
        votingDuration: values[FieldSetType.VOTING_DURATION]!,
        isLocked: _matchPassword.text != '',
        name: _matchName.text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: ThemedText(
          content: "Partida criada, indo para o lobby...",
          variant: ThemedTextVariant.info,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageWrapper(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          spacing: _pad,
          children: [
            Card(
              color: ThemeColors.zinc800,
              elevation: 2.3,
              child: Padding(
                padding: EdgeInsets.all(_pad),
                child: Column(
                  spacing: 6,
                  children: [
                    FieldSet(
                      controller: _matchName,
                      icon: Icons.abc,
                      placeholder: 'Nome da partida',
                    ),
                    FieldSet(
                      controller: _matchPassword,
                      icon: Icons.password,
                      placeholder: 'Senha (opcional)',
                      type: FieldType.password,
                    ),
                  ],
                ),
              ),
            ),
            numericField(fieldSetType: FieldSetType.TOTAL_ROUNDS),
            numericField(fieldSetType: FieldSetType.TOTAL_IMPOSTORS),
            numericField(fieldSetType: FieldSetType.MAX_PLAYERS),
            numericField(fieldSetType: FieldSetType.ANSWER_DURATION),
            numericField(fieldSetType: FieldSetType.VOTING_DURATION),
            ElevatedButton(
              onPressed: () => _handleCreateMatch(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.zinc900,
                elevation: 12,
                shadowColor: ThemeColors.primary700,
                side: BorderSide(color: ThemeColors.zinc800, width: 1.5),
              ),
              child: Row(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThemedText(
                    content: 'Criar partida',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    variant: ThemedTextVariant.secondary,
                  ),
                  Icon(Icons.create, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
