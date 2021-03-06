package com.enonic.cms.core.portal.datasource.el;

import org.springframework.expression.ParserContext;

/**
 * support for ${} format. SPEL by default uses #{} format
 */
final class TemplateParserContext
    implements ParserContext
{
    public String getExpressionPrefix()
    {
        return "${";
    }

    public String getExpressionSuffix()
    {
        return "}";
    }

    public boolean isTemplate()
    {
        return true;
    }
}
