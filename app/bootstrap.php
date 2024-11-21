<?php

/**
 * For security reasons the bootstrap is outside the public directory.
 * This prevents your code from accidentally being exposed in case of server misconfiguration.
 */

require_once __DIR__ . '/vendor/autoload.php';

# Remove everything below this point for your code

$output = $version = '';
exec('php-fpm83 -v', $output);

echo <<<HTML
<!DOCTYPE html><html lang="en"><head>
<title>Hello!</title>
<style>
html,body{width:100%;height:100%;margin:0;padding:0;font-family:sans-serif;background:#202020;color:white}
p {position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);display:flex;align-items:center}
span {font-size:4rem;color:greenyellow;padding:0 10px;}
</style>
</head><body>
<p><span>&checkmark;</span> I'm running on $output[0]</p>
</body></html>
HTML;

exit(0);