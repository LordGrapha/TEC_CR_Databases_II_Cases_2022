const {parentPort, workerData} = require("worker_threads");

parentPort.postMessage(getFibonacciNumber(workerData.num))

function getFibonacciNumber(num) {
    return "Thread: " + Number(num).toLocaleString() + " is already" + " done";
}