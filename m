Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D252981C9
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 14:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416217AbgJYNQH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416210AbgJYNQG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:16:06 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF36C0613CE
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l4PPqK2vADhMT0fcZSml2DXdVhcg9EUG6Oyc0gC6wWE=; b=T0BQBoqyw1D/EIA/LPwvT46ksc
        NWsjqmL0m6VWhP9wWlv8Xt04uZb6gYCbILWeiAh2C+hr9E8zGxiUUTp0kpR0AHb9faMmRVzVAkHgm
        Vb3tAxAepSiO4sj3MOJMdOTglUtX/Kb344f7AHNdIPlimSoJEFC/jKFB5J8NzvtbYsfaB/iacmwjO
        idhaPYKryA0syCWTIL6A3+T8oSIHYJNNClXz+WPCjH8Flckw7quRaKkxBuvcRqzmOJ25Ze+eug/7I
        Sd0LK1dlo7pjlrJkVOcmXTewvjOBScm2PphQh37DN+zbKDgw8OLwXpnATusQxw8kFqWfMN/XzIRyf
        Vpsz7ylw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kWfsS-0001SE-MA; Sun, 25 Oct 2020 13:16:04 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 01/13] pknock: pknlusr: ensure man-page is included by `make dist`.
Date:   Sun, 25 Oct 2020 13:15:47 +0000
Message-Id: <20201025131559.920038-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025131559.920038-1-jeremy@azazel.net>
References: <20201025131559.920038-1-jeremy@azazel.net>
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
 extensions/pknock/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extensions/pknock/Makefile.am b/extensions/pknock/Makefile.am
index e62c10884048..35528709aa15 100644
--- a/extensions/pknock/Makefile.am
+++ b/extensions/pknock/Makefile.am
@@ -6,4 +6,4 @@ AM_CFLAGS   = ${regular_CFLAGS} ${libxtables_CFLAGS}
 include ../../Makefile.extra
 
 sbin_PROGRAMS = pknlusr
-man_MANS = pknlusr.8
+dist_man_MANS = pknlusr.8
-- 
2.28.0

