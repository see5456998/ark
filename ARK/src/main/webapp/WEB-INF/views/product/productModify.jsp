<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>

<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">

	<%@ include file="../includes/header.jsp" %>
	
	<!-- Main -->


<div id="page">
	<%@ include file="../includes/aside.jsp" %>
	<article id="article">
	
		<form class="pro-register-form" role="form" method="post" autocomplete="off">
		
			<input type="hidden" name="pronum" value="${product.pronum }">
			<input type="hidden" name="id" name="id" value="<sec:authentication property="principal.username"/>" >
			
			<div class="inputArea">
			
				<label>1차 분류</label> 
				<select class="category1">
					<option value="">선택</option>	
				</select> 
				
				<label>2차 분류</label> 
				<select class="category2"  name="catecode">
					<option value="">선택</option>
				</select>
			</div>

			<div class="inputArea">
				<label for="proname">상품명</label> <input type="text" id="proname"
					name="proname" value="${product.proname}"/>
			</div>

			<div class="inputArea">
				<label for="proprice">상품가격</label> <input type="text" id="proprice"
					name="proprice" value="${product.proprice}"/>
			</div>

			<div class="inputArea">
				<label for="prostock">상품수량</label> <input type="text" id="prostock"
					name="prostock" value="${product.prostock}"/>
			</div>

			<div class="inputArea">
				<label for="proinfo">상품소개</label>
				<textarea rows="5" cols="100" id="proinfo" name="proinfo">${product.proinfo}</textarea>
			</div>

			<div class="inputArea">
				<button type="submit" id="update_Btn" class="btn btn-primary">완료</button>
				<button type="submit" id="back_Btn" class="btn btn-warning">취소</button>
				
			</div>
<input type="hidden"
name="${_csrf.parameterName }"
value="${_csrf.token }"/>
			
		</form>

	</article>
</div>
<!-- /Main -->
	
<%@ include file="../includes/footer.jsp" %>

<script>
var jsonData = JSON.parse('${category}');

console.log(jsonData);

var cate1Arr = new Array();
var cate1Obj = new Object();


// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
for(var i = 0; i < jsonData.length; i++) {
 
 if(jsonData[i].level == "1") {
  cate1Obj = new Object();  //초기화
  cate1Obj.catecode = jsonData[i].catecode;
  cate1Obj.catename = jsonData[i].catename;
  cate1Arr.push(cate1Obj);
 }
}

// 1차 분류 셀렉트 박스에 데이터 삽입
var cate1Select = $("select.category1")

for(var i = 0; i < cate1Arr.length; i++) {
 cate1Select.append("<option value='" + cate1Arr[i].catecode + "'>"
      + cate1Arr[i].catename + "</option>");
}


 $(document).on("change", "select.category1", function(){

	 var cate2Arr = new Array();
	 var cate2Obj = new Object();
	 
	 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	 for(var i = 0; i < jsonData.length; i++) {
	  
	  if(jsonData[i].level == "2") {
	   cate2Obj = new Object();  //초기화
	   cate2Obj.catecode = jsonData[i].catecode;
	   cate2Obj.catename = jsonData[i].catename;
	   cate2Obj.catecoderef = jsonData[i].catecoderef;
	   
	   cate2Arr.push(cate2Obj);
	  }
	 }
	 
	 var cate2Select = $("select.category2");
	  
	 /*
	 for(var i = 0; i < cate2Arr.length; i++) {
	   cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
	        + cate2Arr[i].cateName + "</option>");
	 }
	 */
	 
	 cate2Select.children().remove();	

	 $("option:selected", this).each(function(){
	  
	  var selectVal = $(this).val(); 
	  
	  cate2Select.append("<option value='"+ selectVal +"'>선택</option>");
	  
	  for(var i = 0; i < cate2Arr.length; i++) {
	   if(selectVal == cate2Arr[i].catecoderef) {
	    cate2Select.append("<option value='" + cate2Arr[i].catecode + "'>"
	         + cate2Arr[i].catename + "</option>");
	   }
	  }
	 });
	}); 

//history.back();
$("#back_Btn").click(function(){
 location.href = "/productView?pronum=" + ${product.pronum};
});   

var select_catecode = '${product.catecode}';
var select_catecoderef = '${product.catecoderef}';
var select_catename = '${product.catename}';

if(select_catecoderef != null && select_catecoderef != '') {
 $(".category1").val(select_catecoderef);
 $(".category2").val(select_catecode);
 $(".category2").children().remove();
 $(".category2").append("<option value='"+select_catecode+"'>"+select_catename+"</option>");
} else {
 $(".category1").val(select_catecode);
 $(".category2").append("<option value='"+select_catecode+"' selected='selected'>선택</option>");
}


</script>







