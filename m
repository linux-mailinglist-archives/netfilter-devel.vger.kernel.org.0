Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F211216035
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2020 22:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGFUXW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jul 2020 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUXV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:23:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3AC061755;
        Mon,  6 Jul 2020 13:23:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C24E120ED4AD;
        Mon,  6 Jul 2020 13:23:20 -0700 (PDT)
Date:   Mon, 06 Jul 2020 13:23:19 -0700 (PDT)
Message-Id: <20200706.132319.1942886313658107601.davem@davemloft.net>
To:     grandmaster@al2klimov.de
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        paul@paul-moore.com, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: IPv*
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200706173850.19304-1-grandmaster@al2klimov.de>
References: <20200706173850.19304-1-grandmaster@al2klimov.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Jul 2020 13:23:21 -0700 (PDT)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Mon,  6 Jul 2020 19:38:50 +0200

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied to net-next, thank you very much for doing this.
