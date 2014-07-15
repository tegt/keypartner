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

    $oKey = $_POST['okey'];
    $mId = $_POST['mId'];
    $iSeq = $_POST['iSeq'];
    $sName = $_POST['sName'];

    $upDir = dirname(__FILE__);

    if ($oKey <> '' && $iSeq < 1) {
        echo('<h1>FAIL: No item number provided.</h1>');
    }
    elseif ($sName == '') {
        echo('<h1>FAIL: No slot name provided.</h1>');
    }
    elseif ($mId > 0) {

        $o = $DBO->run("SELECT mpId, mId, sId, sType "
                       ."FROM models "
                       ."JOIN slots ON mmId=smId "
                       ."WHERE sName='".$DBO->esc($sName)
                       ."' AND mId=".$mId)->object();

        if ($o->sType <> 'file') {
            echo "<h1>This is not a 'file' asset!!</h1>";
            print_r($o);
            die('Stopped');
        }
        $upName = $upDir.'/partner/'.$sName.'-m'.$mId.'-p'.$o->mpId;

        //        $fi = new finfo(FILEINFO_MIME);
        //        $mime = $fi->file($_FILES['ufile']['tmp_name']);

        /* $fi = finfo_open(FILEINFO_MIME_TYPE); */
        /* $mime = finfo_file($_FILES['ufile']['tmp_name']); */

        $mime = 'image/jpeg; charset=binary';

        if (move_uploaded_file($_FILES['ufile']['tmp_name'], $upName)) {
            echo "Valid file uploaded to $upName.\n";

            $DBO->run('INSERT INTO assetspartner SET '
                      ."appId=".$o->mpId.", "
                      ."apmId=".$o->mId.", "
                      ."apVal=".$DBO->esq($upName).", "
                      ."apMime=".$DBO->esq($mime).", "
                      .'apsId='.$o->sId
                      .'  ON DUPLICATE KEY UPDATE'
                      .'     apVal='.$DBO->esq($upName).','
                      .'     apMime='.$DBO->esq($mime));


            $DBO->run('INSERT INTO assetspartner'
                      .'   (appId, apmId, apMime, apVal, apsId)'
                      .$DBO->values( $o->mpId, 
                                     $o->mId, 
                                     $DBO->esq($upName), 
                                     $DBO->esq($mime), 
                                     $o->sId )
                      .'ON DUPLICATE KEY UPDATE'
                      .'     apVal='.$DBO->esq($upName).','
                      .'     apMime='.$DBO->esq($mime));
        } 
        else {
            echo "Errors with upload! ($upName) --".$_FILES['ufile']['error'];
        }    
    }
    elseif ($oKey <> '') {
        $upName = $upDir.'/customer/'.$sName.'-'.$oKey.'-'.$iSeq;

        $o = $DBO->run("SELECT iId, sId, sType "
                       ."FROM keysorder "
                       ."JOIN orders ON oId=koOId " 
                       ."JOIN items ON ioId=oId and iSeq=".$iSeq." "
                       ."JOIN models ON imId=mId "
                       ."JOIN slots ON mmId=smId and sName='".$DBO->esc($sName)."' "
                       ."WHERE koKey='".$DBO->esc($oKey)."'"
                       )->object();

        if ($o->sType <> 'file') {
            echo "<h1>This is not a 'file' asset!!</h1>";
            print_r($o);
            die('Stopped');
        }

        /* $fi = new finfo(FILEINFO_MIME); */
        /* $mime = $fi->file($_FILES['ufile']['tmp_name']); */

        $mime = 'image/jpeg; charset=binary';

        /* $fi = finfo_open(FILEINFO_MIME_TYPE); */
        /* $mime = finfo_file($_FILES['ufile']['tmp_name']); */

        if (move_uploaded_file($_FILES['ufile']['tmp_name'], $upName)) {
            echo "Valid file uploaded to $upName.\n";

            $DBO->run('INSERT INTO assetscustomer SET '
                      ."acVal='".$DBO->esc($upName)."', "
                      ."acMime='".$DBO->esc($mime)."', "
                      .'aciId='.$o->iId.", "
                      .'acsId='.$o->sId);
        } else {
            echo "Errors with upload! ($upName) --".$_FILES['ufile']['error'];
        }
    }
    else {
        echo('<h1>FAIL: No mId or oKey.</h1>');
    }
    echo '</body>';
    exit;
}

$reply = '';
$oKey = $_GET['okey'];
$mId = $_GET['mId'];
$iSeq = $_GET['item'];
$sName = $_GET['sName'];

echo '
   <head>
     <title>Upload Asset Files</title>
   </head>
   <body>
     <form action="/orderup/assets/" method="POST" enctype="multipart/form-data">
';


if ($sName == '') {
    echo('<h1>FAIL: Get has no sName.</h1>');
}
elseif ($mId > 0) {
    $o = $DBO->run('SELECT mName FROM models WHERE mId='.$mId)->object();
    echo '<h1>Upload Partner Default Asset for "'
        .$o->mName.'"-'.$sName.'</h1>'
        .'<input type="text" name="mId" value="'.$mId.'">Model Id<br />'
        .'<input type="text" name="sName" value="'.$sName.'">Slot<br />'
        .'From: <input name="ufile" type="file">';
    echo '<input type="submit" value="Send File">';
}
elseif ($oKey <> '' || $iSeq) {
    $o = $DBO->run("SELECT oId, oNote, mName, iSeq
                      FROM keysorder 
                      LEFT JOIN items ON ioId=koOId
                      LEFT JOIN models ON imId=mId
                      LEFT JOIN orders ON ioId=oId
                        WHERE koKey='".$oKey."'")->object();
    echo '<h1>Upload Asset for Order #'.$o->oId.' "'.$o->oNote.'".</h1>'
        .'<h2>Item #'.$o->iSeq.' "'.$o->mName.'"-'.$sName.'</h2>'
        .'<input type="text" name="okey" size="60" value="'.$oKey.'">Order key<br />'
        .'<input type="text" name="iSeq" value="'.$iSeq.'">Item number<br />'
        .'<input type="text" name="sName" value="'.$sName.'">Slot name<br />'
        .'From: <input name="ufile" type="file"<br />';
    echo '<input type="submit" value="Send File">';
}
else {
    echo('<h1>FAIL: No mId or oKey/iSeq pair!!</h1>');    
}

echo '
</form><body>
';
?>