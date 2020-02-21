<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

<!-- 웹사이트 파비콘 -->
<link rel=" shortcut icon" href="/resources/image/logo/logo-favicon.png">
<link rel="icon" href="/resources/image/logo/logo-favicon.png">

<!-- favicon 404 에러 안보이게  -->
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<!-- 웹 폰트 (나눔고딕) -->
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean"
	rel="stylesheet">


<!--부트스트랩 CSS-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<!-- fontawesome cdn(웹 아이콘 라이브러리) -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- jQuery js -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- 부트스트랩 js -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>


<!-- 공통 CSS -->
<link rel="stylesheet" href="/resources/css/common.css">

<!-- 메인 메뉴 CSS -->
<link rel="stylesheet" href="/resources/css/header.css">
<!-- 메인 메뉴 js -->
<script src="/resources/javascript/header.js"></script>


<link rel="shortcut icon" href="/static/pc/images/favicon.ico">
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!-- cannot find resource 404
<script src="lang/summernote-ko-KR.js"></script>
 -->
 
 <!-- datepicker --> 
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">  
<!--  
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-bs4.min.js"></script>
 
<style type="text/css">
	 .btn-basic {
        background-color: #F2B33D;
        color: white;
    }

    .btn-basic:hover {
        background-color: #F2D64B;
        color: white;

    }
    
    .btn-outline-basic {
        border: 1px solid #F2B33D;
        color: #F2B33D;
    }
    
    .btn-outline-basic:hover {
        background-color: #F2B33D;
        color: white;
    }
    
    #updateOneEventButton{
    	align-content: right;
    }
