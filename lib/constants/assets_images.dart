class AppImages {
  static String baseAssetUrl = "assets/images/";
  static String logo = baseAssetUrl + "logo.png";
  static String logoBckg = baseAssetUrl + "logo_bck.png";
  static String splashLogo = baseAssetUrl + "splash_logo.png";
  static String splashOne = baseAssetUrl + "splashone.png";
  static String splashTwo = baseAssetUrl + "splashtwo.png";
  static String splashThree = baseAssetUrl + "splashthree.png";
  static String regSuccesImg = baseAssetUrl + "reg_success_img.svg";
  static String resetSuccessImg = baseAssetUrl + "reg_success_img.svg";
  static String reapQuickImg = baseAssetUrl + "reapquick_bkg.jpg";
  static String reapPlusImg = baseAssetUrl + "reapplus_bkg.jpg";
  static String reapMaxImg = baseAssetUrl + "reapmax_bkg.jpg";
  static String reapGoalImg = baseAssetUrl + "goal_bkg.jpg";
  static String reapPromoImg = baseAssetUrl + "";
  static String avatarImg = baseAssetUrl + "avatar.png";
  static String idCardImage = baseAssetUrl + 'id_card_image.svg';
  static String congratulationsImage =
      baseAssetUrl + 'congratulations_image.svg';
  static String halalModeImage = baseAssetUrl + 'halal_mode_image.svg';
  //static String homeBalCard = baseAssetUrl + "home_balance_card.svg";
  static String walletBalCard = baseAssetUrl + "wallet_balance_card.png";
  static String totalBalCard = baseAssetUrl + "total_balance_card.png";
  static String generalError = baseAssetUrl + "error.svg";
  static String failed = baseAssetUrl + "failed.svg";
  static String networkError = baseAssetUrl + "network_error.svg";
  static String successful = baseAssetUrl + "successful.svg";
  static String topUpFailed = baseAssetUrl + 'top_up_failed.svg';
  static String smallLogo = baseAssetUrl + 'small_logo.svg';
  static String savingsImage = baseAssetUrl + 'savings_image.svg';
  static String rankingImage = baseAssetUrl + 'ranking_image.png';
  static String noBankCardImage = baseAssetUrl + 'no_bank_card.svg';
  static String searchEmptyImage = baseAssetUrl + 'search_empty.svg';
  static String referAndEarnHeader = baseAssetUrl + 'refer_and_earn_header.png';
  static String referAndEarnImage = baseAssetUrl + 'refer_and_earn_image.svg';

  static getPlanImage(String id) {
    switch (id) {
      case "2":
        return reapQuickImg;
      case "3":
        return reapPlusImg;
      case "4":
        return reapMaxImg;
      case "5":
        return reapGoalImg;
      case "6":
        return reapGoalImg;
      case "7":
        return reapPromoImg;
      default:
        return reapQuickImg;
    }
  }
}

class AppCountry {
  static String baseAssetUrl = "assets/country/";
  static String ngn = baseAssetUrl + "ng.png";
  static String gh = baseAssetUrl + "gh.png";
}
