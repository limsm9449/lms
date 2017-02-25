package com.qp.lms.common;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

/*
 * 메일 발송 Class
 */
public class PlainMail {

	private Message message = null;

	private String mailServer;
	private String sender;
	private String senderName;
	private String username;            
	private String password;   
	
	private String subject = null;
	private String content = null;
	private String receiver = null;
	
	private Address senderAddress = null;
	private Address[] receiverAddress = null;
	
	public PlainMail() throws Exception {
		//System.out.println("mailServer : " + SessionUtil.getProperties("mailServer"));
		
		mailServer = SessionUtil.getProperties("mailServer");
		sender = SessionUtil.getProperties("mailSender");
		senderName = SessionUtil.getProperties("mailSenderName");
		username =  SessionUtil.getProperties("mailUsername");            
		password = SessionUtil.getProperties("mailPassword");   		
	}
	
	public void SendMail() throws UnsupportedEncodingException,MessagingException,Exception {
		if ( sender == null || subject == null || content == null || receiver == null )
			throw new NullPointerException("error");
		
		initializeMailServer();
		initializeSender();
		initializeReceiver();
		
		Send();
	}
	
	/*
	 * 메일 서버 초기화
	 */
	private void initializeMailServer() {
		Properties properties = new Properties();
		properties.put("mail.smtp.host", mailServer);
		properties.put("mail.transport.protocol", "smtp");        
		properties.put("mail.smtp.starttls.enable","true");       
		properties.put("mail.smtp.port","587");       
		properties.put("mail.smtp.auth", "true");          

		Authenticator auth = new SMTPAuthenticator();
		 
		Session s = Session.getDefaultInstance(properties,auth);
		message = new MimeMessage(s);
	}

	/*
	 * 구글 사용자 메일 계정 아이디/패스 정보     
	 */    
	private class SMTPAuthenticator extends javax.mail.Authenticator {        
		public PasswordAuthentication getPasswordAuthentication() {            
			return new PasswordAuthentication(username, password);        
		}    
	}

	
	/*
	 * 보내는 사람 초기화
	 */
	private void initializeSender() throws UnsupportedEncodingException {
		if ( senderName == null )
			senderName = sender;
		
		senderAddress = new InternetAddress(sender, new String(senderName.getBytes("ISO-8859-1"),"UTF-8"));
	}
	
	/*
	 * 받는사람 초기화
	 */
	private void initializeReceiver() throws AddressException {
		ArrayList<String> receiverList = new ArrayList<String>();
		StringTokenizer stMailAddress = new StringTokenizer(receiver, ";");
		while ( stMailAddress.hasMoreElements() ) 
			receiverList.add(stMailAddress.nextToken());
		
		receiverAddress = new Address[receiverList.size()];
		for ( int i = 0; i < receiverList.size(); i++ ) 
			receiverAddress[i] = new InternetAddress(receiverList.get(i));
	}
	
	/*
	 * 메일 전송
	 */
	private void Send() throws MessagingException, UnsupportedEncodingException,Exception {
		System.out.println("메일발송 - Start");
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(senderAddress);
		message.setRecipients(Message.RecipientType.TO, receiverAddress);
		message.setSubject(MimeUtility.encodeText(subject,"UTF-8","B"));
		message.setContent(content,"text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
		
		Transport.send(message);
		System.out.println("메일발송 - End");
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}
	

}

