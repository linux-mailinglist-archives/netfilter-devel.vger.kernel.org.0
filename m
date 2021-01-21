Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADE2FEC68
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Jan 2021 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbhAUN4f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Jan 2021 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbhAUNz6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:55:58 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3CC061575
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Jan 2021 05:55:17 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l2aQd-00046x-9M; Thu, 21 Jan 2021 14:55:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/4] json test case fixups
Date:   Thu, 21 Jan 2021 14:55:06 +0100
Message-Id: <20210121135510.14941-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

json tests fail in several cases because test files were out of data.
This refreshs them.

One bug is genuine: in limit statement, json parser should treat
a missing burst as 5, not 0.

Florian Westphal (4):
  json: fix icmpv6.t test cases
  json: limit: set default burst to 5
  json: ct: add missing rule
  json: icmp: refresh json output

 src/parser_json.c                 |   2 +-
 tests/py/ip/ct.t.json             |  30 ++
 tests/py/ip/icmp.t.json           | 648 ++++++++++++++++++++++++++----
 tests/py/ip6/icmpv6.t.json        |  27 +-
 tests/py/ip6/icmpv6.t.json.output | 586 ++++++++++++++++++++++++++-
 5 files changed, 1196 insertions(+), 97 deletions(-)

-- 
2.26.2

