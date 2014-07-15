<?php
include '../../../inc/boot.inc';
kptBoot(__FILE__);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    echo '
       <head>
	 <title>Asset Uploaded</title>
       </head>
       <body>
';

    $iKey = $_POST['ikey'];
    $mId = $_POST['mId'];
    $sName = $_POST['sName'];
    print_r($_FILES);

    $upDir = dirname(__FILE__);

    if ($sName == '') {
        echo('<h1>FAIL: No slot name provided.</h1>');
    }
    elseif ($mId > 0) {
        $upName = $upDir.'/partner/'.$sName.'-'.$mId;
        if (move_uploaded_file($_FILES['ufile']['tmp_name'], $upName)) {
            echo "Valid file uploaded to $upName.\n";
        } else {
            echo "Errors with upload! ($upName) --".$_FILES['ufile']['error'];
        }    }
    else if ($iKey <> '') {
        $upPath = $upDir.'/customer/'.$sName.'-'.$iKey;
        if (move_uploaded_file($_FILES['ufile']['tmp_name'], $upName)) {
            echo "Valid file uploaded to $upName.\n";
        } else {
            echo "Errors with upload! ($upName) --".$_FILES['ufile']['error'];
        }
    }
    else {
        echo('<h1>FAIL: No mId or iKey.</h1>');
    }
    echo '</body>';
    exit;
}

$reply = '';
$iKey = $_GET['ikey'];
$mId = $_GET['mId'];
$sName = $_GET['sName'];

echo '
   <head>
     <title>Upload Asset Files</title>
   </head>
   <body>
     <form action="/loadup/form/" method="POST">
';


if ($sName == '') {
    echo('<h1>FAIL: No slot name provided.</h1>');
}
elseif ($mId > 0) {
    $o = $DBO->run('SELECT mName FROM models WHERE mId='.$mId)->object();
    echo '<h1>Upload Partner Default Asset for "'
        .$o->mName.'"-'.$sName.'</h1>'
        .'<input type="text" name="mId" value="'.$mId.'">Model Id<br />'
        .'<input type="text" name="sName" value="'.$sName.'">Slot<br />'
        .'From: <input name="uFile" type="file">';
    echo '<input type="submit" value="Send File">';
}
elseif ($iKey <> '') {
    $o = $DBO->run("SELECT oId, oNote, mName, iSeq
                      FROM items
                      LEFT JOIN models ON imId=mId
                      LEFT JOIN orders ON ioId=oId
                        WHERE iKey='".$iKey."'")->object();
    echo '<h1>Upload Asset for Order #'.$o->oId.' "'.$o->oNote.'".</h1>'
        .'<h2>Item #'.$o->iSeq.' "'.$o->mName.'"-'.$sName.'</h2>'
        .'<input type="text" name="iKey" size="50" value="'.$iKey.'">iKey<br />'
        .'<input type="text" name="sName" value="'.$sName.'">Slot<br />'
        .'From: <input name="uFile" type="file"<br />';
    echo '<input type="submit" value="Send File">';
}
else {
    echo('<h1>FAIL: No mId or iKey!!</h1>');    
}

echo '
</form><body>
';
?>