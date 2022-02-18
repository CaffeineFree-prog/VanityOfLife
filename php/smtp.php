<?
include("../_inc/config.php");
include($_DIR['common'] ."/head.php");
?>
<?php

	//db연결
	header('Content-Type: text/html; charset=utf-8');
	$dbObj = new mysqli('db connection info'); 
	$dbObj-> set_charset("utf8");
	
	function mq($sql)
	{
		global $dbObj;
		return $dbObj->query($sql);
	}
	
	$sql = mq("SELECT * FROM EMAIL");
	//print_r($sql);
	//exit; 
	
	// 파일 저장 

	ini_set("display_errors", "1");

	if(isset($_FILES['filo']) && $_FILES['filo']['name'] != "") {
	
		$uploaddir = './report/';
		
		$today1 = date('Ymd');
		$today2 = date('His');
		
		$filename = $today1.$today2.$_FILES['filo']['name'];
		
		//iconv("UHC", "UTF-8", $filename);
		//$uploadfile = $uploaddir . basename($_FILES['filo']['name']);
		$uploadfile = $uploaddir . basename($filename);
		
		//echo '<pre>';
		
		if (move_uploaded_file($_FILES['filo']['tmp_name'], $uploadfile)) {
		
		   //echo "파일이 유효하고, 성공적으로 업로드 되었습니다.\n";
		
		} else {
		
		    //print "파일 업로드 공격의 가능성이 있습니다!\n";
		
		}
		
		//echo '자세한 디버깅 정보입니다:';
		
		//print_r($_FILES);
		
		//print "</pre>";
		
		//exit;
		
	}
	
	//smtp
	
	include "Sendmail.php";
	$sendmail = new Sendmail();
	
	/* + $path : 파일의 절대 경로 
	 * + $name : 파일의 이름을 설정 
	 * + $ctype : 메일 컨텐츠 타입 (옵션값으로 기본값은 application/octet-stream 이다 ) */
	 
	$path = './report/'.$filename;
	$name = $_FILES['filo']['name'];
	$ctype = "application/octet-stream";

	//* 첨부파일 추가 */
	$sendmail->attach($path,$name,$ctype);
			
	/* + $to : 받는사람 메일주소 ( ex. $to="hong <hgd@example.com>" 으로도 가능) 
	 * + $from : 보내는사람 이름 
	 * + $subject : 메일 제목 
	 * + $body : 메일 내용 + $cc_mail : Cc 메일 있을경우 (옵션값으로 생략가능) 
	 * + $bcc_mail : Bcc 메일이 있을경우 (옵션값으로 생략가능) */
	 
	$to="";
	$from="Master";
	$subject="Report";
	$body= $_POST["titl"];
	//$cc_mail="";
	//$bcc_mail="";
	
	$sql = mq("INSERT INTO CB_EMAIL VALUES ( '$body', '$name' , '$filename' , NOW())  ");
	//echo($sql);
	//exit;
	$sendmail->send_mail($to, $from, $subject, $body,$cc_mail,$bcc_mail);

?>
		<!--Header : ST-->
<?
include($_DIR['common'] ."/gnb.php");
?>
		<!--Header : ED-->


<!--Cont : ST-->
<section class="subcont">
	
	<?php include("../company/topbg.php"); ?>
	
	<div class="linemap">
		<div class="lim-fix">
			<dl>
				<dt class="blind">라인맵</dt>
				<dd class="ico_xi"><span class="blind">홈으로</span><span class="ico_xi">기업개요</span><span class="ico_xi">회사소개</span><strong class="ico_xi fc_blue">윤리규정</strong></dd>
			</dl>
		</div>
	</div>

	<div class="sub-fix">
		<h1 class="tit_h1">윤리규정</h1>
		<div class="tab-box">
			<ul class="n_col2">
				<li><a href="company01_07.php">윤리규정</a></li>
				<li><a href="company01_08.php" class="on">내·외부신고제도</a></li>
			</ul>
		</div>
		<div class="declarationSystem02 declarationBg mb40">
			<h4 class="titType">내·외부신고제도</h4>
			<p class="bold mb5">신고처리가 완료되었습니다.</p>

		</div>
	</div>
		
</section>
<!--Cont : ED-->
<?
include($_DIR['common'] ."/footer.php");
?>
