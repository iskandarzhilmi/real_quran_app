import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/quran_bloc.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  static String routeName = 'quran_page';

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController:
                            FixedExtentScrollController(initialItem: 0),
                        onSelectedItemChanged: (int index) {
                          pageNumber = index + 1;
                        },
                        children: List.generate(
                          604,
                          (index) => Text(
                            '${index + 1}',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text('Confirm'),
                      onPressed: () {
                        context.read<QuranBloc>().add(
                              QuranPagePicked(
                                pageNumber: pageNumber,
                              ),
                            );
                      },
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: BlocBuilder<QuranBloc, QuranStateModel>(
                      builder: (context, state) {
                    if (state.quranState is QuranInitial) {
                      return Center(
                        child: Column(
                          children: const [
                            Text('Please enter a page number'),
                          ],
                        ),
                      );
                    } else if (state.quranState is QuranLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.quranState is QuranLoaded) {
                      return Text(
                        state.quran!.pageText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.scheherazadeNew(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    } else if (state.quranState is QuranError) {
                      return Text(
                          (state.quranState as QuranError).errorMessage);
                    }
                    return const Text('Unknown state');
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
