Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716D12A4E45
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Nov 2020 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgKCSUt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Nov 2020 13:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgKCSUt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:20:49 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F007C0613D1
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Nov 2020 10:20:49 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ka0vH-0001cZ-59; Tue, 03 Nov 2020 19:20:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 0/3] json: resolve multiple test case failures
Date:   Tue,  3 Nov 2020 19:20:37 +0100
Message-Id: <20201103182040.24858-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Over the last few months nft gained a few new features and test cases
that either do not have a json test case or fail in json mode.

First two patches only touch the test cases themselves, but the snat.t
failure turned out to be due to lack of feature parity with the normal
bison parser.

Thus that patch adds needed export/import facility for nat_type
and the netmap flag.

 src/json.c                     |   43 +++++++++++++---
 src/parser_json.c              |   70 +++++++++++++++++++++++++-
 tests/py/bridge/reject.t       |    2 
 tests/py/bridge/reject.t.json  |   72 +++++++++++++++++++++++++++
 tests/py/inet/dnat.t           |    4 -
 tests/py/inet/dnat.t.json      |   55 ++++++++++++++++++++
 tests/py/inet/sets.t.json      |   74 ++++++++++++++++++++++++++++
 tests/py/ip/icmp.t.json        |    4 -
 tests/py/ip/icmp.t.json.output |    2 
 tests/py/ip/snat.t.json        |  108 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 418 insertions(+), 16 deletions(-)


