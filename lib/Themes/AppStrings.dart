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
var BUSINESS_CATEGORYID = "BUSINESS_CATEGORYID";

/* USER API */
const API_USER = "user/";
const API_REGISTER = "user/register";
const API_LOGIN = 'login';

/* product API's */

const PRODUCT_IMAGE_PATH = "http://10.20.0.111:3000/images/";
const defaultErrorImageUrl = "assets/images/noImage.jpg";
const API_PRODUCT = "product/";
const API_GET_ALL_PRODUCTS = API_PRODUCT + "getAllProductDetails/";
const API_SEARCHPRODUCTS = API_PRODUCT + "searchProducts/";
const API_POPULARPRODUCTS = API_PRODUCT + "popularProducts/";
const API_GETALLCATEGORIES = API_PRODUCT + "getAllCategories";
const API_GET_LATEST_PRODUCTS = API_PRODUCT + "latestProducts";

/**BOOKING : SLOT API's */
const API_GET_SLOTS_BY_DATE = API_PRODUCT + "getSlotsByDateAndProductId";

/**BOOKING : DAY API's */
const API_BOOKING = "booking/";
var API_ADD_TO_CART = API_BOOKING + "addToCart";
const API_GET_CART = API_BOOKING + "cart";
const API_REMOVE_FROM_CART = API_BOOKING + "removeFromCart";
const API_CONFIRM_BOOKING = API_BOOKING + "confirmBooking";
var API_GET_ALL_ORDERS = API_BOOKING + "orders";
var API_CANCEL_ORDER_BY_USER = API_BOOKING + "cancelBooking";

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
