import 'package:cuida_app/pages/detail_person/detail.person.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class WithImagePerson extends StatefulWidget {
  const WithImagePerson({
    Key? key,
    required this.personName,
    required this.personLastName,
    required this.personId,
    required this.personAge,
    required this.personGender,
    required this.urlPersonImage,
    this.isLoading,
  }) : super(key: key);

  final String personName;
  final String personLastName;
  final String personId;
  final String personAge;
  final String personGender;
  final String urlPersonImage;
  final bool? isLoading;

  @override
  State<WithImagePerson> createState() => _WithImagePersonState();
}

class _WithImagePersonState extends State<WithImagePerson> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;

    final styleCardPerson = GoogleFonts.poppins(
      fontSize: dz * 0.02,
      color: Colors.white.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPerson(
            personName: widget.personName,
            personGender: widget.personGender,
            personAge: widget.personAge,
            personId: widget.personId,
            personLastName: widget.personLastName,
          );
        }));
      },
      child: SizedBox(
        width: wz * 0.4,
        height: hz * 0.3,
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: widget.isLoading == false
              ? CachedNetworkImage(
                  imageUrl: widget.urlPersonImage.isNotEmpty
                      ? widget.urlPersonImage
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      width: wz * 0.2,
                      height: hz * 0.18,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.personName,
                            style: styleCardPerson,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      width: wz * 0.4,
                      height: hz * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.personName,
                            style: styleCardPerson,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: hz * 0.07,
                      left: wz * 0.13,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
