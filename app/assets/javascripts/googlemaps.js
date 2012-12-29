(function() {

  var geocoder = new google.maps.Geocoder();
  var place = $("#address").text();

  geocoder.geocode({
    address: place
  }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var lat = results[0].geometry.location.lat();
      var lng = results[0].geometry.location.lng();
      var latlng = new google.maps.LatLng(lat, lng);
      var myOptions = {
        zoom: 19,
        center: latlng,
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };

      var map = new google.maps.Map(document.getElementById("google-map"), myOptions);

      var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title: "<%= @meeting.location %>"
      });
    } else if (status == google.maps.GeocoderStatus.ERROR) {
      // alert("サーバとの通信時に何らかのエラーが発生！");
    } else if (status == google.maps.GeocoderStatus.INVALID_REQUEST) {
      // alert("リクエストに問題アリ！geocode()に渡すGeocoderRequestを確認せよ！！");
    } else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
      // alert("短時間にクエリを送りすぎ！落ち着いて！！");
    } else if (status == google.maps.GeocoderStatus.REQUEST_DENIED) {
      // alert("このページではジオコーダの利用が許可されていない！・・・なぜ！？");
    } else if (status == google.maps.GeocoderStatus.UNKNOWN_ERROR) {
      // alert("サーバ側でなんらかのトラブルが発生した模様。再挑戦されたし。");
    } else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
      // alert("見つかりません");
    } else {
      // alert("えぇ～っと・・、バージョンアップ？");
    }
  });
})();
