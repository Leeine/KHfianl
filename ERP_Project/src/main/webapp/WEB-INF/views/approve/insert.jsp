<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<!--  <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>-->
<link href="/erp/css/summernote/summernote-lite.css" rel="stylesheet">
<link href="/erp/css/test.css" rel="stylesheet">
<script src="/erp/js/summernote/summernote-lite.js"></script>
<script src="/erp/js/summernote/lang/summernote-ko-KR.js"></script>
</head>
<body>
<div id="textdiv">
    <textarea id="summernote" style="resize:'none'"></textarea>
    <button onclick="text();">확인</button>
    <button onclick="selectType1();">양식1</button>
    <button onclick="testdiv();">test</button>
    
    <div id="testdiv"></div>
    
    <script>
		function testdiv(){
    		var content = $("#summernote").val();
    		$("#testdiv").html(content);
		};
		function text(){
    		var content = $("#summernote").val();
    		console.log(content);
    	};
    	function selectType1(){
    		var type1 = '<h1 style="text-align: center; margin: 0;">차량운행일지</h1><div style="text-align: center; margin-bottom: 10px;"><p style="margin: 5px 0;">년 &nbsp;&nbsp; 월 &nbsp;&nbsp; 일 &nbsp;&nbsp; 요일</p></div><table style="width: 100%; border-collapse: collapse;"><thead><tr><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">차량번호</th><th colspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">출발</th><th colspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">도착</th><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">운행시간</th><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">주행거리</th><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">운행목적</th><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">사용자</th><th rowspan="2" style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">비고</th></tr><tr><th style="border: 1px solid #000; padding: 8px;">출발지</th><th style="border: 1px solid #000; padding: 8px;">시간</th><th style="border: 1px solid #000; padding: 8px;">도착지</th><th style="border: 1px solid #000; padding: 8px;">시간</th></tr></thead><tbody><tr><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td></tr></tbody></table><div style="margin-top: 15px;"><p style="font-weight: bold; margin: 5px 0;">정비예정내용</p><div style="width: 100%; height: 80px; border: 1px solid #000;"></div></div><div style="margin-top: 10px;"><p style="font-weight: bold; margin: 5px 0;">정비 및 시정사항</p><div style="display: inline-block; width: 80%; height: 80px; border: 1px solid #000;"></div><div style="display: inline-block; width: 19%; height: 80px; border: 1px solid #000; text-align: center;">정비공장</div></div><table style="width: 100%; margin-top: 15px; border-collapse: collapse;"><tr><th style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">1일 운행시간</th><th style="border: 1px solid #000; padding: 8px;">시간</th><th style="border: 1px solid #000; padding: 8px;">분</th><th style="border: 1px solid #000; padding: 8px;">총 주행 거리</th><th style="border: 1px solid #000; padding: 8px;">km</th></tr><tr><td style="border: 1px solid #000; padding: 8px;">연합도량</td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td><td style="border: 1px solid #000; padding: 8px;"></td></tr></table><p style="margin-top: 10px;">비 고</p><div style="width: 100%; height: 50px; border: 1px solid #000;"></div>';
			var type2 = '<div class="container"><h1>휴 가 신 청 서</h1><table><tr><th style="width: 20%;">소 속</th><td></td></tr><tr><th>성 명</th><td></td></tr><tr><th>직 위</th><td></td></tr><tr><th>종 류</th><td></td></tr><tr><th>사 유</th><td></td></tr><tr><th>기 간</th><td></td></tr><tr><th>비상연락망</th><td></td></tr></table><p style="text-align: center;">위와 같이 휴가를 신청하오니 승인하여 주시기 바랍니다.</p><div class="signature">20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;일<br><br><div class="name">소 속: </div><div class="name">성 명:</div></div></div>';
    		$("#summernote").summernote("code", type2);
    	};	
    </script>
    </div>
</body>
</html>