package com.mgrg.hrm.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface BCommand {

	void execute(Model model, HttpServletRequest request);
}
