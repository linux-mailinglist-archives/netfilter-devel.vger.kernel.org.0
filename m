Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9585587E4
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiFWS4R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiFWSrF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:47:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3015F017B
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 10:50:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so29593342edm.13
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQW57vLVg+cIpUtXcq/2w6YWKEsidLwLEehYvvezmuI=;
        b=ICNWm6tW/PEedlbLnX8Xg+zQDu1GI2bDhT1giaXirlPWa0lrbNnduorK0piZBJThMH
         OuOAXfonw+HceNmd1eaigWNVhRU7cFOHqdeuVoSr4iel3wfnEsikGKYhk10pUfwTcGgZ
         AusPi05LA/NEzuTsarxYel+L+3QKFHJzLT80QOVvkEpDnscWa/I+Xwg7FjzCKKistwrU
         4KF+YHjxTMzQSle2UQqVVQF54IfI52Up+8snxxW11KxM+cAF6+dRUnP5gRUiHBeuj6In
         Z44RqcVEgq17cEmDqld90Mk9Kl3RoSDRi9iS0g7MGccO0LYSY43Tg7pwM9G+G87Xen07
         V/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQW57vLVg+cIpUtXcq/2w6YWKEsidLwLEehYvvezmuI=;
        b=hTnKi7dvbrRT7V1HNarrP9b9iEEaON0KlHd16Cpbt2GIIH8VbdhTuXMRcGAud795vn
         RcbShAMpBsVsmbr5AI6PzxVz5ByH3JMuPP3sUKzeEEvMiaUOiF7ar9UGE/9Urc8/1xQc
         CbYF7/Dnz/7ujZNXINKCYhmwd++bPnMQDUzndKCtejUV2DB59xJUSURPYqo04XvFu2jQ
         G+jiv7emocLCmSsnXepFs0npHPtIN7p88zPpYS4PG+2lK+TeH//HJLVe8XMHAzWYrtSD
         Mwbk7Yihcj6gp7zJwjakNBG+j0b11EB50LrJXg/snM/Jdw+mBYhlVhk5NF3xnsYvfAeg
         QAyQ==
X-Gm-Message-State: AJIora8T9kCjeRx3FCSBq1a8hTqqTMdujwoWu3SfS/YWD3jMw1BQHTLk
        tX7+mEyckM6lZ6VHaG1pxPBKZ61XkKBq1Q==
X-Google-Smtp-Source: AGRyM1v3R4IartCb6weTWQHbRQvTkxBkzuREt6zCbr1ulIYsQECYzzq3sZGA/k2lRMK4ORp5LyTAGg==
X-Received: by 2002:a05:6402:27c6:b0:435:d24a:d061 with SMTP id c6-20020a05640227c600b00435d24ad061mr5220124ede.427.1656006632105;
        Thu, 23 Jun 2022 10:50:32 -0700 (PDT)
Received: from msennikovskii4.fkb.profitbricks.net (ip5f5bf48a.dynamic.kabel-deutschland.de. [95.91.244.138])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b004356e90d13esm119891eds.83.2022.06.23.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:50:31 -0700 (PDT)
From:   Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
To:     netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        mikhail.sennikovsky@gmail.com
Cc:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Subject: [PATCH 6/6] conntrack: fix -o save dump for unknown protocols
Date:   Thu, 23 Jun 2022 19:50:00 +0200
Message-Id: <20220623175000.49259-7-mikhail.sennikovskii@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623175000.49259-1-mikhail.sennikovskii@ionos.com>
References: <20220623175000.49259-1-mikhail.sennikovskii@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Make sure the protocol (-p) option is included in the -o save
ct entry dumps for L4 protocols unknown to the conntrack tool

Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
---
 src/conntrack.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index dca7da6..f8a228f 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -870,9 +870,18 @@ static int ct_save_snprintf(char *buf, size_t len,
 
 		ret = ct_snprintf_opts(buf + offset, len, ct, cur->print_opts);
 		BUFFER_SIZE(ret, size, len, offset);
-		break;
+		goto done_proto4;
 	}
 
+	/**
+	 * Do not use getprotobynumber here to ensure
+	 * "-o save" data incompatibility between hosts having
+	 * different /etc/protocols contents
+	 */
+	ret = snprintf(buf + offset, len, "-p %d ", l4proto);
+	BUFFER_SIZE(ret, size, len, offset);
+
+done_proto4:
 	/* skip trailing space, if any */
 	for (; size && buf[size-1] == ' '; --size)
 		buf[size-1] = '\0';
-- 
2.25.1