</style>


	<script type="text/javascript">
	////////////////////////////////////////////////////////////////////////////////////
		var eventUpdatecount = 0;
	
		$(function() {
			
			///뒤로가기 버튼 클릭시
			$(document).on("click", "#beforeButton", function() {
				
				alert('뒤로가기');
				history.go(-1);
			})
			
			///이벤트 수정하기 버튼 클릭시
			$(document).on("click", "#updateOneEventButton", function() {
				
				alert('이벤트 수정 버튼');
				fnUpdateOneEvent(eventUpdatecount);

			})
			
		});
	

    $(document).ready(function() {
    	
    	$('#summernote').summernote({
    		placeholder: '글씨를 입력해주세요',
    		lang: 'ko-KR',
    		tabsize: 2,
    		height: 350,
    		minHeight : 350,
    		maxHeight : 350,
    		//width: 550,
/*     		  toolbar: [
    		    // [groupName, [list of button]]
    		    ['style', ['bold', 'italic', 'underline', 'clear']],
    		    ['font', ['strikethrough', 'superscript', 'subscript']],
    		    ['fontsize', ['fontsize']],
    		    ['color', ['color']],
    		    ['para', ['ul', 'ol', 'paragraph']],
    		    ['height', ['height']],
    		    ['view', ['codeview', 'help']]
    		  ], */
    		callbacks : {
    			onImageUpload: function(files, editor, welEditable) {
    				//alert(files);
    				//alert(editor);
    				//alert(welEditable);
    				for (var i = files.length-1 ; i >=0 ; i--) {
						sendFile(files[i], this);
						
					}
				}
    		}  
    		  
    		}); //summernote
    		
    		///////////////////////////////////////////////
    		///admin이 설정해놓은 카테고리에 해당하는  체크박스에 checked해주는 과정.
    		var y = 1;
    		var event_categorys =  $('input:hidden[name=event_categorys]').val(); //수정하기전 category의 갯수
    		var event_categorys_size = $('input:hidden[name=event_categorys_size]').val();//수정하기전 category
    		var result_event_categorys = []; //수정하기전 category for문 돌려서 알파벳만 뽑은 거.
    		//console.log('수정하기전 category의 갯수-event_categorys_size-->>'+event_categorys_size);
    		//console.log('수정하기전 category는 -event_categorys--->>'+event_categorys);
    		for(var i = 0; i<event_categorys_size; i++){
    			//console.log('y-->'+y);
    			//console.log('수정하기전 category['+y+']번째-->>'+event_categorys[y]);
    			result_event_categorys.push(event_categorys[y]);
    			
    			//console.log('새로운 var인 result_event_categorys에 담긴 category==>'+result_event_categorys);
    		
    			//console.log('result_event_categorys ['+i+']번째-->'+result_event_categorys[i]);
    		
    			
    				y +=3; //==>list가   '[' 또는 ']' 또는 ',' 의 숫자도 포함하기 때문에 이렇게 +3씩 해줌..
        			
    		}//for
    		
      			 $('input:checkbox[name=category]').each(function() {
     				 for(var x = 0; x < event_categorys_size; x++){
						
    			     	if(this.value == result_event_categorys[x] ){ //값 비교
    			            this.checked = true; //checked 처리

    			      	}//if
     				 }//for
    			 });//each
    		
    			console.log('result_event_categorys-->'+result_event_categorys); 
    		
    		
/*      		for (var z = 0; z < event_categorys_size; z++){
    			var checkBoxLength = $('input:checkbox[name="category"]').length;
    			console.log('checkBoxLength==>'+checkBoxLength);
    			
    			for (var r = 0; r < checkBoxLength; r++) {
    				if ( $('input:checkbox[name="category"]').eq(r).value == result_event_categorys[z] ) {
    					$('input:checkbox[name="category"]').eq(r).attr('checked', true);
    				}
    				
    			}
    		}  */
    		
    		
    });//ready
    
    $(function() {
    
    	 $.datepicker.setDefaults({
    		 dateFormat: 'yy-mm-dd'
    		 ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
    		 ,yearSuffix: "년"
    		 ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
    		 ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
    		 //,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
    		 ,changeMonth: true //콤보박스에서 월 선택 가능
    		 //,showOn: "both"
    		 //,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                //,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    	 });
    	
    	$("#eventStartDate").datepicker();
		$("#eventEndDate").datepicker();
		
    });
    
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: '/event/json/makeFileUpload',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
        		console.log('파일이 저장된 path--'+img_name);
        		var path = "";
        		path += "<img src='/images/kyung/"+img_name+"'>";
        		console.log(path);
        		//var url = ""
        		//$(el).summernote('editor.insertImage', path);
        		$('#summernote').summernote('insertImage', '/images/kyung/'+img_name);
        		//$("textarea").html(path);
				eventUpdatecount += 1;
				
        	},
        	error:function(request,status,error){
		            alert("ajax과정 실패");
		       }
		}); //ajax
	}
	
	
	function fnUpdateOneEvent(eventUpdatecount) {
		
		alert('fnUpdateOneEvent');
		//alert('이벤트 add함수접근');
		var eventTitle = $("input[name='eventTitle']").val();
		alert('eventUpdatecount----'+eventUpdatecount);

		
		////update시 이미 이미지가 있을 경우 count가 되게하려고//////////
/* 		var eventImage = $("input:hidden[name='eventImage']").val();
		//alert('eventImage--'+eventImage);
		if(eventImage != null){
    		alert("사진이 한 개 있음.");
    		eventUpdatecount += 1;
    	}
		alert('eventUpdatecount 최종----'+eventUpdatecount); */

		//이벤트내용에 image가 있는지 체크하는 내용.
		var eventContent = $("#summernote").val();
		console.log('eventContent---'+eventContent);
		if(eventContent.indexOf("<img") != -1){
			eventUpdatecount += 1;
			alert('eventContent에 이미지 한개이상 있음');
		}
		
		//alert('eventContent--'+eventContent);
		
		//이벤트 기간
        var eventStartDate = $("input[name='eventStartDate']").val();
        console.log('eventStartDate--'+eventStartDate);
        //alert('eventStartDate--'+eventStartDate);
        var eventEndDate = $("input[name='eventEndDate']").val();
        console.log('eventEndDate--'+eventEndDate);
        //alert('eventEndDate--'+eventEndDate);
        
        var eventDiscount = $("input[name='eventDiscount']").val();
        //alert('eventDiscount--'+eventDiscount);
        
		// name이 같은 체크박스의 값들을 배열에 담는다.
   	 	//var checkboxValues = [];
   	 	var categorys = [];
    	$("input[name='category']:checked").each(function(i) {
    		categorys.push($(this).val());
    	});
        //alert('categorys--'+categorys);
        console.log('categorys--'+categorys);
        
    	if(eventUpdatecount == 0 || eventUpdatecount.length<1){
    		alert("사진은 반드시 한 개 이상 등록하여야 합니다.");
    		return;
    	}
    	if(eventTitle == null || eventTitle.length<1){
    		alert("이벤트명은 반드시 입력하여야 합니다.");
    		return;
    	}
    	if(eventContent == null || eventContent.length<1){
    		alert("이벤트 내용은 반드시 입력하여야 합니다.");
    		return;
    	}
    	if(eventStartDate == null || eventStartDate.length<1){
    		alert("이벤트 시작일은 반드시 입력하여야 합니다.");
    		return;
    	}
    	if(eventEndDate == null || eventEndDate.length<1){
    		alert("이벤트 종료일은 반드시 입력하여야 합니다.");
    		return;
    	}
    	if(eventDiscount == null ){
    		alert("이벤트 할인율은 반드시 입력하여야 합니다.");
    		return;
    	}
    	if(eventDiscount.length<1 || eventDiscount.length>2){
    		alert("이벤트 할인율은 1~100사이의 숫자여야 합니다.");
    		return;
    	}
    	if(categorys == null || categorys.length<1){
    		alert("카테고리는 반드시 1개 이상 입력하셔야 됩니다.");
    		//return;
    	}
    	
    	
        alert('접근__접근');
		$("form[name='updateOneEvent']").attr("method", "POST").attr("action", "/event/updateOneEventAdmin").submit();
    
	}
    
    
	</script>
