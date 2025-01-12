<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="admin-page">
			<table class="admin-table">
				<tbody>
					<tr>
						<td>
						</td>
					</tr>
					<tr>
						<td>
						</td>
					</tr>
				</tbody>
			</table>
		<div id=admin-setting-area>
			<table class="setting-table">
				<tbody>
					<tr>
						<td>
							<div id="admin-notice-area">
								<div class="admin-help">
									<h2>공지</h2>
									접속중인 모든 사용자 화면에 표시됩니다.
									<textarea id="admin-notice-input-text"style="resize: none"></textarea><br>
									<button onclick="sendAdminNotice();">전송</button>
									<button onclick="logoutAll();">모든 사용자 로그아웃</button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="width: 100%">
							<div id="insert-employee-area">
								<div class="admin-help">
									<h2>사원추가</h2>
									이름 입력 시 해당 사원 계정이 추가됩니다.<br><br>
									사원 목록
									<div id="employee-list-area" class="list-area">
									</div>
									<select id="dept-select"></select>
									<select id="empRank-select"></select>
									<input type="text" id="admin-insert-employeeName">
									<button onclick="empInsert();">등록</button>
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td style="width: 100%">
							<div id="insert-employee-area">
								<div class="admin-help">
									<h2>품목 추가</h2>
									제품명 입력 시 품목에 추가됩니다.<br><br>
									품목
									<div id="item-list-area" class="list-area">
									</div>
									<input type="text" id="admin-insert-itemName" placeholder="제품명">
									<input type="number" id="admin-insert-itemPrice" placeholder="가격">
									<button onclick="itemInsert();">등록</button>
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td style="width: 100%">
							<div id="insert-category-area">
								<div class="admin-help">
									<h2>제품 카테고리 추가</h2>
									카테고리명 입력 시 카테고리가 추가됩니다.<br><br>
									카테고리 목록
									<div id="category-list-area" class="list-area">
									</div>
									<input type="text" id="admin-insert-categoryName">
									<button onclick="categoryInsert();">등록</button>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
		
		</div>
		
		
		<script>
			$(function(){
				empList();
				deptList();
				empRankList();
				itemList();
				categoryList();
			})
		</script>
	
</div>
</body>
</html>