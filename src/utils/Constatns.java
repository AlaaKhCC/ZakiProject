/**
 * 
 */
package utils;

/**
 * @author Hajar Amara
 *
 */
public class Constatns {
	///////////////// Parameters for DB Connection
	
	public static final String DATABASE_DRIVER = "com.mysql.jdbc.Driver";
	public static final String DATABASE_URL = "jdbc:mysql://35.239.168.95:3306/zakiDB";
	public static final String USERNAME = "root";
	public static final String PASSWORD = "zaki123@";
	public static final String MAX_POOL = "500"; // set your own limit
	
	///////////////////////////////test details user
	public static final String PASS_TEST="us@0t$g4";
	public static final String USER_TEST="user@gmail.com";
	
	////////////////////////////////////Status Order
	public static final String STATUS_DONE="DONE";
	public static final String STATUS_IN_PROGRESS="IN_PROGRESS";

	
	////////////////////////////////////////
	public static final int PHONE_NUMBER_DEFAULT_VALUE=0;
	
	///////////////////// START QUIRIES
	
	/////////USERS//////////
	  public static String SELECT_FROM_USERS="select email,pass from Users";
	  public static String SELECT_FROM_USERS_NAMES="select userName,surName from Users";
	  public static String SELECT_ALL_USER="select * from Users where email= (?)";
	  public static String UPDATE_USER = "UPDATE Users SET userName = ?,surName = ?,pass = ?,addressId = ?,phoneNumber = ?,gender = ? WHERE email = ?" ;
	  public static String UPDATE_USER_IMAGE = "UPDATE Users SET profileImage = ? WHERE email = ?" ;
	  public static String SelectImage = "select * from UderImage where userEmail=?";
	  public static String INSERT_INTO_USERS="insert into Users(email,userName,surName,pass,addressId,phoneNumber) values (?,?,?,?,?,?)";
	  public static String InsertImgUser = "insert into UserImage(userEmail,image) values (?,?)";
	  ///////// ADDRESS////////
	  //inner join
	  /*
	   * ;
	   */
	  public static String SELECT_FROM_ADDRESS_CITY="SELECT Address.addressID FROM Address  INNER JOIN City ON Address.cityId=City.cityID";
	  public static String SELECT_FROM_ADDRESS="select addressID from Address where cityId=";
	  public static String INSERT_INTO_ADDRESS="insert into Address(addressID,cityId) values (?,?)";
	//////// CITY /////////
	  public static String SELECT_FROM_CITY="select * from City";
	  public static String SELECT_CITYNAME="select cityName from City where cityID=";
	  public static String SELECT_CITYID_perName="select cityId from City where cityName=";
	  public static String SELECT_CITYID_ADDRESSID="select cityId from Address where addressID=";



//	  public static String SELECT_FROM_CITY="select cityID,cityName from City where cityName like(?)";
	  //public static String INSERT_INTO_USERS="insert into Users(email,userName,surName,pass,addressId) values (?,?,?,?,0)";
	///////  CUSTOMER /////////////
	  public static String SELECT_FROM_CUSTOMER="select customer_email from Customer";
	  public static String INSERT_INTO_CUSTOMER="insert into Customer(customer_email) values (?)";

	///////  SUPPLIER /////////////
	  public static String SELECT_FROM_SUPPLLIER="select *  from `Supplier` ";
	  public static String INSERT_INTO_SUPPLIER="insert into Supplier(supplier_email) values (?)";
	  public static String UPDATE_SUPPLIER = "UPDATE Supplier SET foodDescription= ? where supplier_email= ?" ;
				
	////// ORDER ////////////
	  public static String INSERT_INTO_ORDER="insert into `Order` (`customer_mail`,`prodId`,`quantity`) values (?,?,?)";
	  public static String DELETE_ORDER = "DELETE FROM `Order` WHERE `orderNumber`= ?";
	  public static String DELETE_ALL_ORDERS = "DELETE FROM `Order` where `customer_mail` = (?)";
	  public static String SELECT_FROM_ORDER_PER_SUPPLIER = "SELECT * FROM `Order` join `OrderDetail` on Order.orderNumber=OrderDetail.numberOrder WHERE OrderDetail.status not in ('Done','WAIT_CONFIRMATION') and Order.prodId in (SELECT `productID` FROM `Product` WHERE `emailSupplier` =  ? )";
	  public static String SELECT_FROM_ORDER_PER_CUSTOMER = "SELECT * FROM `Order` join `OrderDetail` on Order.orderNumber=OrderDetail.numberOrder WHERE Order.customer_mail = ?";
	  public static String UPDATE_ORDER_STATUS = "UPDATE OrderDetail SET status = 'Done' where numberOrder=(?) ";
	  public static String UPDATE_ORDER_STATUS_Confirmation = "UPDATE OrderDetail SET status = 'IN_PROGRESS' where numberOrder=(?) and status='WAIT_CONFIRMATION' ";

	  ///// ORDERDETAILS
	  public static String SELECT_FROM_ORDERDETAILS="select * from OrderDetail where numberOrder=(?)";
	  public static String INSERT_INTO_ORDERDETAILS="insert into OrderDetail(numberOrder, orderDate,requiredDate,price, description,discount,status) values (?,?,?,?,?,?,?)";
	  public static String DELETE_ORDER_DETAILS = "DELETE FROM OrderDetail WHERE numberOrder=?";
	  public static String DELETE_All_ORDERS_CUSTOMER = "DELETE FROM OrderDetail WHERE numberOrder=?";


