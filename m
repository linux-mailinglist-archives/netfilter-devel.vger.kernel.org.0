Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7E2BC5F7
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKVOFg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 09:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgKVOFf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:05:35 -0500
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA125C0613D3
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gGYi/OioWcF2vAWjo2xLD7tjKuxSfH1V2xu9hBCeg6w=; b=CTV6MxglL3DPkxxea37BEcVBTG
        v1kGghjOQSzNf6E/XDsHD8P0atgHCiuZMMamtkftQEONynN3cC7S3I5ssxBW5N9xVuF7coCjOzk2O
        4bmiaHD3Mr81FlPt0S9dj8psjn5fmqtPLcB1poZX/jl7guY+8KlDH8y/QUwLGswB4C7VVi9Koq0u1
        UvH5fZR5cuNmz6NQPIcfFHgnWd6OYbVe/JR+Cj3N/N5axhEb6q5Y3eB8ngkppQh0/a7CIaY8lY1ps
        0qTuKJEQV1elMt2KJJ9bMjxBuY3152gY0ErMjCGUzYhZRpo31hGGq4VFTeVg9f60im1MvySGg6+U6
        4RKSZkPw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kgpzh-0002wq-Ab; Sun, 22 Nov 2020 14:05:33 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons 2/4] geoip: fix man-page typo'.
Date:   Sun, 22 Nov 2020 14:05:28 +0000
Message-Id: <20201122140530.250248-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122140530.250248-1-jeremy@azazel.net>
References: <20201122140530.250248-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 geoip/xt_geoip_fetch.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/geoip/xt_geoip_fetch.1 b/geoip/xt_geoip_fetch.1
index 7280c74b9ab5..5d1ae48ae42e 100644
--- a/geoip/xt_geoip_fetch.1
+++ b/geoip/xt_geoip_fetch.1
@@ -9,7 +9,7 @@ xt_geoip_fetch \(em dump a country database to stdout
 .SH Description
 .PP
 xt_geoip_fetch unpacks a country's IPv4 or IPv6 databases and dumps
-them to standard output as a sorted, non-overlaping list of ranges (which
+them to standard output as a sorted, non-overlapping list of ranges (which
 is how they're represented in the database) suitable for browsing or
 further processing.
 .PP Options
-- 
2.29.2

