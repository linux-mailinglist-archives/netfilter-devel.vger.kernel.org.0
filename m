Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7BD5361
	for <lists+netfilter-devel@lfdr.de>; Sun, 13 Oct 2019 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJMANZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Oct 2019 20:13:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44470 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfJMANZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:13:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so10976367oie.11
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Oct 2019 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmussen.co.za; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=1+4b292GOM9/VOSFBCpcQKmQU9mq1jNxWAlIW22T1yM=;
        b=rDWLr58DNM7II2IkVI47XVypNTJnU3fMmnzVuA35fN02X3hW5TaDa1Fx8oURTEcOzS
         S+vu253q1tWaDCkKASSgxXShwltyXxN6Q/ScRRPdtQVfBpkhf8db+vRNnYH4NovXt9WK
         trRAUlNDvW2WqpodO6tAu1djvFP1tKuL+zA7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1+4b292GOM9/VOSFBCpcQKmQU9mq1jNxWAlIW22T1yM=;
        b=pyckWGPSQLlF+7DBAAgmqTiKAMlSkiKTKWscQmjHgT+7tm+Hl6QdxhNxDjxffMNVOf
         qDH0xXktVh0ESJ6f8Ow7ZDVSXbGt56fptlVbgnl8/uQQiL2WSqbc7rv3dsrLK90Vyyhj
         zOlAWA4bihM9gMTbtYIvBM7NetvtFIZeXcbglXewvNfKSB21FPkDu84Cd7dgA7S+NAJR
         KeZCkYxIiowwZzRLLoWhyyjADp17yW7TVgGG2WbkhzA4znsMjM9kb4dT0D1eVGj9jcqF
         1xNFduPTVLJ4KmVmjMCjfQNXd/1FKqcE4AqBEklyW5ISwAijmdDpq+B+EEnmtFOmWLcq
         WLfg==
X-Gm-Message-State: APjAAAVH1W5yQjnOVJ9rhDWQSGPrPJ7iQhejYneMgzHGbufQESozz6UP
        SJTJokv51sPmG4iBrxEqbLQIJF3jzGeGPwxswUKCpzlnJ5M=
X-Google-Smtp-Source: APXvYqxniF8KojrJq27jl7P0g/wzLNNAs7KCtuZks1xDri1M2P2d2RakuW/DrCayD5dxV1Zg8mZyy7HfnEqOAyMUdrE=
X-Received: by 2002:aca:5714:: with SMTP id l20mr17897512oib.175.1570925604040;
 Sat, 12 Oct 2019 17:13:24 -0700 (PDT)
MIME-Version: 1.0
From:   Norman Rasmussen <norman@rasmussen.co.za>
Date:   Sat, 12 Oct 2019 17:13:12 -0700
Message-ID: <CAGF1phamt2yiip0XrRT7TWYb9hQFPgjzP7QHCdByHDCMpxDoyQ@mail.gmail.com>
Subject: [PATCH trivial] netfilter: nft_tproxy: Fix typo in IPv6 module description.
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Norman Rasmussen <norman@rasmussen.co.za>
---
 net/ipv6/netfilter/nf_tproxy_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/nf_tproxy_ipv6.c
b/net/ipv6/netfilter/nf_tproxy_ipv6.c
index 34d51cd42..6bac68fb2 100644
--- a/net/ipv6/netfilter/nf_tproxy_ipv6.c
+++ b/net/ipv6/netfilter/nf_tproxy_ipv6.c
@@ -150,4 +150,4 @@ EXPORT_SYMBOL_GPL(nf_tproxy_get_sock_v6);

 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Balazs Scheidler, Krisztian Kovacs");
-MODULE_DESCRIPTION("Netfilter IPv4 transparent proxy support");
+MODULE_DESCRIPTION("Netfilter IPv6 transparent proxy support");
-- 
2.19.2
