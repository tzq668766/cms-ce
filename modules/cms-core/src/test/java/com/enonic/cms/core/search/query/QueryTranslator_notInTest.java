package com.enonic.cms.core.search.query;

import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.junit.Test;

import com.enonic.cms.core.content.index.ContentIndexQuery;

public class QueryTranslator_notInTest
    extends QueryTranslatorTestBase
{
    @Test
    public void testNotIn_string()
        throws Exception
    {
        String expected_search_result = "{\n" +
            "  \"from\" : 0,\n" +
            "  \"size\" : " + ContentIndexQuery.DEFAULT_COUNT + ",\n" +
            "  \"query\" : {\n" +
            "    \"filtered\" : {\n" +
            "      \"query\" : {\n" +
            "        \"bool\" : {\n" +
            "          \"must\" : {\n" +
            "            \"match_all\" : { }\n" +
            "          },\n" +
            "          \"must_not\" : {\n" +
            "            \"bool\" : {\n" +
            "              \"should\" : [ {\n" +
            "                \"term\" : {\n" +
            "                  \"title\" : \"hello\"\n" +
            "                }\n" +
            "              }, {\n" +
            "                \"term\" : {\n" +
            "                  \"title\" : \"test 2\"\n" +
            "                }\n" +
            "              }, {\n" +
            "                \"term\" : {\n" +
            "                  \"title\" : \"my testcontent\"\n" +
            "                }\n" +
            "              } ]\n" +
            "            }\n" +
            "          }\n" +
            "        }\n" +
            "      }\n" +
            "    }\n" +
            "  }\n" +
            "}";

        ContentIndexQuery query = createContentQuery( "title NOT IN (\"Hello\", \"Test 2\", \"my testcontent\")" );

        SearchSourceBuilder builder = getQueryTranslator().build( query );

        compareStringsIgnoreFormatting( expected_search_result, builder.toString() );
    }

    @Test
    public void testNotIn_int()
        throws Exception
    {
        String expected_search_result = "{\n" +
            "  \"from\" : 0,\n" +
            "  \"size\" : " + ContentIndexQuery.DEFAULT_COUNT + ",\n" +
            "  \"query\" : {\n" +
            "    \"filtered\" : {\n" +
            "      \"query\" : {\n" +
            "        \"bool\" : {\n" +
            "          \"must\" : {\n" +
            "            \"match_all\" : { }\n" +
            "          },\n" +
            "          \"must_not\" : {\n" +
            "            \"bool\" : {\n" +
            "              \"should\" : [ {\n" +
            "                \"term\" : {\n" +
            "                  \"myintfield.number\" : 1.0\n" +
            "                }\n" +
            "              }, {\n" +
            "                \"term\" : {\n" +
            "                  \"myintfield.number\" : 2.0\n" +
            "                }\n" +
            "              }, {\n" +
            "                \"term\" : {\n" +
            "                  \"myintfield.number\" : 3.0\n" +
            "                }\n" +
            "              } ]\n" +
            "            }\n" +
            "          }\n" +
            "        }\n" +
            "      }\n" +
            "    }\n" +
            "  }\n" +
            "}";

        ContentIndexQuery query = createContentQuery( "myIntField NOT IN (1, 2, 3)" );

        SearchSourceBuilder builder = getQueryTranslator().build( query );

        compareStringsIgnoreFormatting( expected_search_result, builder.toString() );
    }
}
