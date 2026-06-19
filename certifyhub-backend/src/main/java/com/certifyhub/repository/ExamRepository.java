package com.certifyhub.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ExamRepository {
	private final JdbcTemplate jdbcTemplate;

	public ExamRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void saveExamResult(Integer userId, Integer courseId, Integer percentage, String examStatus) {

		String sql = """
				UPDATE user_course_result
				SET percentage = ?,
				    exam_status = ?,
				    issue_date = CURRENT_DATE
				WHERE user_id = ?
				AND course_id = ?
				""";

		jdbcTemplate.update(sql, percentage, examStatus, userId, courseId);
	}
}
