#! /usr/bin/env swipl
% vim: ft=prolog

:- module(zelda_scrape, [scrape/3,
                         zelda_sites/1,
                         zelda_image/2,
                         zelda_images/2,
                         zelda_all_images/2]).

:- use_module(library(http/http_open)). % http_open/3
:- use_module(library(sgml)). % load_html/3
:- use_module(library(xpath)). % xpath/3
:- use_module(library(apply)). % maplist/3, foldl/4
:- use_module(library(ordsets)). % ord_union/3
:- use_module(library(url)). % is_absolute_url/1
:- use_module(library(uri)). % uri_resolve/3

:- initialization(main, main).

scrape(Site, Path, Result) :-
    http_open(Site, S, []),
    load_html(stream(S), DOM, []),
    xpath(DOM, Path, Result).

zelda_sites([
    'https://www.zeldadungeon.net/breath-of-the-wild-walkthrough/great-plateau/',
    'https://www.zeldadungeon.net/breath-of-the-wild-walkthrough/dueling-peaks/'
    ]).

zelda_image(Site, Link) :-
    scrape(Site, //img(@src), ImageLink),
    (
        % transform stuff like /a/relative/server/path
        % to Site/a/relative/server/path
        \+ is_absolute_url(ImageLink),
        uri_resolve(ImageLink, Site, Link)
    ;
        % otherwise keep as is
        is_absolute_url(ImageLink),
        ImageLink = Link
    ).

zelda_images(Site, Links_Set) :-
    setof(Link, zelda_image(Site, Link), Links_Set).

zelda_all_images(Sites, Links_Set) :-
    maplist(zelda_images, Sites, List_Of_Links),
    foldl(ord_union, List_Of_Links, [], Links_Set).

run(Output) :-
    zelda_sites(Sites),
    zelda_all_images(Sites, Images),
    % length(Images, N),
    Output = Images.

main(_) :-
    run(Output),
    maplist(format('~w~n'), Output).
