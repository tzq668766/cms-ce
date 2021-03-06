package com.enonic.cms.framework.cache.event;

public interface CacheEventPublisher
{
    public void publishEvictByKey( String cacheName, String key );

    public void publishEvictByGroup( String cacheName, String group );

    public void publishEvictByPrefix( String cacheName, String prefix );

    public void publishEvictAll( String cacheName );
}
