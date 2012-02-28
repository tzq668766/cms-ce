package com.enonic.cms.core.plugin;

import java.io.File;
import java.util.List;

public interface PluginManager
{
    public List<PluginHandle> getPlugins();

    public ExtensionSet getExtensions();

    public PluginHandle findPluginByKey( long key );

    public void install( File file );

    public void uninstall( File file );
}
