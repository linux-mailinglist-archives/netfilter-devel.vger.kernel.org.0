Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475ED4499A2
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 17:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhKHQ2b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhKHQ2b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:28:31 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22369C061570
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Nov 2021 08:25:47 -0800 (PST)
Received: from localhost ([::1]:34856 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mk7Sp-0007nL-S3; Mon, 08 Nov 2021 17:25:43 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] extensions: hashlimit: Fix tests with HZ=1000
Date:   Mon,  8 Nov 2021 17:25:35 +0100
Message-Id: <20211108162535.19522-1-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In an attempt to fix for failing hashlimit tests with HZ=100, the
expected failures were changed so they are expected to pass and the
parameters changed to seemingly fix them. Yet while the new parameters
worked on HZ=100 systems, with higher tick rates they didn't so the
observed problem moved from the test failing on HZ=100 to failing on
HZ=1000 instead.

Kernel's error message "try lower: 864000000/5" turned out to be a red
herring: The burst value does not act as a dividor but a multiplier
instead, so in order to lower the overflow-checked value, a lower burst
value must be chosen. Inded, using a burst value of 1 makes the kernel
accept the rule in both HZ=100 and HZ=1000 configurations.

Fixes: bef9dc575625a ("extensions: hashlimit: Fix tests with HZ=100")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_hashlimit.t | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/extensions/libxt_hashlimit.t b/extensions/libxt_hashlimit.t
index 8369933786f68..206d92935f2e2 100644
--- a/extensions/libxt_hashlimit.t
+++ b/extensions/libxt_hashlimit.t
@@ -3,12 +3,12 @@
 -m hashlimit --hashlimit-above 1000000/sec --hashlimit-burst 5 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-above 1/min --hashlimit-burst 5 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-above 1/hour --hashlimit-burst 5 --hashlimit-name mini1;=;OK
--m hashlimit --hashlimit-above 1/day --hashlimit-burst 500 --hashlimit-name mini1;=;OK
+-m hashlimit --hashlimit-above 1/day --hashlimit-burst 1 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-upto 1/sec --hashlimit-burst 5 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-upto 1000000/sec --hashlimit-burst 5 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-upto 1/min --hashlimit-burst 5 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-upto 1/hour --hashlimit-burst 5 --hashlimit-name mini1;=;OK
--m hashlimit --hashlimit-upto 1/day --hashlimit-burst 500 --hashlimit-name mini1;=;OK
+-m hashlimit --hashlimit-upto 1/day --hashlimit-burst 1 --hashlimit-name mini1;=;OK
 -m hashlimit --hashlimit-upto 1/sec --hashlimit-burst 1 --hashlimit-name mini1 --hashlimit-htable-expire 2000;=;OK
 -m hashlimit --hashlimit-upto 1/sec --hashlimit-burst 1 --hashlimit-mode srcip --hashlimit-name mini1 --hashlimit-htable-expire 2000;=;OK
 -m hashlimit --hashlimit-upto 1/sec --hashlimit-burst 1 --hashlimit-mode dstip --hashlimit-name mini1 --hashlimit-htable-expire 2000;=;OK
-- 
2.33.0

