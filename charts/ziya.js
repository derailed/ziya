// Embed chart in a site
function ziya_micro( host_url, callback_url, size, background )
{ 
   var html = "";
   html += ziya_setup( host_url );
   html += ziya_gen( host_url, callback_url, size, background );
   
   document.write( html );
}

// setup js script
function ziya_setup( host_url )
{
    var html = "";
    html += "<script language=\"javascript\" type=\"text/javascript\">";
    html += "AC_FL_RunContent = 0;";
    html += "DetectFlashVer   = 0;";
    html += "</script>";

    html += "<script src=\"" + host_url + "/AC_RunActiveContent.js\" language=\"javascript\" type=\"text/javascript\"></script>";
    html += "<script language=\"javascript\" type=\"text/javascript\">";
    html += "var requiredMajorVersion = 9;"
    html += "var requiredMinorVersion = 0;"
    html += "var requiredRevision     = 45;"
    html += "</script>"    
    return html;
}

function ziya_gen( host_url, callback_url, size, background )
{
    var tokens = size.split( "x" );
    var width  = tokens[0];
    var height = tokens[1];
    var html = "";
    html += "<script language=\"javascript\" type=\"text/javascript\">";
    html +=  "var hasRightVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);";
    html +=  "if( hasRightVersion ) {";
    html +=  "AC_FL_RunContent(";
    html +=  "'codebase'         , 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0',";
    html +=  "'width'            , '" + width + "',";
    html +=  "'height'           , '" + height + "}',";
    html +=  "'scale'            , 'noscale',";
    html +=  "'salign'           , 'tl',";
    html +=  "'bgcolor'          , '" + background + "',";
    html +=  "'wmode'            , 'opaque',";
    html +=  "'movie'            , '" + host_url + "/charts',";
    html +=  "'src'              , '" + host_url + "/charts',";
    html +=  "'FlashVars'        , 'library_path=" + host_url + "/charts_library&xml_source=" + escape( callback_url ) + "',";
    html +=  "'id'               , 'chart',";
    html +=  "'name'             , 'chart}',";
    html +=  "'allowScriptAccess','sameDomain',";
    html +=  "'quality'          , 'high',";
    html +=  "'align'            , 'l',";
    html +=  "'pluginspage'      , 'http://www.macromedia.com/go/getflashplayer',";
    html +=  "'play'             , 'true',";
    html +=  "'devicefont'       , 'false'";
    html += ");";
    html += "}";
    html += "else {";
    html += "var alternateContent = 'This content requires the Adobe Flash Player. '";
    html += "+ '<u><a href=http://www.macromedia.com/go/getflash/>Get Flash</a></u>.';";
    html += "document.write(alternateContent);";
    html += "}";
    html += "</script>";    
    return html;
}