	////// PRODUCT
	  public static String SELECT_FROM_PRODUCT="select * from Product ";
	  public static String SELECT_FROM_PRODUCT_PerSup="select * from Product where productID = ?";
	  public static String SELECT_FROM_PRODUCT_NOTLIKED="select * from Product where productID not in (select prod_id from ProductCustomer where liked = 1 and mail_customer = ?)";//user not null
	  public static String SELECT_FROM_PRODUCTLiked="select * from Product where productID in (select prod_id from ProductCustomer where liked = 1 and mail_customer = ?) ";// user not null 
	  public static String SELECT_FROM_PRODUCT_PER_SUP="select * from Product where emailSupplier=(?)";
	  public static String SELECT_FROM_PRODUCT_PER_CAT="select * from Product where category=(?)";
	  public static String SELECT_FROM_PRODUCT_PER_NAME="select * from Product where prodName=(?)";
	  public static String SELECT_FROM_PRODUCT_PER_ID="select * from Product where productID=(?)";
	  public static String INSERT_INTO_PRODUCT="insert into Product(productID,prodName,emailSupplier,priceOfPiece,category,description) values (?,?,?,?,?,?)";
      public static String SELECT_FROM_PRODUCT_SALADS="SELECT * FROM Product WHERE category='salad'";
      public static String SELECT_FROM_PRODUCT_MAIN="SELECT * FROM Product WHERE category='mainCourse'";
      public static String SELECT_FROM_PRODUCT_SWEET="SELECT * FROM Product WHERE category in('sweet','cake')";
      public static String SELECT_FROM_PRODUCT_APPETIZERS="SELECT * FROM Product WHERE category='appetizers'";
      //////
      public static String SELECT_FROM_PRODUCT_SALADS_SUP="SELECT * FROM `Product` WHERE `category`='salad' AND `emailSupplier`=(?)";
      public static String SELECT_FROM_PRODUCT_MAIN_SUP="SELECT * FROM `Product` WHERE `category`='mainCourse' AND `emailSupplier`=(?)";
      public static String SELECT_FROM_PRODUCT_SWEET_SUP="SELECT * FROM `Product` WHERE `category`='sweet' AND `emailSupplier`=(?)";
      public static String SELECT_FROM_PRODUCT_APPETIZERS_SUP="SELECT * FROM `Product` WHERE `category`='appetizers' AND `emailSupplier`=(?)";
     
      public static String UPDATE_PRODUCT = "UPDATE Product SET prodName = ?, emailSupplier = ?, priceOfPiece = ?, category = ?, description = ? where productID = ?";
	  /////// product picture 
	  public static String SELECT_FROM_PRODUCTS_PICTURES="select * from PicturesOfProducts";
	  public static String SELECT_FROM_PRODUCT_PICTURE_IDPROD="select * from PicturesOfProducts where productId=(?)";
	  ////// productCustomer
	  public static String INSERT_INTO_PRODUCT_Customer="insert into ProductCustomer(prod_id,mail_customer,liked) values (?,?,?)";
      public static String SELECT_FROM_PRODUCT_CUSTOMER="SELECT * FROM ProductCustomer WHERE prod_id=? and mail_customer=?";
      public static String SELECT_FROM_PRODUCT_CUSTOMER_LIKE="SELECT * FROM ProductCustomer WHERE prod_id=? and mail_customer=? and liked ='1'";

      public static String UPDATE_PRODUCT_CUSTOMER_LIKE = "UPDATE `ProductCustomer` SET `liked` = ? WHERE `prod_id`= ? and `mail_customer`= ?";
	  public static String INSERT_INTO_PRODUCT_CUSTOMER_RATING="insert into ProductCustomer(prod_id,mail_customer,rate) values (?,?,?)";
      public static String SELECT_SUM_COUNT_PROD_RATE ="SELECT COUNT(mail_customer), SUM(rate), prod_id FROM ProductCustomer where prod_id = ?";
	  public static String INSERT_INTO_PRODUCT_CUSTOMER_COMMENT="insert into ProductCustomer(prod_id,mail_customer,comment) values (?,?,?)";
	  public static String UPDATE_PRODUCT_CUSTOMER_RATING = "UPDATE `ProductCustomer` SET `rate` = ? WHERE `prod_id`= ? and `mail_customer`= ?";
	  public static String UPDATE_PRODUCT_CUSTOMER_COMMENT = "UPDATE `ProductCustomer` SET `comment` = ? WHERE `prod_id`= ? and `mail_customer`= ?";
      public static String SELECT_FROM_PRODUCT_CUSTOMER_PER_SUP = "SELECT COUNT(mail_customer), SUM(rate), prod_id FROM ProductCustomer WHERE prod_id in (SELECT productID FROM Product where emailSupplier = ?) GROUP BY prod_id" ;
	  
	  ////////// MSG
	  public static String INSERT_INTO_MSG = "insert into messages (userEmail1,userEmail2, content, time) values (?,?,?,?)";
	  public static String SELECT_FROM_MSG ="select * from messages where userEmail2 = ? and userEmail1 = ?";
	  ////////////////////////////////////////////////////// END_QUIRIES
	 public static String INNER_JOIN_ORDER_PRODUCT_ODETAIL = "SELECT o.prodId as prodId, o.quantity as quantity, o.orderNumber as orderNumber, os.status as status, o.customer_mail as customer_mail"+
		 		"  FROM OrderDetails as os inner join Order as o on os.numberOrder= o.orderNumber"
		 		+" WHERE o.prodId IN (SELECT ProductId From Product as p inner join Order as o2 " + 
		 		"                     ON p.productId=o2.prodId)"
		 		+" and o.customer_mail=";

}
