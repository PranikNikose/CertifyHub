package com.certifyhub.dto;

public class CourseDto {

	private Integer courseId;
	private String courseName;
	private String courseCompleted;
	private String examStatus;
	private String certificateAvailable;

	public Integer getCourseId() {
		return courseId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseCompleted() {
		return courseCompleted;
	}

	public void setCourseCompleted(String courseCompleted) {
		this.courseCompleted = courseCompleted;
	}

	public String getExamStatus() {
		return examStatus;
	}

	public void setExamStatus(String examStatus) {
		this.examStatus = examStatus;
	}

	public String getCertificateAvailable() {
		return certificateAvailable;
	}

	public void setCertificateAvailable(String certificateAvailable) {
		this.certificateAvailable = certificateAvailable;
	}
}