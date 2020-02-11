/**
 * 
 */
package com.hajar.zaki.model;

import java.util.Date;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;


/**
 * @author Hajar Amara
 *
 */
public class TestManaager {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		// loads configuration and mappings
        Configuration configuration = new Configuration().configure("hibernate.cfg.xml");
        ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
//        ServiceRegistry serviceRegistry = registry.buildServiceRegistry();
        serviceRegistry = new 
                StandardServiceRegistryBuilder().configure("hibernate.cfg.xml")
                                            .build();
                Metadata metadata = new MetadataSources(serviceRegistry)
                                    .getMetadataBuilder().build();
                SessionFactory sessionFactory = metadata.getSessionFactoryBuilder().build();   
         
        // builds a session factory from the service registry
//        SessionFactory sessionFactory = configuration.buildSessionFactory(serviceRegistry);
//         
//        // obtains the session
        Session session = sessionFactory.openSession();
        session.beginTransaction();
         
        // creates a Address entity
        AddressClass address=new AddressClass();
        address.setAddressId(2);
        address.setCityId(2);
        address.setPostalcode("30200000");
         
       
        // persists the book entity
        int addressId = (int) session.save(address);
         
        // gets the book entity back
        AddressClass addresstest = (AddressClass) session.get(AddressClass.class, addressId);
        System.out.println("Address id: " + addresstest.getAddressId());
        System.out.println("city: " + addresstest.getCityId());
         
       
         
        session.getTransaction().commit();
        session.close();       

	}

}
