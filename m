Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0EC36F867
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 12:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhD3KXR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Apr 2021 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KXR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Apr 2021 06:23:17 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10685C06174A
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 03:22:29 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lcQHx-0002Cp-6q; Fri, 30 Apr 2021 12:22:25 +0200
Date:   Fri, 30 Apr 2021 12:22:25 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH] netfilter: xt_SECMARK: add new revision to fix
 structure layout
Message-ID: <20210430102225.GV3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jan Engelhardt <jengelh@inai.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210429133929.20161-1-phil@nwl.cc>
 <4q6r71np-5085-177o-15p6-r3ss3s601rp@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4q6r71np-5085-177o-15p6-r3ss3s601rp@vanv.qr>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jan,

On Thu, Apr 29, 2021 at 05:11:49PM +0200, Jan Engelhardt wrote:
[...]
> >+struct xt_secmark_tginfo {
> >+	__u8 mode;
> >+	char secctx[SECMARK_SECCTX_MAX];
> >+	__u32 secid;
> >+};
> 
> that should be struct xt_secmark_tginfo_v1.

The v0 struct is called xt_secmark_target_info, I guess Pablo tried to
shorten the name a bit. In conforming to "the standard", I'd then go
with xt_secmark_target_info_v1 instead. Fine with you?

> >+		.name		= "SECMARK",
> >+		.revision	= 1,
> >+		.family		= NFPROTO_UNSPEC,
> >+		.checkentry	= secmark_tg_check_v2,
> 
> Can't have revision=1 and then call it _v2. That's just confusing.

ACK, I missed that.

Thanks, Phil
