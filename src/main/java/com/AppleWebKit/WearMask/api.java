package com.AppleWebKit.WearMask;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import com.AppleWebKit.WearMask.JDBCUtil;

@RestController
@RequestMapping(value = "/api")
public class api {
	private boolean lecture = false;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	// 각 자리의 인공지능 SW에서 전송된 좌석 별 착석 및 마스크 착용 여부 처리 API
	// /api/setStdStatus, POST Only, JSON 형식으로  idx, good, bad, non 전송
	@RequestMapping(value = "/setStdStatus", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> setStdStatus(@RequestBody Map<String, String> list) {
		Map<String, String> out = new HashMap<String, String>();
		if(!lecture) {
			out.put("result","FAILED");
			out.put("reason","Lecture not started");
		}
		int dataInterval = 30;
		String idx = list.get("idx");
		int totalTime = Integer.parseInt(list.get("Time"));
		int goodCount = Integer.parseInt(list.get("Good"));
		int badCount = Integer.parseInt(list.get("Bad"));
		int nonCount = Integer.parseInt(list.get("Non"));
		int attendCount = goodCount + badCount + nonCount;
		
		try {
			conn = JDBCUtil.getConnect();
			
			String USER_GET = "SELECT * FROM studentstatus WHERE idx=?";
			pstmt = conn.prepareStatement(USER_GET);
			pstmt.setString(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				goodCount += rs.getInt("goodMaskTime");
				badCount += rs.getInt("badMaskTime");
				nonCount += rs.getInt("nonMaskTime");
				attendCount += rs.getInt("attendTime");
				String USER_SET = "UPDATE studentstatus SET attendTime=?, goodMaskTime=?, badMaskTime=?, nonMaskTime=? WHERE idx=?"; // 수집된 정보로 DB 갱신
				pstmt = conn.prepareStatement(USER_SET);
				pstmt.setString(1, Integer.toString(attendCount));
				pstmt.setString(2, Integer.toString(goodCount));
				pstmt.setString(3, Integer.toString(badCount));
				pstmt.setString(4, Integer.toString(nonCount));
				pstmt.setString(5, idx);
				int result = pstmt.executeUpdate();
				if(result == 1) {
					out.put("result","SUCCESS");
					out.put("reason", "");
					return out;
				}
				else {
					
					out.put("result","FAILED");
					out.put("reason", "Database Execute Failed");
					return out;
				}
			}
			else {
				out.put("result","FAILED");
				out.put("reason", "Unknown Index");
				return out;
			}
		} catch(Exception e) {
			out.put("result","FAILED");
			out.put("reason", "Database Server Connect Failed");
			return out;
		}
	}
	// 각 자리의 상태 정보 조회 API
	// /api/getStdStatus, GET/POST, param으로 idx 전송
	@RequestMapping(value = "/getStdStatus")
	@ResponseBody
	public Map<String, String> getStdStatus(@RequestParam String idx){
		Map<String, String> out = new HashMap<String, String>();
		try {
			conn = JDBCUtil.getConnect();
			
			String USER_GET = "SELECT * FROM studentstatus WHERE idx=?";
			pstmt = conn.prepareStatement(USER_GET);
			pstmt.setString(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int attendTime = rs.getInt("attendTime");
				int goodWearTime = rs.getInt("goodMaskTime");
				int badWearTime = rs.getInt("badMaskTime");
				int notWearTime = rs.getInt("nonMaskTime");
				out.put("attendTime", Integer.toString(attendTime));
				out.put("goodWearTime", Integer.toString(goodWearTime));
				out.put("badWearTime", Integer.toString(badWearTime));
				out.put("notWearTime", Integer.toString(notWearTime));
				USER_GET = "SELECT * FROM maskwarning WHERE idx=?";
				pstmt = conn.prepareStatement(USER_GET);
				pstmt.setString(1, idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					int bad_warning = rs.getInt("bad_warning");
					int non_warning = rs.getInt("non_warning");
					out.put("bad_warning", Integer.toString(bad_warning));
					out.put("non_warning", Integer.toString(non_warning));
				}
				return out;
			} else {
				out.put("result","FAILED");
				out.put("reason", "Unknown Index");
				return out;
			}
		} catch(Exception e) {
			out.put("result","FAILED");
			out.put("reason", "Database Server Connect Failed");
			return out;
		}
	}
	// 집계 데이터 초기화 API
	// /api/reset, 입력 데이터 없음
	@RequestMapping(value = "/reset")
	@ResponseBody
	public Map<String, String> reset(){
		Map<String, String> out = new HashMap<String, String>();
		try {
			conn = JDBCUtil.getConnect();
			String SQL = "UPDATE studentstatus SET attendTime=0, goodMaskTime=0, badMaskTime=0, nonMaskTime=0";
			pstmt = conn.prepareStatement(SQL);
			int result = pstmt.executeUpdate();
			if(result >= 1) {
				SQL = "UPDATE maskwarning SET bad_warning=0, non_warning=0";
				pstmt = conn.prepareStatement(SQL);
				result = pstmt.executeUpdate();
				if(result >= 1) {
					out.put("result","SUCCESS");
					out.put("reason", "");
					return out;
				} else {
					out.put("result","FAILED");
					out.put("reason", "Database Execute Failed");
					return out;
				}
			} else {
				out.put("result","FAILED");
				out.put("reason", "Database Execute Failed");
				return out;
			}
		} catch(Exception e) {
			out.put("result","FAILED");
			out.put("reason", "Database Server Connect Failed");
			return out;
		}
	}
	// 수업 여부 변경 API
	// /api/changeLectureStatus, 입력 데이터 없음
	@RequestMapping(value = "/changeLectureStatus")
	@ResponseBody
	public Map<String, String> changeLectureStatus(){
		Map<String, String> out = new HashMap<String, String>();
		if(lecture) {
			try {
				TimeUnit.SECONDS.sleep(30);
				lecture = false;
				// attend save logic
				reset();
				out.put("result","SUCCESS");
				out.put("reason", "");
				return out;
			}
			catch(Exception e) {
				out.put("result","FAILED");
				out.put("reason", "IOException");
				return out;
			}
		}
		else {
			lecture = true;
			out.put("result","SUCCESS");
			out.put("reason", "");
			return out;
		}
	}
	// 수업 여부 조회 API
	// /api/getLectureStatus, 입력 데이터 없음
	@RequestMapping(value = "/getLectureStatus")
	@ResponseBody
	public Map<String, String> getLectureStatus(){
		Map<String, String> out = new HashMap<String, String>();
		if(lecture) {
			out.put("status", "true");
		}
		else {
			out.put("status", "false");
		}
		return out;
	}
	// 경고 발생 기록 처리 API
	// /api/setWarning, param으로 idx, type 입력
	@RequestMapping(value = "/setWarning")
	@ResponseBody
	public Map<String, String> setWarning(@RequestParam String idx, @RequestParam String type){
		Map<String, String> out = new HashMap<String, String>();
		if((type == "bad" || type == "non")) {
			System.out.println(idx + " " + type);
			out.put("result", "FAILED");
			out.put("reason", "Not valid type");
			return out;
		}
		try {
			conn = JDBCUtil.getConnect();
			
			String USER_SET = "UPDATE maskwarning SET " + type + "_warning=1 WHERE idx=?";
			pstmt = conn.prepareStatement(USER_SET);
			pstmt.setString(1, idx);
			int result = pstmt.executeUpdate();
			if(result >= 1) {
				out.put("result","SUCCESS");
				out.put("reason", "");
				return out;
			} else {
				out.put("result","FAILED");
				out.put("reason", "Database Execute Failed");
				return out;
			}
			
		} catch(Exception e) {
			out.put("result", "FAILED");
			out.put("reason", "Database server connect failed");
			return out;
		}
	}
	// 경고 발생 기록 조회 API
	// /api/getWarning, param으로 idx 입력
	@RequestMapping(value = "/getWarning")
	@ResponseBody
	public Map<String, String> getWarning(@RequestParam String idx){
		Map<String, String> out = new HashMap<String, String>();
		try {
			conn = JDBCUtil.getConnect();
			
			String USER_GET = "SELECT * FROM maskwarning WHERE idx=?";
			pstmt = conn.prepareStatement(USER_GET);
			pstmt.setString(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int bad_warning = rs.getInt("bad_warning");
				int non_warning = rs.getInt("non_warning");
				out.put("bad_warning", Integer.toString(bad_warning));
				out.put("non_warning", Integer.toString(non_warning));
				return out;
			} else {
				out.put("result","FAILED");
				out.put("reason", "Unknown Index");
				return out;
			}
		} catch(Exception e) {
			out.put("result","FAILED");
			out.put("reason", "Database Server Connect Failed");
			return out;
		}
	}
}