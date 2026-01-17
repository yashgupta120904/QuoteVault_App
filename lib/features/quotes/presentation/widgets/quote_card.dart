// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/utils/size_config.dart';

// // class QuoteCard extends StatelessWidget {
// //   final String quote;
// //   final String author;
// //   final bool isLiked;
// //   final Color accentColor;
// //   final VoidCallback onLike;
// //   final VoidCallback onShare;

// //   const QuoteCard({
// //     super.key,
// //     required this.quote,
// //     required this.author,
// //     required this.isLiked,
// //     required this.onLike,
// //     required this.onShare,
// //     this.accentColor = AppColors.accentGreen,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
// //         color: AppColors.darkSurfaceLight,
// //         border: Border.all(
// //           color: AppColors.darkBorder,
// //           width: 1,
// //         ),
// //       ),
// //       padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             quote,
// //             style: TextStyle(
// //               fontSize: SizeConfig.blockWidth * 3.3,
// //               fontWeight: FontWeight.w500,
// //               color: AppColors.darkTextPrimary,
// //               height: 1.5,
// //             ),
// //           ),
// //           SizedBox(height: SizeConfig.blockHeight * 1.5),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 author,
// //                 style: TextStyle(
// //                   fontSize: SizeConfig.blockWidth * 2.8,
// //                   fontWeight: FontWeight.w500,
// //                   color: AppColors.darkTextSecondary,
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   IconButton(
// //                     icon: Icon(
// //                       isLiked ? Icons.favorite : Icons.favorite_outline,
// //                       size: SizeConfig.blockWidth * 4,
// //                     ),
// //                     color:
// //                         isLiked ? accentColor : AppColors.darkTextSecondary,
// //                     onPressed: onLike,
// //                     padding: EdgeInsets.zero,
// //                     constraints: const BoxConstraints(),
// //                   ),
// //                   SizedBox(width: SizeConfig.blockWidth * 2),
// //                   IconButton(
// //                     icon: Icon(
// //                       Icons.share,
// //                       size: SizeConfig.blockWidth * 4,
// //                     ),
// //                     color: AppColors.darkTextSecondary,
// //                     onPressed: onShare,
// //                     padding: EdgeInsets.zero,
// //                     constraints: const BoxConstraints(),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// class QuoteCard extends StatelessWidget {
//   final String quote;
//   final String author;
//   final String genre;
//   final bool isLiked;
//   final Color accentColor;
//   final VoidCallback onLike;
//   final VoidCallback onShare;

//   const QuoteCard({
//     super.key,
//     required this.quote,
//     required this.author,
//     required this.genre,
//     required this.isLiked,
//     required this.onLike,
//     required this.onShare,
//     this.accentColor = AppColors.accentGreen,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
//         color: AppColors.darkSurfaceLight,
//         border: Border.all(
//           color: AppColors.darkBorder,
//           width: 1,
//         ),
//       ),
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// 📝 Quote
//           Text(
//             '"$quote"',
//             style: TextStyle(
//               fontSize: SizeConfig.blockWidth * 4,
//               fontWeight: FontWeight.w500,
//               color: AppColors.darkTextPrimary,
//               height: 1.5,
//               fontStyle: FontStyle.italic
//             ),
//           ),
//             SizedBox(height: SizeConfig.blockHeight * 1.2),

         
//           Text(
//             textAlign: TextAlign.justify,
//             "- $author",
//             style: TextStyle(
//               fontSize: SizeConfig.blockWidth * 2.8,
//               fontWeight: FontWeight.w500,
//               color: AppColors.darkTextSecondary,
//             ),
//           ),
         

//           /// 👤 Author + Actions
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /// 🔖 Genre pill (Action / Motivation)
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.blockWidth * 3,
//                   vertical: SizeConfig.blockHeight * 0.5,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.accentPurple.withOpacity(0.15),
//                   borderRadius:
//                       BorderRadius.circular(SizeConfig.blockWidth * 4),
//                 ),
//                 child: Text(
//                   genre,
//                   style: TextStyle(
//                     fontSize: SizeConfig.blockWidth * 2.4,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.accentPurple,
//                   ),
//                 ),
//               ),

//               Row(
//                 children: [
//                   /// ❤️ Like
//                   IconButton(
//                     icon: Icon(
//                       isLiked ? Icons.favorite : Icons.favorite_outline,
//                       size: SizeConfig.blockWidth * 4,
//                     ),
//                     color: isLiked ? AppColors.accentPurple : AppColors.darkTextSecondary,
//                     onPressed: onLike,
//                     padding: EdgeInsets.zero,
//                     constraints: const BoxConstraints(),
//                   ),

//                   SizedBox(width: SizeConfig.blockWidth * 2),

//                   /// 📤 Share
//                   IconButton(
//                     icon: Icon(
//                       Icons.share,
//                       size: SizeConfig.blockWidth * 4,
//                     ),
//                     color: AppColors.darkTextSecondary,
//                     onPressed: onShare,
//                     padding: EdgeInsets.zero,
//                     constraints: const BoxConstraints(),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class QuoteCard extends StatefulWidget {
  final String quote;
  final String author;
  final String genre;
  final bool isLiked;
  final Color accentColor;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    required this.genre,
    required this.isLiked,
    required this.onLike,
    required this.onShare,
    this.accentColor = AppColors.accentGreen,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        color: isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote Text
          Text(
            '"${ widget.quote}"',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 1.2),

          // Author
          Text(
            textAlign: TextAlign.justify,
            "- ${widget.author}",
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 2.8,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 1.5),

          // Genre + Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Genre Pill
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 3,
                  vertical: SizeConfig.blockHeight * 0.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentPurple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
                ),
                child: Text(
                  widget.genre,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 2.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentPurple,
                  ),
                ),
              ),

              // Like & Share Buttons
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
                      size: SizeConfig.blockWidth * 4,
                    ),
                    color: isLiked ? AppColors.accentPurple : AppColors.darkTextSecondary,
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                      widget.onLike();
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: SizeConfig.blockWidth * 2),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: SizeConfig.blockWidth * 4,
                    ),
                    color: AppColors.darkTextSecondary,
                    onPressed: widget.onShare,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}