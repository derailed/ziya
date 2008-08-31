<?php
    if(!function_exists("imagecreate")) die("Sorry, the GD library is needed to run this script.");

	$data = explode(",", $_POST['img']);
	$width = $_POST['width'];
	$height = $_POST['height'];
	$image=imagecreatetruecolor( $width ,$height );
	$background = imagecolorallocate( $image ,0 , 0 , 0 );
	//Copy pixels
	$i = 0;
	for($x=0; $x<=$width; $x++){
		for($y=0; $y<=$height; $y++){
			$int = hexdec($data[$i++]);
			$color = ImageColorAllocate ($image, 0xFF & ($int >> 0x10), 0xFF & ($int >> 0x8), 0xFF & $int);
			imagesetpixel ( $image , $x , $y , $color );
		}
	}
	//Output image and clean
	header( "Content-type: image/jpeg" );
	ImageJPEG( $image );
	imagedestroy( $image );	
?>

