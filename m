Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4654574D
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jun 2022 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbiFIWV6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Jun 2022 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiFIWV4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:21:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E054017
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jun 2022 15:21:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128-20020a25dd86000000b0066073927e92so17263466ybg.13
        for <netfilter-devel@vger.kernel.org>; Thu, 09 Jun 2022 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yboyFArx2lHvBt01l8NpldAEI3xLVVvkRY3YCO31PQs=;
        b=E9tSuZ6hKkd5R9UrAClvzMvLuSapw21MRvFh9K5m/Q4W/Ne6NP2WMWfSPzasz8wKZX
         Mng11d6Obxtbq83lWoSaFsdBiVCu3gb6X9dNoHMi3E7qOKWwZUm9cJAU6WOY5s+S4WcD
         k0KWGk2jmTkZOAqD94Ix96O/6kgOmQ/r+QpHomefwKvJ5cV0MNofmxceF2lXxoFWF6gg
         j5Cs7IkuMhKv2Pf+5++JwO5hcoMx6SP3if8FmA4NjIla9U/uK2//v1BfU0Tfe7AV8KrT
         Ey/sE8DleSJieRPHEDBL1hPn4naIWW02H/aWpnYArbukY4zZLmv4GV2t/e5g12dM+Qzj
         ZcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yboyFArx2lHvBt01l8NpldAEI3xLVVvkRY3YCO31PQs=;
        b=74/6uWfBM8MHGHPJAFGW7B9V2bm7aig6M/IJOmjSpIpqOmzjk/AxAKPrdXPG/Ns+vY
         n1i5JFoL9YUMhmf4w7BR416dYDTUy7Qr3J3x+Hq0dm7yxLZ0m2BmciGdsuksP1eZvgoR
         rEqphRbQJk9sqh1hnetGVrIi9uoRu0Vvzy2PxzIQ023N9hL5GfZyItDzNF3Bdk6649L2
         +yixMtYCAr2IZsmBFQrq/syajPtzzooOQ/XQNu1LKNDli70vE6bASchJs0ajC5yNgo/T
         fCDdIha0mfonQ16NhQFY2cvETYDZLbldDgFatrDHufqHhQv2So74TFadXnUBqUynt3qv
         plyg==
X-Gm-Message-State: AOAM533FzENllz0nWLvn57i6/89w09EUjT1ODcuIpMZNSIxQJ/Lh8SL5
        op660aVJUpFXvadWF+OuN1XocuhO
X-Google-Smtp-Source: ABdhPJzx/fiV7355Fpicwsezz0b2tB8XbCEkcbb8KPwyuPviI/0AOw7BwG+AXnNZJgmFqRPAiS2WX3p4fQ==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a81:c248:0:b0:313:3c2c:89cd with SMTP id
 t8-20020a81c248000000b003133c2c89cdmr17003210ywg.175.1654813309307; Thu, 09
 Jun 2022 15:21:49 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:31 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-13-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 12/12] netfilter: conntrack: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     isanbard@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Bill Wendling <isanbard@gmail.com>

When compiling with -Wformat, clang emits the following warnings:

net/netfilter/nf_conntrack_helper.c:168:18: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
                request_module(mod_name);
                               ^~~~~~~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 net/netfilter/nf_conntrack_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index c12a87ebc3ee..1e0424d37abc 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -165,7 +165,7 @@ nf_nat_helper_try_module_get(const char *name, u16 l3num, u8 protonum)
 	if (!nat) {
 		snprintf(mod_name, sizeof(mod_name), "%s", h->nat_mod_name);
 		rcu_read_unlock();
-		request_module(mod_name);
+		request_module("%s", mod_name);
 
 		rcu_read_lock();
 		nat = nf_conntrack_nat_helper_find(mod_name);
-- 
2.36.1.255.ge46751e96f-goog

