Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBF46BF12
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Dec 2021 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhLGPUi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Dec 2021 10:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhLGPUh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:20:37 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C44C061756
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Dec 2021 07:17:07 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mucDI-0001kV-QY; Tue, 07 Dec 2021 16:17:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/4] second batch of typeof fixes
Date:   Tue,  7 Dec 2021 16:16:55 +0100
Message-Id: <20211207151659.5507-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series makes typeof-sets work in corner cases such as

set s4 { typeof frag frag-off }
set s8 { typeof ip version }

frag frag-off @s4 accept
ip version @s8

Due to the shift/mask expressions needed to cope with these
delinearization can't figure out the correct payload/exthdr templates
and nft lists this as:

(frag unknown & 0xfff8 [invalid type]) >> 3 == @s4
(ip l4proto & pfsync) >> 4 == @s8

With this series, the mask/shift expressions are removed and
nft can print them in a readable way.

Florian Westphal (4):
  tests: add shift+and typeof test cases
  payload: skip templates with meta key set
  netlink_delinearize: and/shift postprocessing
  netlink_delinearize: zero shift removal

 src/netlink_delinearize.c                  | 28 +++++++++++++++++++
 src/payload.c                              |  3 ++
 .../testcases/sets/dumps/typeof_sets_0.nft | 23 +++++++++++++++
 tests/shell/testcases/sets/typeof_sets_0   | 22 +++++++++++++++
 4 files changed, 76 insertions(+)
-- 
2.32.0

