<?php
/** partnerKeys.php
 *
 * Template Name: Partner Keys
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @author		Grant Tegtmeier
 * @package		RPI
 */

get_header(); ?>

<section id="primary" class="span8">
	<?php tha_content_before(); ?>
	<div id="content" role="main" class="rpi">
		<?php tha_content_top();
		
		if ( have_posts() ) {
			while ( have_posts() ) {
				the_post();
				get_template_part( '/partials/content', get_post_format() );
			}

            // decend into angel structure
            require_once '/home/tegt/storefront/angel/inc/boot.inc';
            rpiBoot(__FILE__);
            
            $do = $_POST['do'];
            $postErr = '';

            switch ($do) {

            case 'Add a New Key':
                $newKeyNote = trim(stripslashes($_POST['newkey-note']));
                $newKeyMsg = trim(stripslashes($_POST['newkey-msg']));

                if (empty($newKeyNote)) {
                    $postErr = 'New Key Note cannot be blank!';
                    break;
                }

                $kpKey = RpiKey::gen($pIndex, 'P');
                $r = $DBO->run("INSERT keyspartner SET"
                               ." kpKey=".$DBO->esq($kpKey)
                               .", kpPid=".$_POST['myPid']
                               .", kpNote=".$DBO->esq($newKeyNote)
                               .", kpMsg=".$DBO->esq($newKeyMsg)
                               );
                break;

            default:
                $keyNote = trim(stripslashes($_POST['note']));
                $keyMsg = trim(stripslashes($_POST['msg']));

                try {
                    if (RpiKey::type($do) == 'P') { // action only if it's a valid partner key

                        if (empty($keyMsg)) {
                            $postErr = 'Key Note cannot be blank!';
                            break;
                        }

                        $r = $DBO->run("UPDATE keyspartner SET"
                                       ."  kpNote=".$DBO->esq($keyNote)
                                       .", kpMsg=".$DBO->esq($keyMsg)
                                       ."  WHERE kpKey=".$DBO->esq($do)
                                       );
                    }
                }
                catch (Exception $e) {
                    // -- just ignore invalid keys
                }
            }

            if (! empty($postErr)) {
                echo '<div class="pErr">'.$postErr.'</div>';
            }

            $r = $DBO->run('SELECT *'
                           .' FROM partners'
                           .' LEFT JOIN keyspartner on kpPId=pId'
                           .'   WHERE pUsername='.$DBO->esq($user_login)
                           .'     ORDER BY left(kpMsg,3) = "** ", kpNote'
                           );

            
            $partnerFound = is_object($o = $r->object()); // need first row early
            $keyFound = false;
            $inText = '<input type="text" class="better" name="';

            if ($partnerFound) { // some rows found

                echo '<hr /><ul>';
                echo '<li><form method="POST" action="."><input type="submit" value="Add a New Key" name="do"'
                    .' class="bullbutt" />'
                    .'<input type="hidden" name="myPid" value="'.$o->pId.'">'
                    .'<ul><li>Note: '.$inText.'newkey-note" value="" /></li>'
                    .'<li>Msg: '.$inText.'newkey-msg" value="" /></li></form></ul><hr />';

                do {
                    if (! empty($o->kpPId)) { // have a key
                        $keyFound = true;
                        $rKey = $o->kpKey;

                        if (substr($o->kpMsg,0,3) == '** ') {
                            $rKey = '<span class="pRed">'.$rKey.'</span>';
                        }

                        echo '<li> '.$rKey
                            .'<form class="iform" method="POST" action="."> '
                            .'<button class="bullbutt" type="submit" value="'.$o->kpKey.'" name="do" >Update</button>'
                            .'<ul><li>Note: '.$inText
                            .'note" value="'.$o->kpNote.'" /></li>'
                            .'<li>Msg: '.$inText
                            .'msg" value="'.$o->kpMsg.'" /></li></form></ul>';
                    }
                } while ($o = $r->object());

                echo '</ul>';
            }


			the_bootstrap_content_nav( 'nav-below' );
		}
		else {
			get_template_part( '/partials/content', 'not-found' );
		}
	
		tha_content_bottom(); ?>
	</div><!-- #content -->
	<?php tha_content_after(); ?>
</section><!-- #primary -->

<?php
get_sidebar();
get_footer();


/* End of file index.php */
/* Location: ./wp-content/themes/the-bootstrap/index.php */