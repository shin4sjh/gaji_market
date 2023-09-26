<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    h1 {
        background-color: #007bff;
        color: white;
        padding: 10px;
        text-align: center;
    }

    .container {
        text-align: center; /* Center align content */
        padding: 20px;
        background-color: white;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    button {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin: 10px; /* Add margin around buttons */
    }

    button:hover {
        background-color: #0056b3;
    }

    p {
        margin: 10px 0;
    }

    a {
        text-decoration: none;
        color: #007bff;
    }

    a:hover {
        text-decoration: underline;
    }

    /* Arrange buttons horizontally */
    .button-container {
        display: flex;
        justify-content: center;
    }
</style>
</head>
<body>
<h1>안전거래 상세조회</h1>
<div class="container">
    <c:if test="${safePurchaseInfoDto.tradingStatus ne 5}">
        <button onclick="cancel('${safePurchaseInfoDto.buyerId}','${safePurchaseInfoDto.transactionId}')">결제취소</button>
    </c:if>
    <c:if test="${safePurchaseInfoDto.tradingStatus eq 1}">
    <button onclick="accept('${safePurchaseInfoDto.sellerId}','${safePurchaseInfoDto.transactionId}')">안전결제 수락</button>
	</c:if>
    <c:if test="${safePurchaseInfoDto.tradingStatus eq 3}">
        <button onclick="InsertTrackingNumber('${safePurchaseInfoDto.sellerId}','${safePurchaseInfoDto.transactionId}')">운송장 등록</button>
        
    </c:if>

    <a href="#"><p>상품명:${safePurchaseInfoDto.goodsTitle}</p></a>
    <p>판매자명:${safePurchaseInfoDto.sellerName}</p>
    <p>구매자명:${safePurchaseInfoDto.buyerName}</p>
    <p>휴대폰번호:${safePurchaseInfoDto.mobileNumber}</p>
    <p>배송지:${safePurchaseInfoDto.roadAddress}, ${safePurchaseInfoDto.detailAddress}</p>
    <p>거래일자:${safePurchaseInfoDto.tradingDate}</p>

    <c:choose>
        <c:when test="${safePurchaseInfoDto.tradingStatus eq 1}"><p>거래상태:입금완료</p></c:when>
        <c:when test="${safePurchaseInfoDto.tradingStatus eq 2}"><p>거래상태:상품준비중</p></c:when>
        <c:when test="${safePurchaseInfoDto.tradingStatus eq 3}"><p>거래상태:배송중</p></c:when>
        <c:when test="${safePurchaseInfoDto.tradingStatus eq 4}"><p>거래상태:거래완료</p></c:when>
        <c:when test="${safePurchaseInfoDto.tradingStatus eq 5}"><p>거래상태:결제취소</p></c:when>
    </c:choose>

    <c:if test="not empty ${safePurchaseInfoDto.trackingNumber}">
        <p>운송장번호:${safePurchaseInfoDto.trackingNumber}</p>
    </c:if>
</div>
<script>
    var cancel=(userId1,transactionId1)=>{
        $.ajax({
            url:"${pageContext.request.contextPath}/payment/cancel",
            data:{userId:userId1, transactionId:transactionId1},
            method: "post",
            dataType:"json",
            success:cancelCallBack
        });
    }
    function cancelCallBack(data){
        console.log("cancelCallBack들어옴");
        console.log(data);
        if(data.response.status=="cancelled"){
            alert("거래가 취소되었습니다");
            window.location.href="${pageContext.request.contextPath}/mypage/orderstatus";
        }
        else
            alert("거래 취소에 실패하였습니다.");
    }
    
    accept=(sellerId,transactionId)=>{
    	 $.ajax({
             url:"${pageContext.request.contextPath}/payment/cancel",
             data:{userId:userId1, transactionId:transactionId1,status:2},
             method: "post",
             dataType:"json",
             success:acceptCallback
         });
    }
    
    acceptCallback=(data)=>{
    	if(data='1'){
    		alert('안전결제가 수락되었습니다.');+
    		window.location.href="${pageContext.request.contextPath}/mypage/salestatus";
    	}
    	else
    		alert("안전결제 수락에 실패했습니다.");
    }

</script>
</body>
</html>