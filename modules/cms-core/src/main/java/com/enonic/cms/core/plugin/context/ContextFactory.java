package com.enonic.cms.core.plugin.context;

import org.osgi.framework.BundleContext;

public interface ContextFactory
{
    public void register( BundleContext context );
}
