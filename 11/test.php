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

function huffmannEncode($string) {
    $string = unpack("C*", $string); // why the fuck is this 1 indexed
    $occs = [];
    $original = [];
    foreach($string as $v)$original[] = $v;

    $dict = array_count_values($string);

    foreach($dict as $k => $v) $occs[] = [$v, $k];
    sort($occs);
    while (count($occs) > 1) {
        $row1 = array_shift($occs);
        $row2 = array_shift($occs);
        $occs[] = array($row1[0] + $row2[0], array($row1, $row2));
        sort($occs);
    }
    // $dictionary is an array that gets filled with the values with a recursive method
    $dictionary = [];
    fillDictionary($dictionary, is_array($occs[0][1]) ? $occs[0][1] : $occs);

    // Generate the final encoded message
    $encoded = '';
    for($i = 0; $i < count($original); $i++) {
        $encoded .= $dictionary[$original[$i]];
    }

    return [$dictionary,$encoded];
}

// This function runs recursively to generate the Huffmann tree
function fillDictionary(&$dictionary, $data, $value = '') {
    if (!is_array($data[0][1])) {
        $dictionary[$data[0][1]] = $value.'0';
    } else {
        fillDictionary($dictionary, $data[0][1], $value.'0');
    }
    if (isset($data[1])) {
        if (!is_array($data[1][1])) {
            $dictionary[$data[1][1]] = $value.'1';
        } else {
            fillDictionary($dictionary, $data[1][1], $value.'1');
        }
    }
}

function huffmanDecode($dict, $string) {
    $pref = "";
    $dict  = array_flip($dict);
    $final = [];
    foreach (str_split($string) as $c) {
        $pref .= $c;
        if(array_key_exists($pref, $dict)) {
            //echo $pref ." \n" . $dict[$pref] . "\n"; 
            $final[] = $dict[$pref];
            $pref = "";
        }
    }
    return pack("C*",...$final);
}
[$dict, $temp] = huffmannEncode("⍺⍴⎕");
print($temp . "\n"); 
print_r(huffmanDecode($dict, $temp) . "\n");
?>