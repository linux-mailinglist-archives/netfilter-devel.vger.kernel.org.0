Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091C3FB2F9
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Aug 2021 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhH3JRT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Aug 2021 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhH3JRS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:17:18 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D627C061575
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Aug 2021 02:16:25 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 9F3A55871AF15; Mon, 30 Aug 2021 11:16:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 9E66761032CCB;
        Mon, 30 Aug 2021 11:16:22 +0200 (CEST)
Date:   Mon, 30 Aug 2021 11:16:22 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     "a.wojcik hyp.home.pl" <a.wojcik@hyp.home.pl>
cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Patch for iptables v 1.8.7 mac extension
In-Reply-To: <680249120.4405960.1630312157715@poczta.home.pl>
Message-ID: <32np9833-6qp2-n779-r745-s1344rn86193@vanv.qr>
References: <680249120.4405960.1630312157715@poczta.home.pl>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2021-08-30 10:29, a.wojcik hyp.home.pl wrote:

>Hi.
>In iptables version 1.8.7 mac extension sticks words together.
>Title: Patch for libxt_mac.c
>Description: Extension mac in iptables v 1.8.7 sticks words together
>Best Regards.
>Adam Wójcik

>@@ -55,7 +55,7 @@ static void mac_save(const void *ip, const struct xt_entry_match *match)
> 	const struct xt_mac_info *info = (void *)match->data;
> 
> 	if (info->invert)
>-		printf(" !");
>+		printf(" ! ");
> 
> 	printf(" --mac-source ");
> 	xtables_print_mac(info->srcaddr);

At least in this one instance, it's rather obvious you now have two spaces
after !.
