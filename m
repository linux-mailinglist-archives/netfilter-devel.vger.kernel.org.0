Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603117BD8B6
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Oct 2023 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjJIKfL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Oct 2023 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbjJIKfK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:35:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7A9C
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Oct 2023 03:35:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-690d2e13074so3178690b3a.1
        for <netfilter-devel@vger.kernel.org>; Mon, 09 Oct 2023 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696847709; x=1697452509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qywk7MQlzijgGkjhjBs5R3JKd5Xqn4FHnYfi31GCSls=;
        b=NwIKhE2QgtVmzX4qP8P3UL+T65mu3LRdvyVoiazOOh2LYtCabLQ9nBhuH/P1OeVigw
         bUp6R99XoqY06nrqfWu2DRliqgV3ImDGFq7FRhVFwyuEfa6rwF2DS5yKZuBxCWP0c4ta
         RKwaevAktJY9jDgxjcG7Kqfph7hQ28VfdR9hO+HlAj/Rm/9ro2TsVckhrui1m2S6zCG4
         nVc1kdLKq52S0tevvg0GL/KBPN6W/HG8MVOTbTTSVKYtGbwe7HlbyvK8pXeabNODnhhx
         Zy8DaOm//CBk3WSoIlFdiYixPUqiJZPLPC5cXc0RAKPOPaijOtdoUNcYkZuG4uVdqG+j
         ekAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847709; x=1697452509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qywk7MQlzijgGkjhjBs5R3JKd5Xqn4FHnYfi31GCSls=;
        b=Je4Wtr8Fup3RmHxVpWibpMjPY7bgk/qWIUqPSpEDgxaZAqQgsiF1mLyqLyanZ0WxF6
         uFdLYDH5+thfB/CBenPzwTyUzJoq+Ao81njZRh+nHVxjmiW6NTlUQDrvNQsPKbufMtWg
         Hhx4HPdpE5rXfywX/etVjPwgmPIhLqkpqsoewdaJWyD2AdKY+yUiNLmRAC/lqBYd0+bR
         3kNOkLhQTFxN3e5X2sPcQZONs0Cuxa3a7JAF7syic4jRwbMgxXOZIup3+deNcN3T8B6u
         4zDAkDi5ZZcZ2HHo0tE1zgppX5Wzj1Q/UckhbXxOGfHO6xogUI29FepzT5XQfFuhreME
         VCLg==
X-Gm-Message-State: AOJu0Yzb6GElTfYlWhBfmLjQsj3fTwTQfjyFnOfRmyHDcq6omQ0tjp2l
        za2xHF92EdYjgKdmPflcHMQ=
X-Google-Smtp-Source: AGHT+IHu0trQaGvklRJfJNRuanIpHSQi/xKCGw3vRu2YLklsSowyxs33PbSDi5cvfWT2D2hOV/3BRw==
X-Received: by 2002:a05:6a20:548c:b0:16b:9285:69f5 with SMTP id i12-20020a056a20548c00b0016b928569f5mr8239486pzk.35.1696847709063;
        Mon, 09 Oct 2023 03:35:09 -0700 (PDT)
Received: from localhost ([219.223.232.167])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b001c625d6ffccsm9155546plk.129.2023.10.09.03.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:35:08 -0700 (PDT)
From:   Xingyuan Mo <hdthky0@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org (open list:NETFILTER)
Cc:     Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH nf 1/2] nf_tables: fix NULL pointer dereference in nft_inner_init()
Date:   Mon,  9 Oct 2023 18:34:58 +0800
Message-Id: <20231009103459.12594-1-hdthky0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We should check whether the NFTA_INNER_NUM netlink attribute is present
before accessing it, otherwise a null pointer deference error will occur.

Call Trace:
 dump_stack_lvl+0x4f/0x90
 print_report+0x3f0/0x620
 kasan_report+0xcd/0x110
 __asan_load4+0x84/0xa0
 nft_inner_init+0x128/0x2e0
 nf_tables_newrule+0x813/0x1230
 nfnetlink_rcv_batch+0xec3/0x1170
 nfnetlink_rcv+0x1e4/0x220
 netlink_unicast+0x34e/0x4b0
 netlink_sendmsg+0x45c/0x7e0
 __sys_sendto+0x355/0x370
 __x64_sys_sendto+0x84/0xa0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel header matching")
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
 net/netfilter/nft_inner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 28e2873ba24e..928312d01eb1 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -298,6 +298,7 @@ static int nft_inner_init(const struct nft_ctx *ctx,
 	int err;
 
 	if (!tb[NFTA_INNER_FLAGS] ||
+	    !tb[NFTA_INNER_NUM] ||
 	    !tb[NFTA_INNER_HDRSIZE] ||
 	    !tb[NFTA_INNER_TYPE] ||
 	    !tb[NFTA_INNER_EXPR])
-- 
2.25.1

