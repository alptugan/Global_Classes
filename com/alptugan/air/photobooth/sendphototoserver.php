<?php
	include_once("inc/facebook.php"); //include facebook SDK
 
######### edit details ##########
$appId = '400437036681583'; //Facebook App ID
$appSecret = 'b332b6219ea0240ae33bf0cdcf64d322'; // Facebook App Secret
$return_url = 'http://www.filikatasarim.com/serratest/process.php';  //return url (url to script)
$homeurl = 'http://www.filikatasarim.com/serratest/';  //return to home
$fbPermissions = 'publish_stream,manage_pages';  //Required facebook permissions
##################################

//Call Facebook API
$facebook = new Facebook(array(
  'appId'  => $appId,
  'secret' => $appSecret,
));



$fbuser = $facebook->getUser();


if ($fbuser) {
  try {
    // Proceed knowing you have a logged in user who's authenticated.
    $user_profile = $facebook->api('/me');
  } catch (FacebookApiException $e) {
    error_log($e);
    $user = null;
  }
}


/*


if ( isset ( $GLOBALS["HTTP_RAW_POST_DATA"] )) {
    $uniqueStamp = date(U);
    $filename = $uniqueStamp.".jpg";
    $fp = fopen( $filename,"wb");
    fwrite( $fp, $GLOBALS[ 'HTTP_RAW_POST_DATA' ] );
    fclose( $fp );
 
 
 	
}
*/
 $userPageId		= 'QrCodeReaderCommunity';
	$userMessage 	= 'this is message';
	
	//$picturePath    = $_POST["picturePth"];
	
	if(strlen($userMessage)<1) 
	{
		//message is empty
		$userMessage = 'No message was entered!';
	}
	
		//HTTP POST request to PAGE_ID/feed with the publish_stream
		$post_url = '/'.$userPageId.'/feed';

		$msg_body = array(
		'message' => $userMessage,
			'name' => 'Burası İsim Alanı',
			'caption' => $picturePath,
			'link' => 'http://www.filikatasarim.com/serratest/',
			'description' => 'hack php script dikkat',
			'picture' => 'http://www.filikatasarim.com/serratest/'.$filename,
			'actions' => array(
								array(
									'name' => 'filika tasarim',
									'link' => 'http://www.filikatasarim.com/serratest/'.$filename
								)
							)
		);
		
		
	
		//posts message on page statues 
		$img = '../photo_upload/url.png';

		/*
		$photo = $facebook->api('/'.$userPageId.'/photos', 'POST',
                        array( 'source' => '@' . $img,
                               'message' => 'Photo uploaded via the PHP SDK!'
                       ));
                       */
                       
	if ($fbuser) {
	  try {
			$postResult = $facebook->api($post_url, 'post', $msg_body );
			echo "filename=".$filename."&base=".$_SERVER["HTTP_HOST"].dirname($_SERVER["PHP_SELF"])."&folder=".dirname($_SERVER["PHP_SELF"]);

		} catch (FacebookApiException $e) {
		//echo $e->getMessage();
		echo "filename=sic";

	  }
	}else{
	 /*$loginUrl = $facebook->getLoginUrl(array('redirect_uri'=>$homeurl,'scope'=>$fbPermissions));
	 header('Location: ' . $loginUrl);*/
	 echo "filename=sicis";
	}

?>