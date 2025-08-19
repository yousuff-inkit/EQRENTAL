package com.selcarInternal;



import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.codec.binary.Base64;

public class ManipulateImage {

	// Decode String into an Image
	public  void convertStringtoImage(String encodedImageStr,String fileName,String path ) {

		try {
			
			// Decode String using Base64 Class
			byte[] imageByteArray = Base64.decodeBase64(encodedImageStr); 
			System.out.println("Image Successfully Stored");
			// Write Image into File system - Make sure you update the path
			FileOutputStream imageOutFile = new FileOutputStream(path+"/attachment/CHH/"+fileName);
			imageOutFile.write(imageByteArray);

			imageOutFile.close();
			System.out.println("Image Successfully Stored");
			
		} catch (FileNotFoundException fnfe) {
			System.out.println("Image Path not found" + fnfe);
		} catch (Exception ioe) {
			ioe.printStackTrace();
		}

	}

}

