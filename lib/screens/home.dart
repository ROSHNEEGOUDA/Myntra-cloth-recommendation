import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'package:flutter_myntra_clone/data_provider/home_data.dart';
import 'package:flutter_myntra_clone/utils/asset_constants.dart';
import 'package:card_swiper/card_swiper.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top Navigation Bar
          Container(
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                    Text(
                      'Myntra',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top Bar Scrolling Categories
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: HomeData.getTopbarAssets()
                  .map((e) => CachedImage(url: e, height: 89, width: 76))
                  .toList(),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  CachedImage(url: banner1, height: 361),
                  SizedBox(height: 15),
                  CachedImage(url: free_shipping, height: 47),
                  SizedBox(height: 15),

                  // Offer Banners
                  Row(
                    children: [
                      CachedImage(
                        url: banner2,
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 360,
                      ),
                      CachedImage(
                        url: banner3,
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 360,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  CachedImage(url: biggest_offers, height: 63),
                  SizedBox(height: 15),

                  // Horizontal List for Offers
                  Container(
                    height: 275,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: HomeData.getBiggestOffers()
                          .map((e) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: CachedImage(url: e, height: 273, width: 179),
                              ))
                          .toList(),
                    ),
                  ),

                  SizedBox(height: 15),
                  CachedImage(url: best_offers, height: 63),
                  SizedBox(height: 15),
                  buildOfferCard(context, kurta_offer, flipflop_offer, watch_offer, loungewear_offer),
                  SizedBox(height: 15),

                  CachedImage(url: festive_deals, height: 63),
                  SizedBox(height: 15),
                  buildOfferCard(context, seventy_off, under_399, buy_1_get_1, sixty_off),
                  SizedBox(height: 15),

                  CachedImage(url: daily_deals, height: 63),
                  SizedBox(height: 15),

                  // Daily Deals Scrolling
                  Container(
                    height: 265,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: HomeData.getDailyDeals()
                          .map((e) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: CachedImage(url: e, height: 260, width: 171),
                              ))
                          .toList(),
                    ),
                  ),

                  SizedBox(height: 15),
                  CachedImage(url: featured_brands, height: 63),
                  SizedBox(height: 15),

                  // Featured Brands Swiper
                  Container(
                    height: 360,
                    child: Swiper(
                      duration: 500,
                      itemWidth: double.infinity,
                      pagination: SwiperPagination(), // Fixed pagination dots
                      itemCount: HomeData.getFeaturedBrands().length,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedImage(url: HomeData.getFeaturedBrands()[index]);
                      },
                      autoplay: true,
                    ),
                  ),

                  SizedBox(height: 30),
                  Divider(color: Colors.black, thickness: 1, indent: 50, endIndent: 50),
                  SizedBox(height: 10),

                  // Quote Section
                  Text(
                    '"The great thing about fashion is that it always looks forward"',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Oscar De La Renta',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOfferCard(BuildContext context, String offer1, String offer2, String offer3, String offer4) {
    double width = MediaQuery.of(context).size.width * 0.45;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CachedImage(url: offer1, height: 186, width: width),
                CachedImage(url: offer2, height: 186, width: width),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CachedImage(url: offer3, height: 186, width: width),
                CachedImage(url: offer4, height: 186, width: width),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
