<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/jsp/fmp/frame/common/partialJsp/headinclude.jsp" />
</head>
<body>

	<div>
		<input id="ReportPrintButton" type="button" value="导出word" onclick="openToWord('${TEMPLETTYPE}');"/>
		<input id="ReportPrintButton" type="button" value="打印" onclick="doPrint('${TEMPLETTYPE}');"/>
	</div>
<iframe width="100%" height="100%"  id="print_iframe" name="print_iframe" onload="iFrameHeight();"  >
<object id="WebBrowser" width=0 height=0 classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
 </object>
</iframe>
</body>
<script type="text/javascript">
	var tempFileName = "${tempFileName}";
	tempFileName = TEMP_FILE_URL+tempFileName.replace(/-/g,"\\");
	onloadScript();
	function onloadScript(){
		var iframe = document.getElementById('print_iframe');
		iframe.src = tempFileName; 
	}

	function iFrameHeight() {   
		var ifm= document.getElementById("print_iframe");   
		var subWeb = window.frames ? window.frames["print_iframe"].document : ifm.contentDocument;   
		if(ifm != null && subWeb != null) {
		   ifm.height = subWeb.body.scrollHeight + 50;
		}   
	}   
	
	//打印方法
	function printReport(){
		try{
			//document.all.print_iframe.window.focus();              
			//document.all.print_iframe.window.print();                
			document.all.print_iframe.ExecWB(7,1);//.ExecWB(7,1); // 打印预览
			//document.getElementById('print_iframe').WebBrowser.ExecWB(7,1);
			//document.getElementById('print_iframe').window.focus();        
		    // window.print();
		} catch (e){
			if(confirm('浏览器不支持默认打印方式，可能导致打印样式不正确。是否继续打印？')){
				document.getElementById('print_iframe').contentWindow.focus();
				window.print();
			}
		}
	}

	function openToWord(docType){
		var obj = getOfficeObj(docType);
		var mydoc;
		if(docType == "2"){
			var myDocApp = new ActiveXObject("word.Application");
			myDocApp.visible=true;
			myDocApp.activate();
			mydoc = myDocApp.documents.open(tempFileName);
		} else {
			showMessage("不支持此种类型文件打印，只支持Word和Excel文件类型！");
			return;
		}
		try{
			//mydoc.PrintPreview();
		}catch(e){
			showMessage("打印预览失败，请确认您的电脑上装有office！");
		} 
	}

	function doPrint(docType){
		printReportTempFile(docType,tempFileName);
	}	
</script>
</html>
<jsp:include page="/WEB-INF/jsp/fmp/frame/common/partialJsp/afterinclude.jsp" /> 