package com.enonic.cms.itest.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MockHTTPServer
    extends NanoHTTPD
{

    private static final Logger LOG = LoggerFactory.getLogger( MockHTTPServer.class );

    static public String TYPE_PARAM = "type";

    static public String TEXT_TYPE = "text";

    static public String BYTE_TYPE = "byte";

    static public String XML_TYPE = "xml";

    private String responseText = "";

    private byte[] responseBytes = null;

    public MockHTTPServer( int port )
        throws IOException
    {
        super( port );
        LOG.info( "Running embedded server on http://localhost:" + port );
    }

    public Response serve( String uri, String method, Properties header, Properties params, Properties files )
    {
        String type = params.getProperty( TYPE_PARAM );
        if ( TEXT_TYPE.equals( type ) )
        {
            return new Response( NanoHTTPD.HTTP_OK, NanoHTTPD.MIME_PLAINTEXT, responseText );
        }
        else if ( XML_TYPE.equals( type ) )
        {
            return new Response( NanoHTTPD.HTTP_OK, NanoHTTPD.MIME_XML, responseText );
        }
        else if ( BYTE_TYPE.equals( type ) )
        {
            return new Response( NanoHTTPD.HTTP_OK, NanoHTTPD.MIME_XML, new ByteArrayInputStream( responseBytes ) );
        }
        else
        {
            return new Response( NanoHTTPD.HTTP_NOTIMPLEMENTED, NanoHTTPD.MIME_PLAINTEXT, "Method is not emplemented" );
        }
    }

    public void setResponseText( String text )
    {
        this.responseText = text;
    }

    public void setResponseBytes( byte[] bytes )
    {
        this.responseBytes = bytes;
    }
}
