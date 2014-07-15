<?Php
include '../../../inc/boot.inc';
kptBoot(__FILE__);

$reply = '';
$mList = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $pIndex = $_POST['partner'];
    $mIndex = $_POST['model'];

    switch ($_POST['do']) {

    case 'Change Selection':
        break; // just cycle the display with Indexes

    case 'New Partner':
        if ($_POST['pCompany'] == '') {
            $reply = 'Failed: Company name is required for a new Partner!';
            break;
        }
        $r = $DBO->run("INSERT partners SET pCompany='"
                       .$DBO->esc($_POST['pCompany'])
                       ."'"
                       );
        $pIndex = $r->insertId();
        $kpKey = KptKey::gen($pIndex, 'P');
        $r = $DBO->run("INSERT keyspartner SET"
                       ." kpKey='".$DBO->esc($kpKey)
                       ."', kpPid=".$pIndex
                       .", kpNote='Fist key'"
                       );
        
        break;

    case 'New Partner Key':
        $pIndex = $_POST['partner'];
        if ($pIndex < 1) {
            $reply = 'Failed: Select a Partner to own this Key.';
            break;
        }
        $kpKey = KptKey::gen($pIndex, 'P');
        $kpNote = $_POST['pKeyNote'];
        if ($kpNote == '') {
            $reply = 'Failed: You must enter a Key Note!';
            break;
        }
        $r = $DBO->run("INSERT keyspartner SET"
                       ." kpKey='".$DBO->esc($kpKey)
                       ."', kpPid=".$pIndex
                       .", kpNote='".$kpNote."'"
                       );
        break;

    case 'New Model Key':

        if ($pIndex < 1 || $mIndex < 1) {
            $reply = "FAIL: You must select a Partner and a Model";
            break;
        }

        $mKeyNote = $_POST['mKeyNote'];
        if ($mKeyNote == '') {
            $reply = "FAIL: You must enter a Note for the new Model key!";
            break;
        }

        $kmKey = KptKey::gen($mIndex, 'M');

        $r = $DBO->run("INSERT keysmodel SET "
                       ."kmKey='".$DBO->esc($kmKey)."', "
                       ."kmMid=".$mIndex.", "
                       ."kmNote='".$DBO->esc($mKeyNote)."'"
                       );
        $reply = "New Key for Model created.";
        break;

    case 'New Model':
        $fModel = $_POST['modelName'];
        if ($fModel == '') {
            $reply = 'FAIL: New model must have a name!!';
            break;
        }
        /** Use master model 42 as the basis */
        /** One Image master is  model 65 */
        $masterModel = 65; // 42 is two image master
        $o = $DBO->run('SELECT * FROM models WHERE mId='.$masterModel)->object();
        $DBO->run('INSERT models SET '
                  ."mmId=".$masterModel.", "
                  ."mpId=".$pIndex.", "
                  ."mName='".$DBO->esc($fModel)."', "
                  ."mPartNum='".$DBO->esc($o->mPartNum)."', "
                  ."mPrintFloPart='".$DBO->esc($o->mPrintFloPart)."', "
                  ."mStructure='".$DBO->esc($o->mStructure)."', "
                  ."mCost=".$o->mCost);
        
        $reply = 'New Model added.';
        break;

    case 'Delete Checked Keys':
        $dKeys = $_POST['pkeys'];
        if (! is_array($dKeys) || count($dKeys) < 1) {
            $reply = "FAIL: No Partner keys were checked!";
            break;
        }
        $r = $DBO->run("DELETE FROM keyspartner WHERE kpKey IN ('".
                       implode("', '", $dKeys)."')");
        break;

    case 'Delete Selected Model':
        if ($mIndex < 1) {
            $reply = "FAIL: No model to delete!!";
        }
        $DBO->run('DELETE FROM models where mId='.$mIndex);
        $reply = "Deleted Model.";
        break;

    case 'Delete Checked Model Keys':
        $mKeys = $_POST['mkeys'];
        if (! is_array($mKeys) || count($mKeys) < 1) {
            $reply = "FAIL: No Partner keys were checked!";
            break;
        }
        $r = $DBO->run("DELETE FROM keysmodel WHERE kmKey IN ('".
                       implode("', '", $mKeys)."')");
        break;

    case 'New Order':
        if ($mIndex < 1) {
            $reply = "No Model for order item.";
            break;
        }
        
        $oNote = $_POST['oNote'];
        if ($oNote == '') {
            $reply = "FAIL: You must enter an Order Note!!";
        }

        $oId = $DBO->run("INSERT INTO orders SET "
                         ."oNote='".$DBO->esc($oNote)."'")->insertId();

        $oKey = KptKey::gen($oId, 'O');
        $r = $DBO->run("INSERT keysorder SET"
                       ." koKey='".$DBO->esc($oKey)
                       ."', koOid=".$oId
                       .", koNote='auto key'"
                       );

        $r = $DBO->run("INSERT INTO items SET "
                       ."ioId=".$oId.", "
                       ."imId=".$mIndex.", "
                       ."iNote='Item modeled from \"".$DBO->esc($oNote)."\"'");
        break;

    case 'Delete Checked Orders':

        $orderIds = $_POST['orderids'];
        if (! is_array($orderIds) || count($orderIds) < 1) {
            $reply = "FAIL: No Orders were checked!";
            break;
        }

        $r = $DBO->run("SELECT acId 
                          FROM assetscustomer 
                          LEFT JOIN items ON aciId=iId
                            WHERE ioId IN (".implode(", ", $orderIds).")");

        $acIds = array();
        while ($o = $r->object()) { // gather assets
            $acIds[] = $o->acId;
        }
        
        if ($acIds) {
            $r = $DBO->run("DELETE FROM assetscustomer WHERE acId IN ("
                           .implode(", ", $acIds).")");
        }

        $r = $DBO->run("DELETE FROM items WHERE ioId IN ("
                       .implode(", ", $orderIds).")");

        $r = $DBO->run("DELETE FROM orders WHERE oId IN ("
                       .implode(", ", $orderIds).")");
        break;

    default:
        echo '<h2>Unexpected submit "do"="'.$_POST['do'].'"</h2>';
        phpinfo(INFO_VARIABLES);
        exit;
    }
}