</head>

<body>
	<!-- toolbar -->
	<jsp:include page="/common/header.jsp" />

	<!-- 전체 묶음 -->
	<div class="wholeUpdateEvent container mt-5">
	
<form name="updateOneEvent">

  		<input type="hidden" name="event_categorys" value="${event.category }"> 
  		<input type="hidden" name="event_categorys_size" value="${event.category.size() }"> 
  		<input type="hidden" name="eventImage" value="${event.eventImage}"> 
  		
        <div class="p-3 py-4 mb-2 text-left rounded">
          <svg id="beforeButton" class="bi bi-chevron-left" width="4em" height="4em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
 		 	<path fill-rule="evenodd" d="M13.354 3.646a.5.5 0 010 .708L7.707 10l5.647 5.646a.5.5 0 01-.708.708l-6-6a.5.5 0 010-.708l6-6a.5.5 0 01.708 0z" clip-rule="evenodd"></path>
		 </svg>
		 이벤트 수정하기
		   	<button id="updateOneEventButton" type="button" class="btn btn-basic m-1" >
  				수정
  			</button>
        </div>
  
<%--   <c:set value="category" var="category"></c:set>
  <c:forTokens var="value" items="${event.category }" delims=",">
  	1:${value }

  </c:forTokens> --%>
  
  
  <!-- 이벤트 이름 -->
	<div class="input-group mb-3">
  		<div class="input-group-prepend">
   		 	<span class="input-group-text" id="basic-addon1">이벤트 이름</span>
  		</div>
  		<input type="text" name="eventTitle" class="form-control" aria-label="Username" placeholder="등록할 이벤트의 이름을 입력하세요" value="${event.eventTitle}" aria-describedby="basic-addon1">
	</div>
	
	 <!-- 이벤트 기간 -->
	<div class="input-group mb-3">
  		<div class="input-group-prepend">
   		 	<span class="input-group-text" id="basic-addon1">이벤트 기간</span>
  		</div>
  	
  			<input type="text" id="eventStartDate" name="eventStartDate" class="form-control" placeholder="시작일" value="${event.eventStartDate}">
  		 	<input type="text" id="eventEndDate" name="eventEndDate" class="form-control" placeholder="종료일" value="${event.eventEndDate}"> 
	</div>
	
  
  	
  	<!-- 카테고리 선택 -->
  	 <div class="input-group mb-3">
  		<div class="input-group-prepend">
   		 	<span class="input-group-text mb-3" id="basic-addon1">이벤트 카테고리</span>
  		</div>
  		
  		
  		<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox1" value="E">
  			<label class="form-check-label" for="inlineCheckbox1">운동</label>
  		</div> 
  		
  		<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox2" value="M">
  			<label class="form-check-label" for="inlineCheckbox2">음악</label>
		</div>
  		
  		<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox3" value="L">
 			<label class="form-check-label" for="inlineCheckbox3">라이프스타일</label>
		</div>
  		
  			<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox4" value="C">
 			<label class="form-check-label" for="inlineCheckbox3">요리</label>
		</div>
		
		<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox5" value="H">
 			<label class="form-check-label" for="inlineCheckbox3">공예</label>
		</div>
		
		<div class="form-check form-check-inline">
  			<input class="form-check-input" name="category" type="checkbox" id="categoryCheckbox6" value="A">
 			<label class="form-check-label" for="inlineCheckbox3">미술</label>
		</div>
 
   	</div>
   	
   	
   	<!-- 이벤트 할인율 -->
	<div class="input-group mb-3">
  		<div class="input-group-prepend">
   		 	<span class="input-group-text" id="basic-addon1">이벤트 할인율</span>
  		</div>
  		<input type="text" name="eventDiscount" class="form-control" value="${event.eventDiscount}" placeholder="등록할 이벤트의 할인율을 입력하세요. 1~100사이의 숫자">
	</div>
   	
 	<!-- 이벤트 내용 --> 
 	<div class="input-group">
  		<div class="input-group-prepend">
   		 	<span class="input-group-text" id="basic-addon1">이벤트 내용</span>
  		</div>
  		<!--  
			<textarea  class="form-control" id="summernote"  name="eventContent"  aria-label="With textarea">${event.eventContent}</textarea> -->
			<textarea  class="form-control" id="summernote"  name="eventContent"  aria-label="With textarea"><img src="/images/kyung/${event.eventImage}" ></textarea>
	</div>
	
  	
  </form>
  
  <p>footer</p>	  
  
</div>

</body>
</html>