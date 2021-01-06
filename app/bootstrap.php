<?php

/**
 * For security reasons the bootstrap is outside the public directory.
 * This prevents your code from being accidentally exposed in case of a server misconfiguration.
 */

require_once __DIR__ . '/vendor/autoload.php';

echo 'I\'m running!';