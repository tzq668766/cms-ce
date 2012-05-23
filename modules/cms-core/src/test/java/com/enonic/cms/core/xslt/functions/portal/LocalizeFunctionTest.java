package com.enonic.cms.core.xslt.functions.portal;

import org.junit.Test;

public class LocalizeFunctionTest
    extends AbstractPortalFunctionTest
{
    @Override
    protected AbstractPortalFunction newFunction()
    {
        return new LocalizeFunction();
    }

    @Test
    public void testFunction()
        throws Exception
    {
        final PortalFunctionsMediator functions = new MockPortalFunctions();
        processTemplate( functions, "localize" );
    }
}
