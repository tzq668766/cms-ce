package com.enonic.cms.core.xslt.admin;

import javax.xml.transform.Transformer;

import com.enonic.cms.core.xslt.base.SaxonXsltProcessor;

final class AdminXsltProcessorImpl
    extends SaxonXsltProcessor
    implements AdminXsltProcessor
{
    public AdminXsltProcessorImpl( final Transformer transformer )
    {
        super( transformer );
    }
}
