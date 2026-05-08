# KHfianl
ERP 프로젝트

# KHfinal ERP 프로젝트

## 개발 환경

| 항목 | 버전 |
|------|------|
| Java | Amazon Corretto JDK 11 |
| IDE | Spring Tool Suite 4.20.1 (STS) |
| Framework | Spring Boot 3.3.6 |
| DB | Oracle 11g XE |
| JDBC | ojdbc11 21.9.0.0 |

---

## 프로젝트 실행 주소

```
http://localhost:8888/erp
```

- 포트: `8888`
- context-path: `/erp`

---

## 환경 설치 순서

### 1. Amazon Corretto JDK 11 설치
- [corretto.aws](https://corretto.aws) 에서 Windows 64-bit MSI 다운로드
- 설치 시 `JAVA_HOME` 자동 설정
- 확인: `java -version` → `openjdk 11.x.x` 출력 확인

### 2. STS 4.20.1 설치
- [spring.io/tools](https://spring.io/tools) 에서 다운로드
- ZIP 압축 해제 후 `SpringToolSuite4.exe` 실행 (별도 설치 불필요)
- `Window → Preferences → Java → Installed JREs` → Corretto 11 등록

### 3. Lombok 설치 (중요)
- Maven이 자동으로 다운로드한 Lombok JAR 더블클릭
  - 경로: `C:\Users\{유저명}\.m2\repository\org\projectlombok\lombok\{버전}\lombok-{버전}.jar`
- STS 경로 선택 후 Install/Update
- **STS 재시작 필수**

### 4. Oracle 11g XE 설치
- 기본 포트: `1521`, SID: `XE`
- 설치 후 DB 계정 생성:
```sql
CREATE USER erp IDENTIFIED BY 비밀번호;
GRANT CONNECT, RESOURCE, DBA TO erp;
```
- 레포의 `ERP_DB스크립트(25.01.15, 더미데이터 포함).sql` 실행
  - SQL Developer에서 파일 열고 `F5` (스크립트 실행)

### 5. application.properties 설정
`src/main/resources/application.properties` 수정:
```properties
server.port=8888
server.servlet.context-path=/erp

spring.datasource.url=jdbc:oracle:thin:@localhost:1521:XE
spring.datasource.username=erp
spring.datasource.password=설정한비밀번호
```

### 6. 프로젝트 Import
- `File → Import → Maven → Existing Maven Projects` → `ERP_Project` 폴더 선택
- 프로젝트 우클릭 → `Maven → Update Project` (`Alt+F5`)

---

## STS 인코딩 설정 (주석 깨짐 방지)

`Window → Preferences` 에서 아래 항목 모두 UTF-8로 설정:

- `General → Workspace` → Text file encoding → UTF-8
- `General → Content Types` → Text → Default encoding → UTF-8
- `Web → HTML Files` → Encoding → UTF-8
- `Web → JSP Files` → Encoding → UTF-8

설정 후 `Maven → Update Project` 한 번 더 실행

---

## 주의사항

### WebSocket IP 하드코딩
`src/main/resources/static/js/messenger.js` 122번째 줄 근처:
```javascript
// 이렇게 하드코딩하면 안됨 (IP 바뀌면 연결 실패)
socket = new WebSocket("ws://192.168.xxx.xxx:8888/erp/messenger/ws");

// 이렇게 써야 함
socket = new WebSocket("ws://" + location.host + contextPath + "/messenger/ws");
```

### MyBatis mapper 경고
콘솔에 아래 경고가 떠도 정상 작동함:
```
No MyBatis mapper was found in '[kr.or.erp]' package.
```

---

## 자주 쓰는 단축키 (STS)

| 단축키 | 기능 |
|--------|------|
| `Ctrl + Shift + O` | import 자동 추가 |
| `Alt + F5` | Maven Update Project |
| `Ctrl + Shift + F` | 코드 자동 정렬 |
| `Ctrl + /` | 주석 토글 |
