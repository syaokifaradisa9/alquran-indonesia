import 'package:alquran_indonesia/common/constants.dart';
import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/verse_interpretation.dart';
import 'package:alquran_indonesia/presentation/provider/surah_interpretation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahInterpretationPage extends StatefulWidget {
  static const ROUTE_NAME = '/surah-interpretation';

  final String surahName;
  final int surahNumber;

  const SurahInterpretationPage({
    required this.surahName,
    required this.surahNumber,
    Key? key
  }) : super(key: key);

  @override
  State<SurahInterpretationPage> createState() => _SurahInterpretationPageState();
}

class _SurahInterpretationPageState extends State<SurahInterpretationPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SurahInterpretationNotifier>(context, listen: false)
      ..fetchSurahInterpretation(widget.surahNumber));
  }

  @override
  Widget build(BuildContext context) {
    Widget InterpretationCard({ required VerseInterpretation verseInterpretation }) {
      return ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                verseInterpretation.interpretation,
                style: kBodyText.copyWith(fontSize: 12),
                textAlign: TextAlign.justify,
              )
            )
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tafsir ${widget.surahName}"),
      ),
      body: Consumer<SurahInterpretationNotifier>(
        builder: (context, data, child){
          final RequestState state = data.state;
          if (state == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == RequestState.Loaded) {
            return Column(
              children: [
                Expanded(
                  child: InterpretationCard(
                    verseInterpretation: data.surahInterpretation.verseInterpretations[data.interpretationIndex]
                  )
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<SurahInterpretationNotifier>(
                            context,
                            listen: false
                          ).previousInterpretation();
                        },
                        child: const Icon(Icons.navigate_before),
                      ),
                      Text(
                        "${data.interpretationIndex + 1} / ${data.surahInterpretation.verseInterpretations.length}",
                        style: kBodyText.copyWith(
                          color: k0xGreen,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<SurahInterpretationNotifier>(
                            context,
                            listen: false
                          ).nextInterpretation();
                        },
                        child: const Icon(Icons.navigate_next),
                      )
                    ],
                  ),
                )
              ],
            );
          } else{
            return const Center(child: Text('Error'));
          }
        }
      )
    );
  }
}
