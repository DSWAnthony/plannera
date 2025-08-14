class ApiSanRemo {
  static const String baseUrl = "https://api-sanremo-kkgf.onrender.com/api";

  static const String baseAuthUrl = "$baseUrl/auth";
  static const String baseProductsUrl = "$baseUrl/products";
  static const String baseOrdersUrl = "$baseUrl/orders";
  static const String baseSuppliersUrl = "$baseUrl/suppliers";

  static const String login = "$baseAuthUrl/login";
  static const String logout = "$baseAuthUrl/logout";
  static const String register = "$baseAuthUrl/register";
  static const String getUser = "$baseAuthUrl/getUser";

  static const String getAllProducts = "$baseProductsUrl/getAllProducts";
  static const String createProduct = "$baseProductsUrl/createProduct";
  static String getProductById(String id) => "$baseProductsUrl/$id";

  static const String getAllSuppliers = "$baseSuppliersUrl/getAllSuppliers";
  static String getSupplierById(String id) => "$baseSuppliersUrl/$id";

  static const String createOrder = "$baseOrdersUrl/createOrder";
  static const String getAllOrders = "$baseOrdersUrl/getAllOrders";
  static String getOrderById(String id) => "$baseOrdersUrl/history/$id";
  static String updateOrderStatus(String id) =>
      "$baseOrdersUrl/updateOrderStatus/$id";
}
