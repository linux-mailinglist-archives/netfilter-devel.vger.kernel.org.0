Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5033146F
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 18:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCHRTG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhCHRSq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:46 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A76C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 09:18:46 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lJJWm-0000LL-4r; Mon, 08 Mar 2021 18:18:44 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/6] scanner rework part 1
Date:   Mon,  8 Mar 2021 18:18:31 +0100
Message-Id: <20210308171837.8542-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is the initial batch of patches to rework the nft scanner.
This adds a start condition stack and moves a few expressions to
use start conditions.

This first batch only comes with inclusive start conditions, i.e.
the rules in INITIAL scope are still recognized; the only change is that
the tokens moved to per-expression start conditions disappear from the
INITIAL scope.

For example, after this series 'chain mod' is no longer a syntax error
because the MOD token isn't part of the initial scope anymore.

The next set of patches (not included here) adds start conditions for ip, ip6, arp,
ether and makes saddr/daddr recognized as STRING unless part of a
'ip/ip6 ...' expression.

The plan is to introduce exclusive scopes to deal with table/chain
names, i.e. 'TABLE' and 'CHAIN' keywords switch nft into a mode where
all default rules are disabled.

This will then allow to handle really weird rulesets like

table ip chain {
	chain netdev {
		meta iifname saddr ip saddr 1.2.3.4 ...
	}

and so on.

Main motivation is to avoid breakage of existing rulesets, e.g.

table inet filter {
	chain vid {

... when a future version of nft adds a 'vid' token.

Another effect is that this reduces the need for workarounds like e.g.
'parser: allow classid as set key' and other workarounds that needed to
(re-) enable keywords in STRING context.


Florian Westphal (6):
  scanner: remove unused tokens
  scanner: introduce start condition stack
  scanner: queue: move to own scope
  scanner: ipsec: move to own scope
  scanner: rt: move to own scope
  scanner: socket: move to own scope

 include/parser.h   | 12 +++++++
 src/parser_bison.y | 41 +++++++++++-----------
 src/scanner.l      | 86 ++++++++++++++++++++++++++++++----------------
 3 files changed, 89 insertions(+), 50 deletions(-)

-- 
2.26.2

