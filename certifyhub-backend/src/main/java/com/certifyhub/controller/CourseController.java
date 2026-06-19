package com.certifyhub.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.certifyhub.dto.CourseCompletionRequest;
import com.certifyhub.dto.CourseDetailDto;
import com.certifyhub.dto.CourseDto;
import com.certifyhub.service.CourseService;

@RestController
public class CourseController {

	private final CourseService courseService;

	public CourseController(CourseService courseService) {
		this.courseService = courseService;
	}

	@GetMapping("/api/courses/{userId}")
	public List<CourseDto> getCourses(@PathVariable Integer userId) {

		return courseService.getCourses(userId);
	}

	@GetMapping("/api/course/{courseId}")
	public CourseDetailDto getCourse(@PathVariable Integer courseId) {

		return courseService.getCourse(courseId);
	}

	@PostMapping("/api/course/complete")
	public String completeCourse(@RequestBody CourseCompletionRequest request) {
		return courseService.markCourseComplete(request.getUserId(), request.getCourseId());
	}
}