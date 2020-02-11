/**
 * 
 */
package com.hajar.zaki.model;

import java.io.InputStream;
import java.io.Serializable;

/**
 * @author Hajar Amara
 *
 */
public class ProductPicture implements Serializable {
	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodId;
	  private byte[] img;
	  private String imageFileName;
	  private InputStream imgInput;

	  
	public ProductPicture(String prodId, byte[] img, String imageFileName) {
		super();
		this.prodId = prodId;
		this.img = img;
		this.imageFileName=imageFileName;
	}
	/**
	 * 
	 */
	public ProductPicture() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * @param idProd
	 * @param img
	 */
	public ProductPicture(String idProd, InputStream img,String imageFileName) {
		super();
		this.prodId =idProd;
		this.setImgInput(img);
	}
	/**
	 * @return the prodId
	 */
	public String getProdId() {
		return prodId;
	}
	/**
	 * @param prodId the prodId to set
	 */
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	/**
	 * @return the img
	 */
	public byte[] getImg() {
		return img;
	}
	/**
	 * @param img the img to set
	 */
	public void setImg(byte[] img) {
		this.img = img;
	}
	/**
	 * @return the imgInput
	 */
	public InputStream getImgInput() {
		return imgInput;
	}
	/**
	 * @param imgInput the imgInput to set
	 */
	public void setImgInput(InputStream imgInput) {
		this.imgInput = imgInput;
	}
	  
	/**
	 * @return the imageFileName
	 */
	public String getImageFileName() {
		return imageFileName;
	}
	/**
	 * @param imageFileName the imageFileName to set
	 */
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	
}
