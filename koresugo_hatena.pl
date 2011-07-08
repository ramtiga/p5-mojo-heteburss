#!/usr/bin/env perl
use strict;
use warnings;
use XML::Feed;
use utf8;
use Encode;
use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;
  my $feed = XML::Feed->parse( URI->new('http://b.hatena.ne.jp/t/%E3%81%93%E3%82%8C%E3%81%AF%E3%81%99%E3%81%94%E3%81%84?sort=hot&threshold=&mode=rss'))
        or die XML::Feed->errstr;
  
  $self->stash(feeds => $feed);
  $self->render("index");
};

app->start;

__DATA__
@@ index.html.ep
% layout 'default';
% title 'はてなブックマーク-「これはすごい」一覧';
<h2>これはすごい一覧 - はてなブックマーク</h1>
<div id="main">
<div id="content">
% for my $entry ($feeds->entries){
  <div id="title">
    <a href="<%= $entry->link %>" target="_blank"><%= $entry->title %></a>
    <img src="http://b.hatena.ne.jp/entry/image/<%= $entry->link %>" />
  </div>
  <div id="desc">
    <%= $entry->summary->body %>

  </div>
% }
</div>
</div>

@@ layouts/default.html.ep
<!doctype html>
  <html>
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=UTF-8">
    <%= stylesheet 'css/common.css' %>
    <title><%= title %></title>
  </head>
  <body>
    <%= content %>
  </body>
</html>
