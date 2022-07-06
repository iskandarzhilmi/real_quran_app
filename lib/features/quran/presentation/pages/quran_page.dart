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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Page Number',
                    ),
                    keyboardType: TextInputType.number,
                    
                    onChanged: (value) {
                      context.read<QuranBloc>().add(
                            QuranPagePicked(pageNumber: int.parse(value)),
                          );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<QuranBloc, QuranStateModel>(builder: (context, state) {
              if (state.quranState is QuranInitial) {
                return Center(
                  child: Column(
                    children: const [
                      Text('Please enter a page number'),
                    ],
                  ),
                );
              } else if (state.quranState is QuranLoading) {
                return const CircularProgressIndicator();
              } else if (state.quranState is QuranLoaded) {
                return Text(
                  state.quran!.pageText,
                  style: GoogleFonts.scheherazadeNew(
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              } else if (state.quranState is QuranError) {
                return const Text('QuranError');
              }
              return const Text('Unknown state');
            }),
          ],
        ),
      ),
    );
  }
}
