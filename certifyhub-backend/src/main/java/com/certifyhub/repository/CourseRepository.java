package com.certifyhub.repository;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CourseRepository {

	private final JdbcTemplate jdbcTemplate;

	public CourseRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<Map<String, Object>> getCourses(Integer userId) {

		String sql = """
				SELECT
				    cm.course_id,
				    cm.course_name,
				    COALESCE(ucr.course_completed,'N') AS course_completed,
				    COALESCE(ucr.exam_status,'NOT_ATTEMPTED') AS exam_status
				FROM course_master cm
				LEFT JOIN user_course_result ucr
				    ON cm.course_id = ucr.course_id
				    AND ucr.user_id = ?
				WHERE cm.active_flag='Y'
				ORDER BY cm.course_id
				""";

		return jdbcTemplate.queryForList(sql, userId);
	}

	public Map<String, Object> getCourse(Integer courseId) {

		String sql = """
				SELECT
				    course_id,
				    course_name,
				    course_content
				FROM course_master
				WHERE course_id = ?
				""";

		List<Map<String, Object>> result = jdbcTemplate.queryForList(sql, courseId);

		return result.isEmpty() ? null : result.get(0);
	}

	public Integer getUserCourseCount(Integer userId, Integer courseId) {

		String sql = """
				SELECT COUNT(*)
				FROM user_course_result
				WHERE user_id = ?
				AND course_id = ?
				""";

		return jdbcTemplate.queryForObject(sql, Integer.class, userId, courseId);
	}

	public void insertCourseCompletion(Integer userId, Integer courseId) {

		String sql = """
				INSERT INTO user_course_result
				(
				    user_id,
				    course_id,
				    course_completed
				)
				VALUES
				(
				    ?,
				    ?,
				    'Y'
				)
				""";

		jdbcTemplate.update(sql, userId, courseId);
	}

	public void updateCourseCompletion(Integer userId, Integer courseId) {

		String sql = """
				UPDATE user_course_result
				SET course_completed = 'Y'
				WHERE user_id = ?
				AND course_id = ?
				""";

		jdbcTemplate.update(sql, userId, courseId);
	}
}