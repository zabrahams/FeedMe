(function () {
  if (typeof TimeUtils === "undefined") {
    window.TimeUtils = {};
  }

TimeUtils.MIN = 60;
TimeUtils.HOUR = 3600;
TimeUtils.DAY = 86400;
TimeUtils.MONTH = 2592000;
TimeUtils.YEAR = 31104000;

TimeUtils.getTimeDiff = function (time) {
  var seconds = Math.round((Date.now() - Date.parse(time)) / 1000);

  if (seconds < TimeUtils.MIN) {
    return seconds.toString() + "s ago";

  } else if (seconds < TimeUtils.HOUR) {
    return Math.round((seconds / TimeUtils.MIN)).toString() + "m ago";

  } else if (seconds < TimeUtils.DAY) {
    return Math.round((seconds / TimeUtils.HOUR)).toString() + "h ago";

  } else if (seconds < TimeUtils.MONTH) {
    return Math.round((seconds / TimeUtils.DAY)).toString() + "d ago";

  } else if (seconds < TimeUtils.YEAR) {
    return Math.round((seconds / TimeUtils.MONTH)).toString() + "mon ago";
  } else {
    return Math.round((seconds / TimeUtils.YEAR)).toString() + "y ago";
  }
}

})();
