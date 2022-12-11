const String baseUrl =
    'academind-shop-62964-default-rtdb.europe-west1.firebasedatabase.app';

const String getProducts = '/products.json';
String productsDelete(String id) => '/products/$id.json';
String productsUpdate(String id) => '/products/$id.json';

String addUserFavorite(String userId, String productId) =>
    '/userFavorites/$userId/$productId.json';

String getUserFavorites(String userId) => '/userFavorites/$userId.json';

String orders(String userId) => '/orders/$userId.json';

String webApiKey = 'AIzaSyBocdCd6eqvhqw-iakxlC60mkWMhUffRlY';
final String signUp =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$webApiKey';
final String signIn =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$webApiKey';
