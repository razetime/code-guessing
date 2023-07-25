<?php /*
 * wHY ARE yoU writinG pHP?
 * fuck you.
 *
 * tested on:
 * PHP 7.4.3 (cli) (built: Nov 25 2021 23:16:22) ( NTS )
 * Copyright (c) The PHP Group
 * Zend Engine v3.4.0, Copyright (c) Zend Technologies
 * with Zend OPcache v7.4.3, Copyright (c), by Zend Technologies
 */

error_reporting(0); // remove this for fun warnings (bigger input = more fun!)

function compress($s) {
    $s = unpack("C*", $s); // why the fuck is this 1 indexed
    $z = [];
    foreach($s as $v)$z[] = $v;

    $dict = array_count_values($s);

    // PHP FP makes me want to die:
    // $o = array_map(fn($k,$v) => [$k,$v], array_values($dict),array_keys($dict));
    $o = [];
    foreach($dict as $k => $v) $o[] = [$v, $k];
 
    sort($o);
    while (count($o) > 1) {
        $row1 = array_shift($o);
        $row2 = array_shift($o);
        $o[] = array($row1['0'] + $row2[0], array($row1, $row2));
        sort($o);
    }
    $d = [];
    fill($d, $o[0][1][0] ? $o[0][1] : $o);

    $e = '';
    for($i = 0; $i < count($z); $i++) $e .= $d[$z[$i]];
    $x = (8 - (strlen($e) % 8));
    $e = str_pad($e, strlen($e) + $x,0,0);

    $_POST = "";
    foreach($d as $k=>$v) $_POST .= $k . p . $v . j;


    $_GET = [];
    for($i = 0; $i < strlen($e); $i += 8) {
        $_GET[] = bindec(substr($e,$i,8));
    }
    return count($d)+1 .j.$x.j.$_POST.pack("C*", ...$_GET);
}

function fill(&$d, $t, $v = '') {
    if (!$t[0][1][0]) {
        $d[$t[0][1]] = $v . 0;
    } else {
        fill($d, $t[0][1], $v . 0);
    }
    if ($t[1]) {
        if (!$t[1][1][0]) {
            $d[$t[1][1]] = $v . 1;
        } else {
            fill($d, $t[1][1], $v . 1);
        }
    }
}

function decompress($s) {
    [$GLOBALS, $p, $r] = explode(j, $s, 3);
    $h = [];

    $r = explode(j, $r, $GLOBALS);
    $s = array_pop($r);
    foreach($r as $str) {
        [$k,$v] = explode(p, $str);
        $h[$v] = $k;
    }
    
    $b = "";
    foreach(unpack("C*",$s) as $num) {
        $b .= str_pad(decbin($num),8,0,0);
    }
    $b = substr($b, $p);

    $_ENV = "";
    $f = [];
    if(!$b) return "";
    foreach (str_split($b) as $c) {
        $_ENV .= $c;
        if($h[$_ENV]) {
            $f[] = $h[$_ENV];
            $_ENV = "";
        }
    }
    return pack("C*",...$f); // why the FUCK does this need a spread
}
print($a =compress("sadasdasfdsfsdadasfasdfsdfsdhfghsdhfdshgfshadgfhjsdgfjgsdjfgsdfjhagsdfjhgsdfjhghjsdgjfgahjdsghfgsdf")) ."\n";
print(decompress($a) . "\n");
?>