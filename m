Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88AB19D6AF
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2020 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390839AbgDCM1e (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Apr 2020 08:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727927AbgDCM1e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585916852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BakXMZmPqZMJj+mIKlhQQYBfMJ93ue6ayHb8V1ny5pc=;
        b=Gzk+EJOs+9Jxh/BmLUEcIP62wuHpMkbrcaGopjx/bTLazLK30s/cuPnod2Fl2aD4F/dHAe
        qIv82jpLEeXb+eMbuh1lw6IvW9xOluJmEgYThtR8r489s+q/JAitFzKX4axooUllkQcc5I
        5afmRMQEB0p0iV0RUrXPJQ8Kz/Agsg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-U2R7hpUPM8qGoe9vluMO6g-1; Fri, 03 Apr 2020 08:27:16 -0400
X-MC-Unique: U2R7hpUPM8qGoe9vluMO6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F68107ACC7;
        Fri,  3 Apr 2020 12:27:15 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 468B61001B28;
        Fri,  3 Apr 2020 12:27:13 +0000 (UTC)
Date:   Fri, 3 Apr 2020 14:27:05 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH] segtree: bail out on concatenations
Message-ID: <20200403142705.59f2e7d7@elisabeth>
In-Reply-To: <20200403120351.cxhcdcwfpylven4k@salvia>
References: <20200402214941.60097-1-pablo@netfilter.org>
        <20200403120351.cxhcdcwfpylven4k@salvia>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 3 Apr 2020 14:03:51 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Thu, Apr 02, 2020 at 11:49:41PM +0200, Pablo Neira Ayuso wrote:
> > This patch adds a lazy check to validate that the first element is not a
> > concatenation. The segtree code does not support for concatenations,
> > bail out with EOPNOTSUPP.
> >
> >  # nft add element x y { 10.0.0.0/8 . 192.168.1.3-192.168.1.9 . 1024-65535 }
> >  Error: Could not process rule: Operation not supported
> >  add element x y { 10.0.0.0/8 . 192.168.1.3-192.168.1.9 . 1024-65535 }
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Otherwise, the segtree code barfs with:
> >
> >  BUG: invalid range expression type concat  
> 
> Hm.
> 
> I'm afraid this patch is not enough, the following ruleset crashes
> in old kernels with recent nft:
> 
> flush ruleset
> 
> table inet filter {
>         set test {
>                 type ipv4_addr . ipv4_addr . inet_service
>                 flags interval,timeout
>                 elements = { 1.1.1.1 . 2.2.2.2 . 30 ,
>                              2.2.2.2 . 3.3.3.3 . 40 ,
>                              3.3.3.3 . 4.4.4.4 . 50 }
>         }
> 
>         chain output {
>                 type filter hook output priority 0; policy accept;
>                 ip saddr . ip daddr . tcp dport @test counter
>         }
> }

First off, sorry, it didn't occur to me to run new tests on older
kernels. :/

I can't quickly run that on some older kernel right now. For my
understanding, where is it crashing?

-- 
Stefano

