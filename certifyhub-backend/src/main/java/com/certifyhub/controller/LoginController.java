package com.certifyhub.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.certifyhub.dto.LoginRequest;
import com.certifyhub.dto.LoginResponse;
import com.certifyhub.service.LoginService;

@RestController
public class LoginController {

	private final LoginService loginService;

	public LoginController(LoginService loginService) {
		this.loginService = loginService;
	}

	@PostMapping("/api/login")
	public LoginResponse login(@RequestBody LoginRequest request) {
		return loginService.login(request);
	}
}