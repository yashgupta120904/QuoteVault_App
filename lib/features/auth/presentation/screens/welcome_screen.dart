import 'package:flutter/material.dart';
import 'package:quotevault/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
 
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 6,
            vertical: SizeConfig.blockHeight * 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(),


              /// Logo + Titles
              Column(
                children: [
                  Container(
                    width: SizeConfig.blockWidth * 22,
                    height: SizeConfig.blockWidth * 22,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.format_quote_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  Text(
                    'QuoteVault',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 34,
                        ),
                  ),
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 34,
                        ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  Text(
                    'YOUR DAILY SOURCE OF\nINSPIRATION',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          letterSpacing: 2,
                          height: 1.6,
                        ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockHeight * 2.5),

              /// Quote Card
              Container(
                width: double.infinity,
                height: SizeConfig.blockHeight * 25,
                padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0xFF6B5B95),
                              const Color(0xFF2A3D5C),
                            ]
                          : [
                              AppColors.accentOrange.withOpacity(0.3),
                              AppColors.primaryColor.withOpacity(0.5),
                            ],
                    ),
                    border: Border.all(
                      color: isDark
                          ? AppColors.lightBg
                          : AppColors.darkBorder.withOpacity(0.6),
                      width: 3,
                    ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.blockHeight * 5),
                    Text(
                      '"The journey of a thousand\nmiles begins with one step."',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            height: 1.7,
                          ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 1.9),
                    Text(
                      'LAO TZU',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 2.5),

              /// Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: SizeConfig.blockHeight * 7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: Text(
                        'Get Started',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockHeight * 2.5),

              /// Terms
              Text(
                'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:quotevault/routes/app_routes.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ✅ VERY IMPORTANT: initialize here
//     SizeConfig.init(context);

//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: SizeConfig.blockWidth * 6,
//             vertical: SizeConfig.blockHeight * 4,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(),

//               /// Logo + Titles
//               Column(
//                 children: [
//                   Container(
//                     width: SizeConfig.blockWidth * 22,
//                     height: SizeConfig.blockWidth * 22,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                     alignment: Alignment.center,
//                     child: const Icon(
//                       Icons.format_quote_rounded,
//                       color: Colors.white,
//                       size: 48,
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.blockHeight * 2.5),
//                   Text(
//                     'QuoteVault',
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                           fontSize: 34,
//                         ),
//                   ),
//                   Text(
//                     'Welcome',
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                           fontSize: 34,
//                         ),
//                   ),
//                   SizedBox(height: SizeConfig.blockHeight * 2.5),
//                   Text(
//                     'YOUR DAILY SOURCE OF\nINSPIRATION',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           fontSize: 15,
//                           letterSpacing: 2,
//                           height: 1.6,
//                         ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: SizeConfig.blockHeight * 2.5),

//               /// Quote Card
//               Container(
//                 width: double.infinity,
//                 height: SizeConfig.blockHeight * 25,
//                 padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(28),
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: isDark
//                         ? [
//                             const Color(0xFF6B5B95),
//                             const Color(0xFF2A3D5C),
//                           ]
//                         : [
//                             AppColors.accentOrange.withOpacity(0.3),
//                             AppColors.primaryColor.withOpacity(0.5),
//                           ],
//                   ),
//                   border: Border.all(
//                     color: isDark
//                         ? AppColors.lightBg
//                         : AppColors.darkBorder.withOpacity(0.6),
//                     width: 3,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: SizeConfig.blockHeight * 5),
//                     Text(
//                       '"The journey of a thousand\nmiles begins with one step."',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontSize: 21,
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.italic,
//                             height: 1.7,
//                           ),
//                     ),
//                     SizedBox(height: SizeConfig.blockHeight * 1.9),
//                     Text(
//                       'LAO TZU',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             fontSize: 13,
//                             letterSpacing: 2,
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: SizeConfig.blockHeight * 2.5),

//               /// Button
//               SizedBox(
//                 width: double.infinity,
//                 height: SizeConfig.blockHeight * 7,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, AppRoutes.login);
//                   },
//                   child: Text(
//                     'Get Started',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: SizeConfig.blockHeight * 2.5),

//               /// Terms
//               Text(
//                 'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
