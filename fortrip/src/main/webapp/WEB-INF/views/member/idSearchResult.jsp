<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 아이디 안내</title>
	<script>
        window.onload = function() {
            const memberId = "${memberId}";
            if(memberId) {
                alert("임시 비밀번호는 \""+memberId+"\"입니다.")
				window.location.href = "/member/login";
            } else {
                alert("아이디 찾기에 실패했습니다.");
                window.location.href = "/member/idSearch";
            }
        }
    </script>
</head>
<body>
</body>
</html>