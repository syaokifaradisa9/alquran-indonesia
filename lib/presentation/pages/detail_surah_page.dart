import 'package:alquran_indonesia/common/constants.dart';
import 'package:alquran_indonesia/common/functions.dart';
import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/verse.dart';
import 'package:alquran_indonesia/presentation/provider/surah_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailSurahPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int surahNumber;
  final String surahName;

  const DetailSurahPage({
    required this.surahNumber,
    required this.surahName,
    Key? key
  }) : super(key: key);

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SurahDetailNotifier>(context, listen: false)
      ..fetchDetailSurah(widget.surahNumber));
  }

  @override
  Widget build(BuildContext context) {
    Widget VerseCard({ required Verse verse }) {
      return Card(
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            verse.number.toString(),
                            style: kSubtitle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            )
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: verse.arabicText,
                                  style: const TextStyle(
                                    fontFamily: 'LPMQ',
                                    fontSize: 20
                                  )
                                ),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: SizedBox(width: 6)
                                ),
                                TextSpan(
                                  text: "(${toArabicNumber(verse.number.toString())})",
                                  style: kSubtitle.copyWith(fontSize: 17)
                                ),
                              ]
                            )
                          )
                        )
                      ]),
                  const SizedBox(height: 14),
                  Text(
                    verse.indonesianText,
                    style: GoogleFonts.openSans(fontSize: 13),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    verse.indonesianMean,
                    style: kBodyText.copyWith(fontSize: 12),
                    textAlign: TextAlign.justify,
                  )
                ],
              )
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
      ),
      body: Consumer<SurahDetailNotifier>(
        builder: (context, data, child) {
          final state = data.state;
          if (state == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == RequestState.Loaded) {
            return ListView.builder(
              itemCount: data.detailSurah.verses.length,
              itemBuilder: (context, index) => VerseCard(
                verse: data.detailSurah.verses[index]
              )
            );
          } else{
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
