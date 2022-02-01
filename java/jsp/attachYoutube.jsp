<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	ul { border : 1px solid black; 
		 width  : 400px;
		 float  : left;
	}
	
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
var tag = document.createElement('script'); 

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player; // This will be used in a <div> later for the first video
var player2; // This will also be used in a <div> for the second video

function onYouTubeIframeAPIReady() {
	 player = new YT.Player('player', { 
		videoId: '6F_yqXXwfeg', // The ID of the video
		width : "300", 
		height : "170",
		playerVars:{ // Default attributes of the video player
		  'modestbranding': 1,
		  'autoplay' : -1, //literally autoplay
		  'controls' : 0, //controller
		  'showinfo' : 0, //show information of the current video
		  'rel': 0, // show related videos when current video finishes
		  'loop': 1, // replay again and again?
		  'playlist': '6F_yqXXwfeg' // The ID of the video again for loop
		 },
		events: {
		  'onReady': onPlayerReady, // 해당 이벤트는 동영상이 준비되면 발생하는 함수를 뜻합니다. 1)과 연결
		  'onStateChange': onPlayerStateChange 
          // 해당 이벤트는 상태가 변함에 따라 해당 함수가 발생하는 것을 뜻합니다. (재생/정지/준비 등등) 2)와 연결
		 }
	 });
	 player2 = new YT.Player('player2', { 
     // 아이디값을 변경해도 상관없습니다. 다만, html에 부여한 id 값도 동일하게 변경해야합니다.
		videoId: '860T3WYvyoc', // 동영상 ID 삽입 - 임시 아이디 삽입해두었습니다.
		width : "300", 
		height : "170", // 플레이어의 가로세로값을 정할 수가 있습니다. 
		playerVars:{ // 아래는 해당 플레이어의 기본 속성들을 정할 수 있습니다.
		  'modestbranding': 1,
		  'autoplay' : -1, // 자동재생
		  'controls' : 0, // 컨트롤러의 유무
		  'showinfo' : 0, // 재생영상에 대한 정보 유무
		  'rel': 0, // 해당 영상이 종류 된 후, 관련 동영상을 표시할지의 여부
		  'loop': 1, // 반복 재생의 여부
		  'playlist': '860T3WYvyoc' 
          // 단일 동영상을 반복재생하기 위해서 해당 매개변수가 필요합니다. 
          // 같은 동영상 id를 넣어줌으로써 반복 재생이 됩니다.
		 },
		events: {
		  'onReady': onPlayerReady, // 해당 이벤트는 동영상이 준비되면 발생하는 함수를 뜻합니다. 1)과 연결
		  'onStateChange': onPlayerStateChange 
          // 해당 이벤트는 상태가 변함에 따라 해당 함수가 발생하는 것을 뜻합니다. (재생/정지/준비 등등) 2)와 연결
		 }
	 });
};

// 1) 동영상이 준비되면 발생하는 함수
function onPlayerReady(event) {
  event.target.playVideo(); // 준비된 동영상을 재생합니다.
 // 그런데 위에서 autuplay 매개변수를 설정해두었다면 onReady 이벤트를 통해 재생을 명시할 필요는 없습니다.
 // 다만, 재생시 음소거를 원하는 등의 이벤트를 원한다면 해당 이벤트를 씀으로써 가능합니다. 
}

// 2) 플레이어의 상태에 따른 이벤트 
function onPlayerStateChange() {
  if(player.getPlayerState() == 1) console.log("재생중");
  else if(player.getPlayerState() == 2) console.log("일시중지");
/* ----------------------------------------------------
 -1 –시작되지 않음 / 0 – 종료 / 1 – 재생 중 / 2 – 일시중지 / 3 – 버퍼링 / 5 – 동영상 신호
 해당 이벤트에서 알아둘 것은 위의 플레이어상태인데
 해당 상태를 통해, 본인이 만든 컨트롤러 버튼들의 show/hide등을 컨트롤 할 수 있습니다.
---------------------------------------------------- */
}

</script>

</head>
<body>
	<h1> LIST </h1>	
	<div id="player"></div>
	<div id="player2"></div>
	
</body>
</html>
