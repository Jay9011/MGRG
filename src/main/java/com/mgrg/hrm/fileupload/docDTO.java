package com.mgrg.hrm.fileupload;

public class docDTO {

	private int doc_uid;
	private String doc_title;
	private String doc_content;
	private String doc_file;
	public docDTO() {
		super();
	}
	public docDTO(int doc_uid, String doc_title, String doc_content, String doc_file) {
		super();
		this.doc_uid = doc_uid;
		this.doc_title = doc_title;
		this.doc_content = doc_content;
		this.doc_file = doc_file;
	}
	public int getDoc_uid() {
		return doc_uid;
	}
	public void setDoc_uid(int doc_uid) {
		this.doc_uid = doc_uid;
	}
	public String getDoc_title() {
		return doc_title;
	}
	public void setDoc_title(String doc_title) {
		this.doc_title = doc_title;
	}
	public String getDoc_content() {
		return doc_content;
	}
	public void setDoc_content(String doc_content) {
		this.doc_content = doc_content;
	}
	public String getDoc_file() {
		return doc_file;
	}
	public void setDoc_file(String doc_file) {
		this.doc_file = doc_file;
	}
	
	
}
