use v6;

use Test;
plan 4;

use Tags;

my $t = Tags.new does Testing;
$t.page_tags_path  = 't/tags/data/page_tags/';
$t.tags_count_path = 't/tags/data/tags_count';
$t.tags_index_path = 't/tags/data/tags_index';

$t.clear;

$t.update_tags('Test_Page', 'Foo, Bar');

is( $t.read_tags_count.perl, '{"foo" => 1, "bar" => 1}', 'Simple tags counting');
is( $t.read_tags_index.perl, '{"foo" => ["Test_Page"], "bar" => ["Test_Page"]}', 'Simple tags indexing' );

$t.update_tags('Test_Page', 'Bar, Her');

is( $t.read_tags_count.perl, '{"bar" => 1, "her" => 1}', 'Tags counting after add and remove');
is( $t.read_tags_index.perl, '{"foo" => [], "bar" => ["Test_Page"], "her" => ["Test_Page"]}', 'Tags indexing after add and remove' );

$t.clear;

role Testing {
    method clear ($_:) {
        my $c = {};
        .write_tags_count($c);
        .write_tags_index($c);
        .write_page_tags('Test_Page', '');
    }
}
