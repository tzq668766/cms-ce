package com.enonic.cms.core.xslt.functions.portal;

import org.junit.Test;

public class CreatePageUrlFunctionTest
    extends AbstractPortalFunctionTest
{
    @Test
    public void testFunction()
        throws Exception
    {
        processTemplate( "createPageUrl" );
    }
}
