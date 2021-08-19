<?php
if (isset($_GET['uri'])) {
    $preview = returnDBObject("SELECT * FROM datatype_videos WHERE uri=?", [$_GET['uri']]);
?>
    <head>
        <title><?php echo $preview['title']; ?> | skygolpe</title>
    </head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <div style="padding:20px">
        <video width="100%" style="height:calc(92vh)" muted="muted" playsinline loop="loop" id="video_player">
            <source src="/contents/<?php echo $preview['media']; ?>" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
    <script>
        $('#video_player').height(window.innerHeight-60);
        setTimeout(function(){
            $("#video_player")[0].play();
        }, 500)
    </script>
<?php } else {
    die('Provide URI');
} ?>