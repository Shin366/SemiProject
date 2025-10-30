<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 임시 비밀번호 안내</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
	<script>
		window.onload = function() {
			const tempPw = "${tempPw }";
			if(tempPw) {
				alert("임시 비밀번호는 \""+tempPw+"\"입니다. 로그인 후 꼭 비밀번호를 변경해주세요.")
				window.location.href = "/member/login";
			}else {
				alert("임시 비밀번호 발급에 실패했습니다.");
				window.location.href = "/member/pwSearch";
			}
		}
	</script>
</head>
<body>
</body>
</html>