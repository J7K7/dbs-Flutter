const APP_NAME = "Dynamic Booking System";

/*fonts*/
const fontPoppins = 'Poppins';
const fontPoppinsLight = 'Poppins-Light';
const fontPoppinsMedium = 'Poppins-Medium';
const fontPoppinsSemiBold = 'Poppins-SemiBold';
const fontPoppinsBold = 'Poppins-Bold';

/* font sizes*/
const fsCaption = 10.0;
const fsSmall = 12.0;
const fsNormal = 14.0;
const fsMedium = 16.0;
const fsLarge = 18.0;
const fsXLarge = 20.0;
const fsXXLarge = 24.0;
const fsXXXLarge = 32.0;

/*API Related Constant */
const BASEURL = "http://10.20.0.111:3000/";
const LIVEURL = "";

/*SharedPreferences Variables*/
const ISAUTOLOGIN = "ISAUTOLOGIN";
const LOGINDATA = "LOGINDATA";

/* USER API */
const API_USER = "user/";
const API_REGISTER = "user/register";
const API_LOGIN = 'login';

/* product API's */

const PRODUCT_IMAGE_PATH = "http://10.20.0.111:3000/images/";
const defaultErrorImageUrl = "assets/images/noImage.jpg";
const API_PRODUCT = "product/";
const API_GETPRODUCTLIST = API_PRODUCT + "getAllProductDetails/";

/* Error Message Strings */
const String apiGeneralErrorMsg = "Unable to connect. Please try again later.";
const String noInternetErrorMsg =
    "No internet connection. Please check your internet connection and try again.";
//Status code 400, 403, 404, 500, 503
const String apiServerErrorMsg = "Unable to connect. Please try again later.";
//Status code 401
const String apiUnAuthorizeAccessMsg = "Security Token expired. Retry login";
const String connectionTimeOutMsg = "Connection timed out.";

//Messages
const String recordNotFound = 'Record not found.';
