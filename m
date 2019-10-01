Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F74C2EF6
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Oct 2019 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfJAIgD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Oct 2019 04:36:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47066 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfJAIgC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:36:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so9141010lfc.13
        for <netfilter-devel@vger.kernel.org>; Tue, 01 Oct 2019 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unkJWrvlaUGtQlZ+tkKquRMMOnWhl9NAO+tFvbfGPYU=;
        b=kKplD2cgKWS//tNj5H/8v4+zdimmskBM9pr4+mBaot4EXFTz+EK/xBOSv0iDeCdA7s
         N3RpZOSjkByx3afhrNe1ljWYfqG2e622bbCn5rceYu6PkB2L1vf8WMtBXl+0XBSATF8C
         zft9bv3gln0fhpkMgosAnp9Y0/i4KznkB4emJrz97Ck5DvRF/mOM5yx9h3zgxxN3+K+U
         4yrG0NGjWuJh+n7Sq646mQj3BmAVPjIw/BYeb25RBX86tWNslfBqTg5nGd9w5hglV9gs
         FrTqhRdP2xROgax3/JA28d3IV/I1RugueuDXe1bJ8+2T4eDse6TihAF8fxPqLVeISPyB
         VMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unkJWrvlaUGtQlZ+tkKquRMMOnWhl9NAO+tFvbfGPYU=;
        b=SKtfHUDeJ3kwBpoaugq098ZEiMVCndRweDQUAhq8F+EY1mw+ITRlndA1Zg34e5ysuK
         7kvKav/C3Hg3YQMMFlIlYIklscAPI1RxwcXlhRA4J6bJB6rFzMphMc37QcUPps/cpQC1
         yThUROplx2O3ZWIqweTBepMefBbxBU6pNyL9sWaxVwXUCznrvhAHyA6oeV2XDrm9CEam
         39BoMHmfqMaq9G25lOqXZEmVylsQyrbx91OM9v4ykOkJJxwwSIwdnBRsIm7Eb7mSrg61
         NzokrapyNIwiAA/QatZ4iFJfvcKVuyoQN0Bp1+74bN+C19SAn3PWz+d/GXC1NAlVxZdI
         TNWA==
X-Gm-Message-State: APjAAAWlj5dfE0/i4XuZ+WHo78VlMYDbOeTEJrlLeqHocy4IjsdY5mxi
        eZ85fdvt3cs/iH56NsW/Dklc0kxTN1EDDvyidms/q3/M
X-Google-Smtp-Source: APXvYqyflD0gYBeqWq4P819Yb9qxTAaImuGETh5ymc48e3c9F6Rml/OXq2jyVjTqJEVzqK8gKqAw6wo0P1lcOt38DgA=
X-Received: by 2002:a19:9145:: with SMTP id y5mr14261844lfj.88.1569918960790;
 Tue, 01 Oct 2019 01:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190930142741.16575-1-pablo@netfilter.org>
In-Reply-To: <20190930142741.16575-1-pablo@netfilter.org>
From:   =?UTF-8?B?QWxpbiBOxINzdGFj?= <alin.nastac@gmail.com>
Date:   Tue, 1 Oct 2019 10:35:49 +0200
Message-ID: <CAF1oqRB-vTs8hPy+2pVZ=GochiuFM9e_eb8JNATO6ye4=-w21g@mail.gmail.com>
Subject: Re: [PATCH libnetfilter_queue] checksum: Fix UDP checksum calculation
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Sep 30, 2019 at 4:29 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> The level 4 protocol is part of the UDP and TCP calculations.
> nfq_checksum_tcpudp_ipv4() was using IPPROTO_TCP in this calculation,
> which gave the wrong answer for UDP.
>
> Based on patch from Alin Nastac, and patch description from Duncan Roe.
>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

There was another issue that my patch fixed, on big endian platform
checksum is incorrectly computed when payload length is odd. You have
to include this changes as well in order to fix this:
--- a/src/extra/checksum.c
+++ b/src/extra/checksum.c
@@ -11,6 +11,7 @@

 #include <stdio.h>
 #include <stdbool.h>
+#include <endian.h>
 #include <arpa/inet.h>
 #include <netinet/ip.h>
 #include <netinet/ip6.h>
@@ -26,8 +27,13 @@ uint16_t nfq_checksum(uint32_t sum, uint16_t *buf, int size)
  sum += *buf++;
  size -= sizeof(uint16_t);
  }
- if (size)
- sum += *(uint8_t *)buf;
+ if (size) {
+#if __BYTE_ORDER == __BIG_ENDIAN
+ sum += (uint16_t)*(uint8_t *)buf << 8;
+#else
+ sum += (uint16_t)*(uint8_t *)buf;
+#endif
+ }

  sum = (sum >> 16) + (sum & 0xffff);
  sum += (sum >>16);
