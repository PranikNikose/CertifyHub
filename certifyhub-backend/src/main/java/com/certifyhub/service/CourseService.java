package com.certifyhub.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.certifyhub.dto.CourseDetailDto;
import com.certifyhub.dto.CourseDto;
import com.certifyhub.repository.CourseRepository;

@Service
public class CourseService {

	private final CourseRepository courseRepository;

	public CourseService(CourseRepository courseRepository) {
		this.courseRepository = courseRepository;
	}

	public List<CourseDto> getCourses(Integer userId) {

		List<Map<String, Object>> rows = courseRepository.getCourses(userId);

		List<CourseDto> response = new ArrayList<>();

		for (Map<String, Object> row : rows) {

			CourseDto dto = new CourseDto();

			dto.setCourseId((Integer) row.get("course_id"));
			dto.setCourseName((String) row.get("course_name"));
			dto.setCourseCompleted((String) row.get("course_completed"));
			dto.setExamStatus((String) row.get("exam_status"));

			dto.setCertificateAvailable("PASS".equalsIgnoreCase(dto.getExamStatus()) ? "Y" : "N");

			response.add(dto);
		}

		return response;
	}

	public CourseDetailDto getCourse(Integer courseId) {

		Map<String, Object> row = courseRepository.getCourse(courseId);

		if (row == null) {
			return null;
		}

		CourseDetailDto dto = new CourseDetailDto();

		dto.setCourseId((Integer) row.get("course_id"));
		dto.setCourseName((String) row.get("course_name"));
		dto.setCourseContent((String) row.get("course_content"));

		return dto;
	}

	public String markCourseComplete(Integer userId, Integer courseId) {
		Integer count = courseRepository.getUserCourseCount(userId, courseId);
		if (count == 0) {
			courseRepository.insertCourseCompletion(userId, courseId);
		} else {
			courseRepository.updateCourseCompletion(userId, courseId);
		}
		return "Course Completed Successfully";
	}
}