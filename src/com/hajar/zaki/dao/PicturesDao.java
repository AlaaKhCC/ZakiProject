/**
 * 
 */
package com.hajar.zaki.dao;

import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.ProductPicture;
import com.mysql.jdbc.Blob;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class PicturesDao implements MainInterface<ProductPicture> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(ProductPicture t) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public ProductPicture getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public ProductPicture getPicturePerProductId(String id) {
		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 ProductPicture prodPic= new ProductPicture();
		try{
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_PICTURE_IDPROD);
             psmt.setString(1, id);
             resultSet= psmt.executeQuery();
            if(resultSet.next()){
               InputStream binaryStream = resultSet.getBinaryStream("image");
               byte[] arrayImg = resultSet.getBytes("image");
               String idProd= resultSet.getString("productId");  
               String imageFileName = resultSet.getString("imageFileName");
               
               prodPic=new ProductPicture(idProd, arrayImg ,imageFileName);
            }
            con.close();
           
       }catch(Exception ex){
           ex.printStackTrace();
       }
		return prodPic;
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public List<ProductPicture> getAllOfObjects() throws SQLException {
		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 ArrayList<ProductPicture> picturesOfProducts= new ArrayList<>();
		try{
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
             ResultSet rs = statement.executeQuery(Constatns.SELECT_FROM_PRODUCTS_PICTURES);
             if(rs.next()){
                byte[] img = rs.getBytes("image");
                String idProd= rs.getString("productId");
                String fileName= rs.getString("imageFileName"); 
                ProductPicture prodPic=new ProductPicture(idProd, img,fileName);
                if(prodPic !=null) picturesOfProducts.add(prodPic);  
            }
            
            con.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
		return picturesOfProducts;
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#deleteObject(long)
	 */
	@Override
	public void deleteObject(long id) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public ProductPicture updateObj(ProductPicture t) {
		// TODO Auto-generated method stub
		return null;
	}

}
