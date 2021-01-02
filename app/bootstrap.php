<?php

/**
 * For security reasons our bootstrap is outside the public directory.
 * This prevents exposing your private code in case of a server misconfiguration.
 */

require_once __DIR__ . '/vendor/autoload.php';

echo 'I\'m running!';