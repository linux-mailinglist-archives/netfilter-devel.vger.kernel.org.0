Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C913373B6
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Mar 2021 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCKNXa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Mar 2021 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhCKNXW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:23:22 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD9FC061574
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Mar 2021 05:23:20 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lKLHa-0003gL-Bm; Thu, 11 Mar 2021 14:23:18 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 00/12] move more keywords away from initial scope
Date:   Thu, 11 Mar 2021 14:23:01 +0100
Message-Id: <20210311132313.24403-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These patches move more keywords away from the initial flex scope.
Just like the preceding patches they follow the same pattern:
 1. New scope is entered from flex when encountering a start token, e.g.
 "ip".
 2. Scope is left from bison once a complete expression has been parsed.

Unlike the initial patches which only did this for a few expressions
this series also covers tokens that can appear in object context.

Florian Westphal (12):
  scanner: ct: move to own scope
  scanner: ip: move to own scope
  scanner: ip6: move to own scope
  scanner: add fib scope
  scanner: add ether scope
  scanner: arp: move to own scope
  scanner: remove saddr/daddr from initial state
  scanner: vlan: move to own scope
  scanner: limit: move to own scope
  scanner: quota: move to own scope
  scanner: move until,over,used keywords away from init state
  scanner: secmark: move to own scope

 include/parser.h   |  10 +++
 src/parser_bison.y | 176 ++++++++++++++++++++++++---------------------
 src/scanner.l      | 122 ++++++++++++++++++-------------
 3 files changed, 177 insertions(+), 131 deletions(-)

-- 
2.26.2

