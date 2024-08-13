<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
.wrapper {
  height:100%;
  width:100%;
  position: absolute;
  color:inherit;
  top:0px;
  left:0px;
  z-index: -10;
}
.wrapper .bubble {
  height: 60px;
  width: 60px;
  border: 2px solid rgba(255, 255, 255, 0.7);
  border-radius: 50px;
  position: absolute;
  animation: animate 10s linear infinite;
  opacity:0.2;
}
.wrapper .bubble:nth-child(1) {
  top: 20%;
  left: 20%;
  animation-duration: 8s;
}
.wrapper .bubble:nth-child(2) {
  top: 60%;
  left: 80%;
  animation-duration: 10s;
}
.wrapper .bubble:nth-child(3) {
  top: 40%;
  left: 40%;
  animation-duration: 3s;
}
.wrapper .bubble:nth-child(4) {
  top: 66%;
  left: 30%;
  animation-duration: 7s;
}
.wrapper .bubble:nth-child(5) {
  top: 90%;
  left: 10%;
  animation-duration: 9s;
}
.wrapper .bubble:nth-child(6) {
  top: 30%;
  left: 60%;
  animation-duration: 5s;
}
.wrapper .bubble:nth-child(7) {
  top: 70%;
  left: 20%;
  animation-duration: 8s;
}
.wrapper .bubble:nth-child(8) {
  top: 75%;
  left: 60%;
  animation-duration: 10s;
}
.wrapper .bubble:nth-child(9) {
  top: 50%;
  left: 50%;
  animation-duration: 6s;
}
.wrapper .bubble:nth-child(10) {
  top: 45%;
  left: 20%;
  animation-duration: 10s;
}
.wrapper .bubble:nth-child(11) {
  top: 10%;
  left: 90%;
  animation-duration: 9s;
}
.wrapper .bubble:nth-child(12) {
  top: 20%;
  left: 70%;
  animation-duration: 7s;
}
.wrapper .bubble:nth-child(13) {
  top: 20%;
  left: 20%;
  animation-duration: 8s;
}
.wrapper .bubble:nth-child(14) {
  top: 60%;
  left: 5%;
  animation-duration: 6s;
}
.wrapper .bubble:nth-child(15) {
  top: 90%;
  left: 80%;
  animation-duration: 9s;
}
@keyframes animate {
  0% {
    transform: scale(0) translateY(0) rotate(70deg);
  }
  100% {
    transform: scale(1.3) translateY(-100px) rotate(360deg);
  }
}
</style>
<div class="wrapper">
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
  <div class="bubble"></div>
</div>