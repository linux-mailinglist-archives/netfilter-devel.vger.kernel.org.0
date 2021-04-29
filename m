Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7636ED22
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Apr 2021 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhD2PMi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhD2PMh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:12:37 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4FC06138B
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Apr 2021 08:11:51 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id BD6175872CAB0; Thu, 29 Apr 2021 17:11:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id BC4F360C442C2;
        Thu, 29 Apr 2021 17:11:49 +0200 (CEST)
Date:   Thu, 29 Apr 2021 17:11:49 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH] netfilter: xt_SECMARK: add new revision to fix
 structure layout
In-Reply-To: <20210429133929.20161-1-phil@nwl.cc>
Message-ID: <4q6r71np-5085-177o-15p6-r3ss3s601rp@vanv.qr>
References: <20210429133929.20161-1-phil@nwl.cc>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2021-04-29 15:39, Phil Sutter wrote:
>
>This extension breaks when trying to delete rules, add a new revision to
>fix this.
>
>diff --git a/include/uapi/linux/netfilter/xt_SECMARK.h b/include/uapi/linux/netfilter/xt_SECMARK.h
>index 1f2a708413f5d..f412c87e675c1 100644
>--- a/include/uapi/linux/netfilter/xt_SECMARK.h
>+++ b/include/uapi/linux/netfilter/xt_SECMARK.h
>@@ -20,4 +20,10 @@ struct xt_secmark_target_info {
> 	char secctx[SECMARK_SECCTX_MAX];
> };
> 
>+struct xt_secmark_tginfo {
>+	__u8 mode;
>+	char secctx[SECMARK_SECCTX_MAX];
>+	__u32 secid;
>+};

that should be struct xt_secmark_tginfo_v1.

>+		.name		= "SECMARK",
>+		.revision	= 1,
>+		.family		= NFPROTO_UNSPEC,
>+		.checkentry	= secmark_tg_check_v2,

Can't have revision=1 and then call it _v2. That's just confusing.
