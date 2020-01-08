Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2713442D
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jan 2020 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgAHNpJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jan 2020 08:45:09 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48538 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAHNpJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:45:09 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ipBe0-0003qY-4J; Wed, 08 Jan 2020 14:45:08 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [RFC nf-next 0/4] netfilter: conntrack: allow insertion of clashing entries
Date:   Wed,  8 Jan 2020 14:44:56 +0100
Message-Id: <20200108134500.31727-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series allows conntrack to insert a duplicate conntrack entry
if the reply direction doesn't result in a clash with a different
original connection.

Background:

kubernetes creates load-balancing rules for DNS using
-m statistics, e.g.:
-p udp --dport 53 -m statistics --mode random ... -j DNAT --to-destination x
-p udp --dport 53 -m statistics --mode random ... -j DNAT --to-destination y

When the resolver sends an A and AAAA request back-to-back from
different threads on the same socket, this has a high chance of a connection
tracking clash at insertion time.

This in turn results in a drop of the clashing udp packet which then
results in a 5 second DNS timeout.

The clash cannot be resolved with the current logic because the
two conntracks entries have different NAT transformations, the first one
from s:highport to x.53, the second from s:highport to y.53.

One solution is to change rules to use a consistent mapping, e.g.
using -m cluster or nftables 'jhash' expression.  This would cause
the A and AAAA requests coming from same socket to match the same
rule and thus share the same NAT information.

This change adds a second clash resolution/drop avoidance step:
A clashing entry will be added anyway provided the reply direction
is unique.

Because this results in duplicate conntrack entries for the original
direction, this comes with strings attached:
1. The clashed conntrack entry will only be around for 3 seconds
2. The clashed entry will still fail to be inserted if hash
   chain grew too large.

This entire series isn't nice but so far I did not find a better
solution.

Comments welcome.


