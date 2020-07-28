package com.mgrg.hrm.excel;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.D;
import com.mgrg.hrm.admin.AdminMemDTO;
import com.mgrg.hrm.admin.IAdminDAO;
import com.mgrg.hrm.login.C;
import com.mgrg.hrm.staff.StaffDAO;
import com.mgrg.hrm.staff.StaffDTO;

@Controller
public class ExcelController {

	//테스트 용입니다.
	@GetMapping("/boardList")
	public String gobobo(Model model) {
//		IAdminDAO dao = C.sqlSession.getMapper(IAdminDAO.class);
//		List<AdminMemDTO> dto = dao.select();
//		model.addAttribute("list", dto);
		StaffDAO dao2 = D.sqlSession.getMapper(StaffDAO.class);
		List<StaffDTO> list = dao2.select();
		model.addAttribute("list", list);
		
		return "boardList";
	}
	
	
	@RequestMapping(value = "/excelDown")
	public void excelDown(HttpServletResponse response, Model model, HttpServletRequest request) throws Exception {
//		IAdminDAO dao = C.sqlSession.getMapper(IAdminDAO.class);
//		List<AdminMemDTO> dto = dao.select();
//		model.addAttribute("list", dto);

		StaffDAO dao2 = D.sqlSession.getMapper(StaffDAO.class);
		List<StaffDTO> list = dao2.select();
		model.addAttribute("list", list);
		
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("사원 목록");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이름");
	    
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("생년월일");
	    
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("휴대폰 번호");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("E-Mail");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("아이디");

	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("입사날짜");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("연봉");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("부서");

	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직책");

	    cell = row.createCell(9);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주소");

	    // 데이터 부분 생성
	    for(StaffDTO vo : list) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellValue(vo.getName());
	        cell = row.createCell(1);
	        cell.setCellValue(vo.getBirthday().toString());
	        cell = row.createCell(2);
	        Integer phoneNum = vo.getPhonenum();
	        if(phoneNum != null) {
	        	String telNum = phoneNum.toString();
	        	StringBuffer formatNum = new StringBuffer();
	        	if(telNum.length() == 8){
	        		formatNum.append(telNum.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2"));
				} else if(telNum.length() == 10){
					formatNum.append("0");
					formatNum.append(telNum.replaceFirst("(^[0-9]{2})([0-9]{4})([0-9]{4})$", "$1-$2-$3"));
				} else {
					formatNum.append("0");
					formatNum.append(telNum.replaceFirst("(^2|[0-9]{2})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3"));
				}
	        	cell.setCellValue(formatNum.toString());
	        }
	        cell = row.createCell(3);
	        cell.setCellValue(vo.getEmail());
	        cell = row.createCell(4);
	        cell.setCellValue(vo.getId());
	        cell = row.createCell(5);
	        cell.setCellValue(vo.getHiredate().toString());
	        cell = row.createCell(6);
	        cell.setCellValue(vo.getSalary());
	        cell = row.createCell(7);
	        cell.setCellValue(vo.getDepartment());
	        cell = row.createCell(8);
	        cell.setCellValue(vo.getPosition());
	        cell = row.createCell(9);
	        StringBuffer address = new StringBuffer();
	        String ZoneCode = "" + vo.getAddrZoneCode();
	        if(vo.getAddrZoneCode() != null)
	        	address.append(vo.getAddrZoneCode());
	        if(vo.getAddrRoad() != null)
	        	address.append(" " + vo.getAddrRoad());
	        if(vo.getAddrDetail() != null)
	        	address.append(" " + vo.getAddrDetail());
	        cell.setCellValue(address.toString());
	    }
	    
		// 셀 너비 설정
		for (int i = 0; i < 10; i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + (short) 1024);
		}

	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=EmployeeList.xls");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();

	}

}
