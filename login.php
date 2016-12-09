<?
header("Content-type: text/xml");
$file=fopen("login.xml","a");
$open = "<customer>";
$first = "<firstName>" .$_POST["first"]. "</firstName>";
$last = "<lastName>" .$_POST["last"]. "</lastName>";
$email = "<contact>" .$_POST["contact"]. "</lastName>";
$user = "<username>" .$_POST["username"]. "</username>";
$pass= "<password>" .$_POST["password"]. "</password>";
$close = "</customer>";

?>