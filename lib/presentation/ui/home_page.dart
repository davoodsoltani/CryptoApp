import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_flutter/presentation/ui/ui_helper/home_pageview.dart';
import 'package:crypto_flutter/presentation/ui/ui_helper/theme_swicher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/data_source/response_model.dart';
import '../../../logic/providers/crypto_data_provider.dart';
import '../../data/models/crypto_model/CryptoData.dart';
import '../heplers/decimal_rounder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(
    initialPage: 0,
  );

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = Provider.of<CryptoDataProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: const [
          ThemeSwitcher(),
        ],
        title: const Text("Exchange"),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 10, dotHeight: 10),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: MarqueeText(
                  text: const TextSpan(
                    text:
                        '🔊 this is place for news in application 🔊 this is place for news in application 🔊 this is place for news in application ',
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                  speed: 30,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.green[700]),
                      child: const Text("buy",
                          style: TextStyle(color: Colors.white)),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.red[700]),
                      child: const Text(
                        "sell",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5, top: 10),
                child: Row(
                  children: [
                    Consumer<CryptoDataProvider>(
                      builder: (context, cryptoDataProvider, child) {
                        return Wrap(
                          spacing: 8,
                          children: List.generate(_choicesList.length, (index) {
                            return ChoiceChip(
                                label: Text(_choicesList[index],
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                selected:
                                    cryptoDataProvider.defaultChoiceIndex ==
                                        index,
                                selectedColor: Colors.blue,
                                onSelected: (value) {
                                  switch (index) {
                                    case 0:
                                      cryptoProvider.getTopMarketCapData();
                                      break;
                                    case 1:
                                      cryptoProvider.getTopGainersData();
                                      break;
                                    case 2:
                                      cryptoProvider.getTopLosersData();
                                      break;
                                  }
                                });
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Consumer<CryptoDataProvider>(
                    builder: (context, cryptoDataProvider, child) {
                  switch (cryptoDataProvider.state.status) {
                    case Status.LOADING:
                      return SizedBox(
                        height: 80,
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8, left: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                      );
                    case Status.COMPLETED:
                      List<CryptoData>? model = cryptoDataProvider
                          .dataFuture.data!.cryptoCurrencyList;

                      // print(model![0].symbol);
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            var number = index + 1;
                            var tokenId = model![index].id;

                            MaterialColor filterColor =
                                DecimalRounder.setColorFilter(
                                    model[index].quotes![0].percentChange24h);

                            var finalPrice = DecimalRounder.removePriceDecimals(
                                model[index].quotes![0].price);

                            // percent change setup decimals and colors
                            var percentChange =
                                DecimalRounder.removePercentDecimals(
                                    model[index].quotes![0].percentChange24h);

                            Color percentColor =
                                DecimalRounder.setPercentChangesColor(
                                    model[index].quotes![0].percentChange24h);
                            Icon percentIcon =
                                DecimalRounder.setPercentChangesIcon(
                                    model[index].quotes![0].percentChange24h);

                            return SizedBox(
                              height: height * 0.075,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      number.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 15),
                                    child: CachedNetworkImage(
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        height: 32,
                                        width: 32,
                                        imageUrl:
                                            "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) {
                                          return const Icon(Icons.error);
                                        }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model[index].name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Text(
                                          model[index].symbol!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            filterColor, BlendMode.srcATop),
                                        child: SvgPicture.network(
                                            "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$$finalPrice",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(
                                                "$percentChange%",
                                                style: GoogleFonts.ubuntu(
                                                    color: percentColor,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: 10);
                    case Status.ERROR:
                      return Text(cryptoDataProvider.state.message);
                    default:
                      return Container();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
