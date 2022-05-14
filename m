Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475D52730E
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 May 2022 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiENQmi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 May 2022 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiENQmh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 May 2022 12:42:37 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 May 2022 09:42:32 PDT
Received: from mail1.systemli.org (mail1.systemli.org [IPv6:2a11:7980:3::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04ACBC90
        for <netfilter-devel@vger.kernel.org>; Sat, 14 May 2022 09:42:31 -0700 (PDT)
From:   Nick Hainke <vincent@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1652546012;
        bh=6TAVRkpkmPtc5PFEsIJF/CNoa4h4IDdK4CtPfIVRcBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxMCj2XzCfWYfYHVgy6TSW0H73clO+u8RxABlWGb25v/3rZ+VRFz7LKoye1NYnLUQ
         P0tCu3WbHAARIR/91OQJpP0pIAbWwpUU0xmEp+W1NTovpNmrRSW9G+uVBzi2mflKrQ
         E1+Y0BXZXJLkZosILDlhXaiRX8EEEMDB9OWvCUciPjH3rhzOoFB/1/PVlxIDtSyqNN
         G8WVA8NpnQPLKp+o4OuIG/5Js3oGU0FbfbFVU7KW+X6/Q6E7udBp1yk2gH8V9s1dDa
         hzb/eJFZtrmBiVrAbUYWs9ThK+/d/0xDKUo7p1Xw0x3f/u6AwAnfY9DlFmAV6W5toF
         qVwykaeFCqd2w==
To:     netfilter-devel@vger.kernel.org
Cc:     Nick Hainke <vincent@systemli.org>
Subject: [PATCH iptables 2/2] xshared: fix compilation with musl
Date:   Sat, 14 May 2022 18:33:25 +0200
Message-Id: <20220514163325.54266-2-vincent@systemli.org>
In-Reply-To: <20220514163325.54266-1-vincent@systemli.org>
References: <20220514163325.54266-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Gcc complains about missing types. Include <sys/types.h> to fix it.

Fixes errors in the form of:
In file included from xtables-legacy-multi.c:5:
xshared.h:83:56: error: unknown type name 'u_int16_t'; did you mean 'uint16_t'?
   83 | set_option(unsigned int *options, unsigned int option, u_int16_t *invflg,
      |                                                        ^~~~~~~~~
      |                                                        uint16_t
make[6]: *** [Makefile:712: xtables_legacy_multi-xtables-legacy-multi.o] Error 1

Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 iptables/xshared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/iptables/xshared.h b/iptables/xshared.h
index 14568bb0..9d2fef90 100644
--- a/iptables/xshared.h
+++ b/iptables/xshared.h
@@ -4,6 +4,7 @@
 #include <limits.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <sys/types.h>
 #include <netinet/in.h>
 #include <net/if.h>
 #include <linux/netfilter_arp/arp_tables.h>
-- 
2.36.1

