<?php
header("Content-Type: text/html; charset=utf-8");
$SubjectHeader = ('  adlı kullanıcı iletisim bölümünden mail attı');
$to = "mertvolkan@gmail.com";
$lang = $_POST["language"];
$subject = $_POST["Sender"].$SubjectHeader;

$headers = "From: " . $_POST["Sender"] . " <" . $_POST["Email"] . ">\r\n";
$headers .= "Reply-To: " . $_POST["Email"] . "\r\n";
$headers .= "Return-path: " . $_POST["Email"];


$message .= "Gönderen: ";
$message .= $_POST["Sender"] . " <" . $_POST["Email"]  . ">";
$message .= "\n\n---------------------------\n";
$message .= "Mesaj Konusu: ";
$message .= "\n";
$message .= ($_POST["Subject"]);
$message .= "\n\n---------------------------\n";
$message .= "Mesaj İçeriği: ";
$message .= "\n";
$message .= ($_POST["Mesaj"]);
$message .= "\n\n---------------------------\n";


$ResponseTo =  $_POST["Email"];
$ResponseSubject = 'Mert Volkan';

if($lang == "tr")
{
	$ResponseMessage = "Merhaba,\n\nMesajınız bana ulaştı.
	\n\nTeşekkürler,\n";
}else{
	$ResponseMessage = "Hi, \n\nYour message has reached us.
	We will contact you as soon as possible.\n\nJingle Mingle - Audio & Music Production";
}


$ResponseHeader = "From: Mert Volkan"."<".$to.">";

if(@mail($to, $subject, $message, $headers))
{
	if(@mail($ResponseTo, $ResponseSubject, $ResponseMessage, $ResponseHeader))
	{
		echo "answer=ok";
	}
} 
else 
{
	echo "answer=error";
}

?>