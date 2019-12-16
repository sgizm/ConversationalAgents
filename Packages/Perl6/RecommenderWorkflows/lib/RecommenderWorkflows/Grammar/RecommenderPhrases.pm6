use v6;

use RecommenderWorkflows::Grammar::FuzzyMatch;
use RecommenderWorkflows::Grammar::CommonParts;

# Recommender specific phrases
role RecommenderWorkflows::Grammar::RecommenderPhrases does RecommenderWorkflows::Grammar::CommonParts {
    token word-spec { \w+ }

    # Proto tokens
    token recommend-slot { 'recommend' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommend') }> | 'suggest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'suggest') }> }

    proto token item-slot { * }
    token item-slot:sym<item> { 'item' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'item') }> }

    proto token items-slot { * }
    token items-slot:sym<items> { 'items' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'items') }> }

    proto token consumption-slot { * }
    token consumption-slot:sym<consumption> { 'consumption' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'consumption') }> }

    proto token history-slot { * }
    token history-slot:sym<history> { 'history' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'history' ) }> }

    proto token profile-slot { * }
    token profile-slot:sym<profile> { 'profile' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'profile' ) }> }

    # Regular tokens / rules
    rule history-phrase { [ <item-slot> ]? <history-slot> }
    rule consumption-profile { <consumption-slot>? 'profile' }
    rule consumption-history { <consumption-slot>? <history-slot> }
    token recommend-directive { <recommend-slot> }
    token recommendation { 'recommendation' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommendation') }> }
    token recommendations { 'recommendations' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommendations') }> }
    token recommender { 'recommender' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommender') }> }
    token recommended { 'recommended' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommended') }> }
    token matrix { 'matrix' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'matrix') }> }
    token matrices { 'matrices' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'matrices') }> }
    token sparse { 'sparse' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'sparse') }> }
    rule recommender-object { <recommender> [ <object> | <system> ]? | 'smr' }
    rule recommended-items { <recommended> <items-slot> | [ <recommendations> | <recommendation> ]  <.results>?  }
    rule recommendation-results { [ <recommendation> | <recommendations> | 'recommendation\'s' ] <results> }
    rule recommendation-matrix { [ <recommendation> | <recommender> ]? <matrix> }
    rule recommendation-matrices { [ <recommendation> | <recommender> ]? <matrices> }
    rule sparse-matrix { <sparse> <matrix> }
    token column { 'column' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'column') }> }
    token columns { 'columns' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'columns') }> }
    token row { 'row' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'row') }> }
    token rows { 'rows' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'rows') }> }
    token dimensions { 'dimensions' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'dimensions') }> }
    token density { 'density' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'density') }> }
    rule most-relevant { 'most' 'relevant' }
    rule tag-type { 'tag' 'type' }
    rule tag-types { 'tag' 'types' }
    token nearest { 'nearest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'nearest') }> }
    token neighbors { 'neighbors' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'neighbors') }> }
    rule nearest-neighbors { <nearest> <neighbors> | 'nns' }
    token outlier { 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token outliers { 'outliers' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outliers') }> | 'outlier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'outlier') }> }
    token anomaly { 'anomaly' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomaly') }> }
    token anomalies { 'anomalies' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'anomalies') }> }
    token threshold { 'threshold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'threshold') }> }
    token identifier { 'identifier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'identifier') }> }
    token proximity { 'proximity' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'proximity') }> }
    token aggregation { 'aggregation' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'aggregation') }> }
    token aggregate { 'aggregate' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'aggregate') }> }
    token function { 'function' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'function') }> }
    token property { 'property' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'property') }> }
    token properties { 'properties' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'properties') }> }

    # LSA specific
    token document { 'document' }
    token latent { 'latent' }
    token semantic { 'semantic' }
    token analysis { 'analysis' }
    token indexing { 'indexing' }
    token ingest { 'ingest' | 'load' | 'use' | 'get' }
    # token threshold { 'threshold' }
    # token identifier { 'identifier' }
    token weight { 'weight' }
    token term { 'term' }
    token word { 'word' }
    token item { 'item' } # For some reason using <item> below gives the error: "Too many positionals passed; expected 1 argument but got 2".
    token entries { 'entries' }
    # token matrix { 'matrix' }

    rule lsa-object { <lsa-phrase>? 'object' }
    rule lsa-phrase { <latent> <semantic> <analysis> | 'lsa' | 'LSA' }
    rule lsi-phrase { <latent> <semantic> <indexing> | 'lsi' | 'LSI' }
    rule doc-term-mat { [ <document> | 'item' ] [ <term> | <word> ] <matrix> }
    rule matrix-entries { [ <doc-term-mat> | <matrix> ]? <entries> }
    rule the-outliers { <the-determiner> <outliers> }

    # LSI specific
    token normalization { 'normalization' }
    token normalizing { 'normalizing' }
    token normalizer { 'normalizer' }
    token global { 'global' }
    token local { 'local' }
    # token function { 'function' }
    token functions { 'function' | 'functions' }
    token frequency { 'frequency' }
    rule global-function-phrase { <global> <term> ?<weight>? <function> }
    rule local-function-phrase { <local> <term>? <weight>? <function> }
    rule normalizer-function-phrase { [ <normalizer> | <normalizing> | <normalization> ] <term>? <weight>? <function>? }

}
