6주차

DispatchQueue를 이용한 동기,비동기 처리

DispatchQueue.main = 메인 스레드에서 실행되는 작업 → UI업데이트 작업, UI관련 작업 (애플에서 메인스레드에서 작업이 되게 지정)
DispatchQueue.global = 백그라운드 쓰레드에서 실행되는 작업 → UI외에 모든 것

동기 - 스레드에서 파일 처리를 순서대로 진행한다. (sync)
비동기 - 스레드에 파일 처리를 동시에 다 같이 진행한다. (async)

week6) DispatchQueue를 이용하여 뷰에 색깔 전환예제
