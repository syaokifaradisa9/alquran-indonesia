import 'package:alquran_indonesia/common/constants.dart';
import 'package:alquran_indonesia/common/state_enum.dart';
import 'package:alquran_indonesia/domain/entities/surah.dart';
import 'package:alquran_indonesia/presentation/provider/surah_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = 'home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SurahListNotifier>(context, listen: false)
      ..fetchSurahList());
  }

  @override
  Widget build(BuildContext context) {
    Widget surahCard({ required Surah surah, required AudioPlayerState state, required int surahPlayedNumber}) {
      return Card(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 70,
                color: k0xGreen,
                alignment: Alignment.center,
                child: Text(
                  surah.number.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: kRichBlack
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "${surah.latinName} (",
                        style: kSubtitle,
                        children: [
                          TextSpan(
                            text: "${surah.arabicText} )",
                            style: const TextStyle(
                              fontFamily: 'LPMQ',
                              fontSize: 16
                            ),
                          )
                        ]
                      )
                    ),
                    const SizedBox(height: 2),
                    Text(
                      surah.indonesianMean,
                      style: kBodyText.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () async{
                    Provider.of<SurahListNotifier>(
                      context,
                      listen: false
                    ).playSurahByNumber(surah.number);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: k0xGreen,
                      shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      state == AudioPlayerState.Playing && surahPlayedNumber == surah.number ?
                      Icons.pause : Icons.play_arrow,
                      color: kRichBlack,
                      size: 20,
                    ),
                  )
              ),
            ],
          )
      );
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<SurahListNotifier>(
                    builder: (context, data, child) {
                      final state = data.surahListState;
                      if(state == RequestState.Loading){
                        return const Center(child: CircularProgressIndicator());
                      }else if(state == RequestState.Loaded){
                        return ListView.builder(
                          itemCount: data.surahList.length,
                          itemBuilder: (context, index) => surahCard(
                            surah: data.surahList[index],
                            state: data.playerState,
                            surahPlayedNumber: data.playedSurahNumber
                          )
                        );
                      }else{
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                    }
                ),
              ),
              TextFormField(
                onChanged: (value) => Provider.of<SurahListNotifier>(
                  context,
                  listen: false
                ).searchSurah(value),
                cursorColor: k0xGreen,
                decoration: const InputDecoration(
                  hintText: 'Cari surah',
                  prefixIcon: Icon(Icons.search, color: k0xGreen),
                  border: InputBorder.none
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
