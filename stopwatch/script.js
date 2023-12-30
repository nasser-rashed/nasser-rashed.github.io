let startTime;
let elapsedTime = 0;
let timerInterval;
let isRunning = false;

function startStopwatch() {
  if (!isRunning) {
    startTime = Date.now() - elapsedTime;
    timerInterval = setInterval(function () {
      elapsedTime = Date.now() - startTime;
      displayTime(elapsedTime);
    }, 10);
    isRunning = true;
  }
}

function stopStopwatch() {
  if (isRunning) {
    clearInterval(timerInterval);
    isRunning = false;
  }
}

function resetStopwatch() {
  clearInterval(timerInterval);
  elapsedTime = 0;
  displayTime(elapsedTime);
}

function displayTime(time) {
  let minutes = Math.floor((time / 60000) % 60);
  let seconds = Math.floor((time / 1000) % 60);
  let milliseconds = Math.floor((time % 1000) / 10);

  document.getElementById('stopwatch').innerText =
    `${pad(minutes)}:${pad(seconds)}:${pad(milliseconds)}`;
}

function pad(value) {
  return value < 10 ? `0${value}` : value;
}