echo '
   <head>
     <title>Fake Orders</title>
   </head>
   <body>
     <h1>Fake Partner and Order maker</h1>
     <form action="/orderup/keys/" method="POST">
';

if ($reply <> '') {
    echo "<h3>$reply</h3>
";
}

/** Display partners 
 *
 */
$r = $DBO->run('SELECT pId, kpKey, kpNote, pLimit, pCompany 
                 FROM partners 
                 LEFT JOIN keyspartner on kpPId=pId
                 order by pId');
$lastPid = 0;
echo '<ul>';
$ul2 = '';

while ($o = $r->object()) {
    $disabled = '';
    if ($o->pLimit < 1) {
        $disabled = 'disabled="disabled"';
    }
    elseif ($pIndex == '') {
        $pIndex = $o->pId;
    }
    if ($pIndex == $o->pId)  {
        $pChk = 'checked="checked"';
        $pSel = $o->pCompany;
    }
    else {
        $pChk = '';
    }

    if ($lastPid <> $o->pId) {
        echo $ul2.'<li><input type="radio" name="partner" value="'
            .$o->pId.'" '.$pChk.' '.$disabled.' />['
            .$o->pId.'] '
            .$o->pCompany.'<ul>
';
        $ul2 = '</ul></li>';
        $lastPid = $o->pId;
    }
    if (isset($o->kpKey)) {
        echo '<li><input type="checkbox" name="pkeys[]" value="'
            .$o->kpKey.'"><code>'.$o->kpKey.'</code> | '
            .$o->kpNote.'</li>
';
    }
}

echo $ul2.'
       <p><input type="submit" name="do" value="Change Selection" />
	      <input type="submit" name="do" value="Delete Checked Keys" /></p>';
echo '
       <p>New Key for selected Partner. Key note:<br />
	     <input type="text" size="60" name="pKeyNote" value="" />
	     <input type="submit" name="do" value="New Partner Key" /></p>
       <p>New Partner Company Name:<br />
	     <input type="text" size="60" name="pCompany" value="" />
	     <input type="submit" name="do" value="New Partner" /></p>
';

/** Show partners models */
echo "<h2>\"$pSel\" Models</h2>";

$r = $DBO->run($xq = "SELECT mId, mName, kmKey, kmNote
                  FROM models 
                  LEFT JOIN keysmodel ON kmMid=mId
                    WHERE mpId=".$pIndex);

$checked = ' checked="checked" ';
$lastMid = 0;
$mLend = '';

while ($o = $r->object()) {

    if ($mIndex =='') {
        $mIndex = $o->mId;
    }

    if ($mIndex == $o->mId)  {
        $mChk = 'checked="checked"';
    }
    else {
        $mChk = '';
    }

    if ($lastMid = $o->mId) { // model changed
        echo $mLend;
        echo '<li><input type="radio" name="model" '
            .$mChk
            .' value="'.$o->mId
            .'" />['.$o->mId.'] '
            .$o->mName.'<ul>
';
        $mLend = '</ul></li>';
        $lastMid = $o->mId;
    }
    if (isset($o->kmKey)) {
        echo '<li><input type="checkbox" name="mkeys[]" value="'
            .$o->kmKey.'"><code>'.$o->kmKey.'</code> | '
            .$o->kmNote.'</li>
';            
    }
}
echo $mLend;

if ($mLend <> '') { // some models displayed
    echo '<p>';
	echo '<input type="submit" name="do" value="Change Selection" />';
    echo '<input type="submit" name="do" value="Delete Selected Model" />';
    echo '<input type="submit" name="do" value="Delete Checked Model Keys" />';
    echo '</p>';
}
    echo '
          <p>New Model for selected Partner. Model Name:<br />
	    <input type="text" size="60" name="modelName" value="" />
	    <input type="submit" name="do" value="New Model" /></p>';

if ($mLend <> '') { // some models displayed
    echo '
          <p>New Key for selected Model. Key note:<br />
	    <input type="text" size="60" name="mKeyNote" value="" />
	    <input type="submit" name="do" value="New Model Key" /></p>
          <p>Note for new Order of selected Model:<br />
	    <input type="text" size="60" name="oNote" value="" />
	    <input type="submit" name="do" value="New Order" /></p>';
}

/** Show Partner Orders */
if ($mIndex < 1) {
    echo "<h2>\"$pSel\" No Orders</h2>";
}
else {
    echo "<h2>\"$pSel\" Orders</h2>";

    $r = $DBO->run('
  SELECT oId, oNote, koKey, iId, iSeq, iCopies, mName, mId, sId, sName, acVal, apmId, apVal
    FROM orders 
    JOIN keysorder ON koOid=oId
    LEFT JOIN items ON ioId = oId
    LEFT JOIN models ON imId=mId
    LEFT JOIN slots ON mmId=smId
    LEFT JOIN assetspartner ON  mpId=appId AND apsId=sId AND apmId=imId
    LEFT JOIN assetscustomer ON aciId=iId AND acsId=sId
      WHERE mpId='.$pIndex.' AND mId='.$mIndex.'
      ORDER BY oId, iSeq');

    $lastOid = $lastIid = $lastCid = 0;
    $iLend = $oLend = '';

    while ($o = $r->object()) {
        //        var_dump($o);

        if ($lastOid <> $o->iId) { // order changed
            $lastOid = $o->iId;
            echo $iLend.$oLend;
            $lastIid = 0;
            $iLend = '';
            echo '<li><input type="checkbox" name="orderids[]" '
                .' value="'.$o->oId
                .'" />Order ['.$o->oId
                .'] "'.$o->oNote
                .'" '.$o->koKey.'<ul>
';
            $oLend = '</ul></li>';
        }
        
        if (isset($o->iId)) { // item changed
            if ($lastIid <> $o->iId) {
                $lastIid = $o->iId;
                echo $iLend;
                $iLend = '';
                echo '<li> ['.$o->iId.'] iSeq-'.$o->iSeq
                    .', copies-'.$o->iCopies
                    .' "'.$o->mName
                    .'"<ul>
';            
                $iLend = '</ul></li>';
            }
            if (isset($o->sId)) {
                echo '<li>'.$o->apmId.':'.$o->sName.'="'.$o->acVal
                    .'" <a href="/orderup/assets?okey='.$o->koKey
                    .'&item='.$o->iSeq
                    .'&sName='.$o->sName
                          .'" target="_blank">Load new value</a>
                      ['.$o->apVal.']
                        <a href="/orderup/assets?mId='.$o->mId.'&sName='.$o->sName
                          .'" target="_blank">Load default value</a></li>
';
            }

        }



        if (isset($o->cId)) {
            echo '';
        }
    }
    echo $iLend.$oLend;

    if ($oLend <> '') { // some orders displayed
        echo '<p>';
        echo '<input type="submit" name="do" value="Delete Checked Orders" />';
        echo '</p>';
    }
}

//echo "<p><code>$DebugOmy</code></p>";

echo '</form></body>';
exit;
?>
