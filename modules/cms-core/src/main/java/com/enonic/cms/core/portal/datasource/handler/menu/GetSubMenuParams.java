package com.enonic.cms.core.portal.datasource.handler.menu;

import javax.annotation.Nonnull;

public final class GetSubMenuParams
{
    @Nonnull
    public Integer menuItemKey;

    public int tagItem = -1;

    public int levels = 0;
}
